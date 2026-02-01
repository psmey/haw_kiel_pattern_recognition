% Solution to exercise L-4.1

clear;
close all;

% load the first data set
load "/cygdrive/c/cygwin64/octave/Uebungen/Sheet4/data/a.mat";

startx = 200;
starty = 400;
width = 1000;
height = 1000;

figure(1, 'Position',[startx,starty,width,height]);

% 1. Model variable 'a' by 2D gaussian density with independent components
pts = -2:0.1:15; 
m1 = mean(a(:,1)); 
s1 = sqrt(var(a(:,1)));
m2 = mean(a(:,2));  	
s2 = sqrt(var(a(:,2)));
px1 = exp(-0.5*((pts-m1)./s1).^2)./(sqrt(2*pi)*s1);
px2 = exp(-0.5*((pts-m2)./s2).^2)./(sqrt(2*pi)*s2);
p_x1x2 = px2'*px1;

% plot points
subplot(2, 2, 1);
plot(a(:,1),a(:,2),".");

% add contour lines to the image
hold on;
contour(pts, pts, p_x1x2);
xlabel("x1");
ylabel("x2");
title("2D Gaussian distribution with independent components");

% plot mesh
subplot(2, 2, 2);
mesh(pts, pts, p_x1x2);
xlabel("x1");
ylabel("x2");
title("2D Gaussian distribution with independent components");

% 2. Model variable 'a' by 2D gaussian density with dependent components
mx = [mean(a(:,1)) mean(a(:,2))]';
Cx = cov(a);
for i=1:length(pts)
    for j=1:length(pts)
        f(i,j)=(1/(2*pi*det(Cx)^1/2))*exp((-1/2)*([pts(j) pts(i)]-mx')*inv(Cx)*([pts(j);pts(i)]-mx));
    end
end

% plot the points
subplot(2, 2, 3);
plot(a(:,1),a(:,2),".");
xlabel("x1");
ylabel("x2");
title("2D Gaussian distribution with dependent components");
hold on;

% add contour lines to the image
contour(pts,pts,f);

% plot mesh
subplot(2, 2, 4);
mesh(pts,pts,f);
xlabel("x2");
ylabel("x1");
title("2D Gaussian distribution with dependent components");

% load the second data set
load "/cygdrive/c/cygwin64/octave/Uebungen/Sheet4/data/x.mat";

figure(2, 'Position',[startx,starty,width,height]);

% 1. Model variable 'a' by 2D gaussian density with independent components
pts = -2:0.1:15; 
m1 = mean(x(:,1));  	% mean of first variable
s1 = sqrt(var(x(:,1)));	% standard deviation of first variable
m2 = mean(x(:,2));  	% mean of second variable
s2 = sqrt(var(x(:,1)));	% standard deviation of second variable
px1 = exp(-0.5*((pts-m1)./s1).^2)./(sqrt(2*pi)*s1);
px2 = exp(-0.5*((pts-m2)./s2).^2)./(sqrt(2*pi)*s2);
p_x1x2 = px2'*px1;  % column_vector * row_vector = matrix

% plot points
subplot(2, 2, 1);
plot(x(:,1),x(:,2),".");

% add contour lines to the image
hold on;
contour(pts, pts, p_x1x2);
xlabel("x1");
ylabel("x2");
title("2D Gaussian distribution with independent components");

% plot mesh
subplot(2, 2, 2);
mesh(pts, pts, p_x1x2);
xlabel("x1");
ylabel("x2");
title("2D Gaussian distribution with independent components");

% 2. Model variable 'x' by 2D gaussian density with dependent components
mx = [mean(x(:,1)) mean(x(:,2))]';
Cx = cov(x);
for i=1:length(pts)
    for j=1:length(pts)
        f(i,j)=(1/(2*pi*det(Cx)^1/2))*exp((-1/2)*([pts(j) pts(i)]-mx')*inv(Cx)*([pts(j);pts(i)]-mx));
    end
end

% plot the points
subplot(2, 2, 3);
plot(x(:,1),x(:,2),".");
xlabel("x1");
ylabel("x2");
title("2D Gaussian distribution with dependent components");
hold on;

% add contour lines to the image
contour(pts,pts,f);

% plot mesh
subplot(2, 2, 4);
mesh(pts,pts,f);
xlabel("x2");
ylabel("x1");
title("2D Gaussian distribution with dependent components");

% Model variable 'x' by summation of 2 2D gaussian densities with independent components
figure(3, 'Position',[startx,starty,width,height]);
pts = -2:0.1:15; 

% first gaussian
m1 = 5;  	% mean of first variable
s1 = sqrt(3);	% standard deviation of first variable
m2 = 7;  	% mean of second variable
s2 = sqrt(0.5);	% standard deviation of second variable
px1 = exp(-0.5*((pts-m1)./s1).^2)./(sqrt(2*pi)*s1);
px2 = exp(-0.5*((pts-m2)./s2).^2)./(sqrt(2*pi)*s2);
p_x1x2_1 = px2'*px1;  % column_vector * row_vector = matrix

% second gaussian
m1 = 3;  	
s1 = sqrt(1);
m2 = 5;  	
s2 = sqrt(2.5);	
px1 = exp(-0.5*((pts-m1)./s1).^2)./(sqrt(2*pi)*s1);
px2 = exp(-0.5*((pts-m2)./s2).^2)./(sqrt(2*pi)*s2);
p_x1x2_2 = px2'*px1;  

% adding the two gaussians (mixture density with two kernels and equal weights 0.5)
p_x1x2 = (p_x1x2_1 + p_x1x2_2)./2;

% plot points
subplot(2, 1, 1);
plot(x(:,1),x(:,2),'.');

% add contour lines to the image
hold on;
contour(pts, pts, p_x1x2);
xlabel("x1");
ylabel("x2");
title("Summation of 2 2D Gaussian distributions with independent components");

% plot mesh
subplot(2, 1, 2);
mesh(pts, pts, p_x1x2);
xlabel("x1");
ylabel("x2");
title("Summation of 2 2D Gaussian distributions with independent components");

pause;
close all;





