addpath(genpath(pwd));
%% DeFA set-up
% run vl_compilenn.m %%%% uncomment if you are the first time to run this code
run vl_setupnn.m
load('data/DeFA.mat'); % For near-frontal face alignment, please load data/DeFA_Frontal.mat for better accuracy
gpuEnable = 1;
if gpuEnable
    gpuDevice % check your GPU setting
    DeFA = vl_simplenn_move(DeFA, 'gpu') ;
end
%% 3DMM set-up
try
    load('data/Model_Shape.mat');      % only need to be loaded once.
catch
    run matlab/ModelGenerate.m
end
load('Model_Expression.mat'); % only need to be loaded once.
load('Model_Para.mat');
mu = mu_shape + mu_exp;
for i = 3:3:159645;mu(i)=mu(i)-5.8713e+04;end  
for i = 2:3:159644;mu(i)=mu(i)+1.6603e+04;end  
for i = 1:3:159643;mu(i)=mu(i)+240;       end 
%% transfer to meta
meta.mshape = single(mu);
meta.idshape = single(w);
meta.expshape = single(w_exp);
meta.tri = tri;
meta.texs = tex;
meta.minVar = minVar;
meta.maxVar = maxVar;
meta.gpu = gpuEnable;
meta.v3d = v3d;
DeFA.netmeta = meta;

%% run test code
im = imread('TestImage.png'); % input should be a cropping, square face image
[A3D,landmark68] = runDeFA(im,DeFA);
% display the image
figure
subplot(131)
imshow(im)
subplot(132)
imshow(im)
hold on
plot(A3D(1,:),A3D(2,:),'g.','MarkerSize',0.1)
subplot(133)
imshow(im)
hold on
plot(landmark68(1,:),landmark68(2,:),'b.','MarkerSize',10)
