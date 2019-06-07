load('PublicMM1/01_MorphableModel.mat');
load('data/Model_info.mat');
trimIndex1 = [3*trimIndex-2, 3*trimIndex-1, 3*trimIndex]';
trimIndex1 = trimIndex1(:);

mu_shape = shapeMU(trimIndex1);
w = shapePC(trimIndex1, :);
sigma = shapeEV;

tex = texMU(trimIndex1);
tex = reshape(tex, 3, length(tex)/3);

save('../data/Model_Shape.mat', 'mu_shape', 'w', 'sigma', 'tri', 'tex');


