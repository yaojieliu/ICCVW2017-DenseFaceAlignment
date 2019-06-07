function [A3D, landmark68] = runDeFA(im,net)
meta = net.netmeta;
%% resize input image to 128*128
try
    img = single(imresize(rgb2gray(im),[128,128]));
catch
    img = single(imresize(im,[128,128]));
end
scale = size(im,1)/128;
%% gpu mode
if meta.gpu >= 1
   im4d = gpuArray(single(img)/256) ;
else
   im4d = single(img)/256 ;
end

%% send data into network for testing
res = vl_test_simplenn(net, im4d, [], [],...
                               'accumulate', 0, ...
                               'mode', 'test', ...
                               'conserveMemory', 0, ...
                               'sync', false, ...
                               'cudnn', 1) ;
mp = reshape(res(end-1).x,[1,236]).*(meta.maxVar-meta.minVar) + meta.minVar;

%% reconstruct the face
% m
R4  = [mp(1),mp(2),mp(3),mp(4);mp(5),mp(6),mp(7),mp(8)];
s1 = sqrt(mp(1)^2+mp(2)^2+mp(3)^2);
s2 = sqrt(mp(5)^2+mp(6)^2+mp(7)^2);
s3 = (s1 + s2) /2;
R4(3,:) = [s3*cross(R4(1,1:3)/s1,R4(2,1:3)/s2),0];
% p
Am = meta.mshape;
p = mp(9:236)';
for i = 1:199
    Am = Am + p(i)*meta.idshape(:,i);
end
for i = 1:29
    Am = Am + p(i+199)*meta.expshape(:,i);
end
% shape 
Am = reshape(Am,3,length(Am)/3);
A4 = ones(4,53215);
A4(1:3,:) = Am;
A3D = R4 * A4(:,:);
A3D(2,:) = 128 - A3D(2,:) + 1; 
A3D = A3D * scale;
landmark68 = A3D(1:2,meta.v3d);