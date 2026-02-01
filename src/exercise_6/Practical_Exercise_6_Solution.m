% Solution to Practice Sheet 6

load('Data\test_images.mat');
load('Data\train_images.mat');
load('Data\train_labels.mat');

faceFeats = [];
nonFaceFeats = [];

imsize_x = 112;
imsize_y = 92;

%% Training
for i = 1:size(train_images,1)
    I = train_images(i,:); % get next training image from image matrix
    I = reshape(I, [imsize_x, imsize_y]); % form a matrix from row vector

    P = train_patterns(i,:); % get next label matrix
    P = reshape(P, [imsize_x, imsize_y]);

    % Convert all possible neighborhoods in image to columns (feature vectors)
    % B contains as many columns as the number of pixels in I. (This 
    % is achieved by adding zeros at the image margin.) im2col is
    % an image processing toolbox function.
    B = im2col(padarray(I, [1, 1], 0, 'both'), [3, 3], 'sliding');
    faceFeatsNew = B(:,logical(P(:)));
    nonFaceFeatsNew = B(:,~logical(P(:)));
    faceFeats = [faceFeats faceFeatsNew];
    nonFaceFeats = [nonFaceFeats nonFaceFeatsNew];
end

% Features are required in transposed format
faceFeats = faceFeats';
nonFaceFeats = nonFaceFeats';

% Compute the required parameters for Minimum-Distance and Bayes Classifier

% class 1 (faces)
MF = mean(faceFeats);
CF = cov(double(faceFeats));

% class 2 (non-faces)
MN = mean(nonFaceFeats);
CN = cov(double(nonFaceFeats));

% Compute the priors for class 1 and 2
p1 = size(find(train_patterns==1),1) / (size(find(train_patterns==1),1) + size(find(train_patterns==0),1));
p2 = 1-p1;


%% Evaluation

for i = 1:size(test_images, 1)
    % ~~~~~~ MINIMUM DISTANCE CLASSIFIER ~~~~~~~
    J = test_images(i,:); % get next image from image matrix
    J = reshape(J, [imsize_x, imsize_y]); % form a matrix from row vector
    Jfeat = im2col(padarray(J, [1, 1], 0, 'both'), [3, 3], 'sliding'); % generate feature vectors

    % For each feature vector: Compute its distance to both classes
    dist_1 = sum((double(Jfeat) - repmat(MF',[1 size(Jfeat,2)])).^2);
    dist_2 = sum((double(Jfeat) - repmat(MN',[1 size(Jfeat,2)])).^2);

    % Assign each feature vector to the class to which it has the smallest
    % distance. Face pixels will be set to 1 in the result.
    result = dist_1 < dist_2;
    % Reshape result row vector into a 2D image
    result_shaped = reshape(result, [imsize_x, imsize_y]);
    subplot(1, 2, 1), imshow(result_shaped,[]);
    title('Minimum Distance Classifier');
    
    % ~~~~~~ BAYES CLASSIFIER ~~~~~~
    % Compute the likelihoods (class-conditional probabilities) for each image
    % pixel and each class
    p_x_1 = mvnpdf(double(Jfeat'), MF, CF);
    p_x_2 = mvnpdf(double(Jfeat'), MN, CN);
 
    % Compute p_x_1_p_1 = p(x|class 1)*P(class 1)
    % and p_x_2_p_2 = p(x|class 2)*P(class 2)
    p_x_1_p_1 = p_x_1 * p1;
    p_x_2_p_2 = p_x_2 * p2;

    % Compare according to Bayes decision rule
    % Decision for class with largest discriminant
    % -> face pixels will be set to 1
    result = p_x_1_p_1 > p_x_2_p_2;

    % Reshape result row vector into a 2D image
    result_shaped = reshape(result, [imsize_x, imsize_y]);
    subplot(1, 2, 2), imshow(result_shaped,[]);
    title('Bayes Classifier');
    pause(0.2);
end

