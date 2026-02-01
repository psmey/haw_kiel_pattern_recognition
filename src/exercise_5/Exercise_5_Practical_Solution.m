% Solution to Practical Exercise Sheet 5

close all;
clear;

% Note: only 2-class data can be processed

%load the data set
%load 'D:\Matlab\toolbox1\classification\datasets\clouds.mat'
%load 'D:\Matlab\toolbox1\classification\datasets\spiral.mat'
%load 'D:\Matlab\toolbox1\classification\datasets\DHS_cover.mat'
%load 'D:\Matlab\toolbox1\classification\datasets\DHS_cover_two_classes.mat'
load "/cygdrive/d/Daten/Matlab/toolbox1/classification/datasets/twoClasses.mat"

numObs = size(patterns,2);   % number of observations
numVars = size(patterns,1);  % number of variables

% get the number of observations in each class
[B, I, J] = unique(sort(targets), "last");
numClasses = size(I,2);      % I provides the ID of the last element of each class (useful for counting the number of observations per class below
obsPerClass = zeros(1, numClasses);

I_prev = 0;
for i = 1:numClasses
    obsPerClass(i) = I(i)-I_prev;  % I: index of last element of each class in sorted list --> number of observations per class
    I_prev = I(i);
end

% number of samples in class with largest training data amount
maxNumObsPerClass = max(obsPerClass(:));

%% organize data in a cell array

% data container cell array of size "number of observations" x 3 x 2
cloud1 = cell(maxNumObsPerClass + 1, 3, 2);

% separate observations of class 1 and class 2
% logical(targets) is necessary to convert targets from double into logical
% otherwise this array can not be used as subscript indices
class1_obs = patterns(:,logical(~targets));
class2_obs = patterns(:,logical(targets));

% assign observations to respective cell array regions
cloud1(2:end, 2:end, 1) = num2cell(class1_obs)';
cloud1(2:end, 2:end, 2) = num2cell(class2_obs)';

% add sensor names to measurements
cloud1(1, 2:end, 1:2) = repmat({"Sensor1", "Sensor2"}, [1 1 2]);

% add class names
cloud1{1,1,1} = "Class 0";
cloud1{1,1,2} = "Class 1";

% add observation names
cloud1(2:end, 1, 1:2) = repmat(strcat({"Obs_"}, num2str((1:maxNumObsPerClass)', "%d")),[1 1 2]);

% show some samples of the data
%cloud1(1:10, :, :)

class1_sensor1 = cell2mat(cloud1(2:end, 2, 1));
class1_sensor2 = cell2mat(cloud1(2:end, 3, 1));
class2_sensor1 = cell2mat(cloud1(2:end, 2, 2));
class2_sensor2 = cell2mat(cloud1(2:end, 3, 2));

%% organize data in a dataset array

% generate observation names array
%ObsNames = strcat({"Obs_"}, num2str((1:numObs)', "%d"));

%cloud2 = dataset({nominal(targets', {'0', '1'}), 'Class'}, {patterns', 'Sensor1', 'Sensor2'}, 'obsnames', ObsNames);

%class1 = cloud2(cloud2.Class == '0',:);
%class2 = cloud2(cloud2.Class == '1',:);

% show some samples
%class1(1:10, :)
%class2(1:10, :)


%% model data with Gaussian density

% How would you decide on the question if a model with dependent 
% or independent components must be used to represent the data?
% --> Compute the covariance matrix and study the minor diagonal
%     elements.
%
% cov([class1_sensor1, class1_sensor2])
% ans =
%     1.5452    0.0053
%     0.0053    3.1229
% cov([class2_sensor1, class2_sensor2])
% ans =
%     1.0373    0.0154
%     0.0154    1.5965
% 
% Value of minor diagonal elements (0.0053 and 0.0154) is quite small
% --> Assumption: variables are not related 
% --> Use Gaussian model with independent components

% 1. Model variable 'a' by 2D gaussian density with independent components
pts_x = min(patterns(1,:)):0.1:max(patterns(1,:)); 
pts_y = min(patterns(2,:)):0.1:max(patterns(2,:)); 


% only for datasets
%stats = grpstats(cloud2,'Class',{@mean,@var});

% mean and standard deviation of class 1
m11 = mean(class1_sensor1);  
s11 = sqrt(var(class1_sensor1));
m12 = mean(class1_sensor2);  
s12 = sqrt(var(class1_sensor2));
px1 = exp(-0.5*((pts_x-m11)./s11).^2)./(sqrt(2*pi)*s11);
px2 = exp(-0.5*((pts_y-m12)./s12).^2)./(sqrt(2*pi)*s12);
p_x_1 = px2'*px1;

% mean and standard deviation of class 2
m21 = mean(class2_sensor1);
s21 = sqrt(var(class2_sensor1));
m22 = mean(class2_sensor2);  
s22 = sqrt(var(class2_sensor2));
px1 = exp(-0.5*((pts_x-m21)./s21).^2)./(sqrt(2*pi)*s21);
px2 = exp(-0.5*((pts_y-m22)./s22).^2)./(sqrt(2*pi)*s22);
p_x_2 = px2'*px1;

% compute the priors
p_1 = obsPerClass(1) / (obsPerClass(1) + obsPerClass(2));
p_2 = obsPerClass(2) / (obsPerClass(1) + obsPerClass(2));

%p_1 = 0.1;
%p_2 = 0.9;

% compute the evidence
p_x_1_p_1 = p_x_1 * p_1;
p_x_2_p_2 = p_x_2 * p_2;

p_x = p_x_1_p_1 + p_x_2_p_2;

% compute the posteriors
p_1_x = p_x_1_p_1 ./ p_x;
p_2_x = p_x_2_p_2 ./ p_x;

% show decision boundary

colormap([198 198 255; 240 255 240]/255);
contourf(pts_x, pts_y, p_1_x, [0.5 0.5], 'k-.');
xlabel("Sensor 1");
ylabel("Sensor 2");
hold on;
contour(pts_x, pts_y, p_x_1);
contour(pts_x, pts_y, p_x_2);
% patterns(1,:) : all signals of sensor 1
% patterns(2,:) : all signals of sensor 2
plot(class1_sensor1, class1_sensor2, "*b");
plot(class2_sensor1, class2_sensor2, "or");
axis([min(pts_x) max(pts_x) min(pts_y) max(pts_y)]);

figure(2);
xlabel("Sensor 1");
ylabel("Sensor 2");
zlabel("p(x|class)");
%mesh(pts_x, pts_y, p_x_1);
%hold on;
%C = contourf(pts_x, pts_y, p_1_x, [0.5 0.5], 'b.');
hold on;
C1 = 0.2*double(p_x_1 >= 0.01*max(p_x_1(:)) & p_x_1 > p_x_2);
C2 = 0.4*double(p_x_2 >= 0.01*max(p_x_2(:)) & p_x_2 >= p_x_1);
C = C1+C2;
surf(pts_x, pts_y, p_x_1, C);
surf(pts_x, pts_y, p_x_2, C);
%contourf(pts_x, pts_y, p_1_x, [0.5 0.5]);
view(-15,25);
grid;

% compute equal probability boundary
%figure(2);

