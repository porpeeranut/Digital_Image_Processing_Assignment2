%im_noise = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Lenna_noise.pgm');
%im_original = double(imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Lenna.pgm'));
im_noise = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Chess_noise.pgm');
im_original = double(imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Chess.pgm'));
[M, N] = size(im_noise);
center_x = (M-1)/2;
center_y = (N-1)/2;
[u, v] = meshgrid(-center_x:center_x, -center_y:center_y);
D = sqrt(u.^2 + v.^2);
cutoff15 = 15;
cutoff30 = 30;
cutoff45 = 45;
fft = fftshift(fft2(im_noise));	%shift origin to center

%ideal low pass
H15 = double(D <= cutoff15);
H30 = double(D <= cutoff30);
H45 = double(D <= cutoff45);
G15 = H15.*fft;
G30 = H30.*fft;
G45 = H45.*fft;
%inverse fft
lowpass15 = real(uint8(ifft2(ifftshift(G15))));
lowpass30 = uint8(ifft2(ifftshift(G30)));
lowpass45 = uint8(ifft2(ifftshift(G45)));

% RMS ideal low pass
%cutoff 15
lowpass15_err = im_original - double(lowpass15);
MSE15 = (sum(sum(lowpass15_err.^2)))/(M * N);
RMS15 = sqrt(MSE15)
%cutoff 30
lowpass30_err = im_original - double(lowpass30);
MSE30 = (sum(sum(lowpass30_err.^2)))/(M * N);
RMS30 = sqrt(MSE30)
%cutoff 45
lowpass45_err = im_original - double(lowpass45);
MSE45 = (sum(sum(lowpass45_err.^2)))/(M * N);
RMS45 = sqrt(MSE45)

%butterworth lowpass filter
n2 = 2;
H_B15 = double(1./(1+(D./cutoff15).^(2*n2)));
H_B30 = double(1./(1+(D./cutoff30).^(2*n2)));
H_B45 = double(1./(1+(D./cutoff45).^(2*n2)));
G_B15 = H_B15.*fft;
G_B30 = H_B30.*fft;
G_B45 = H_B45.*fft;
%inverse fft
BLP15 = uint8(ifft2(ifftshift(G_B15)));
BLP30 = uint8(ifft2(ifftshift(G_B30)));
BLP45 = uint8(ifft2(ifftshift(G_B45)));

% RMS butterworth
%cutoff 15
BLP15_err = im_original - double(BLP15);
MSE15 = (sum(sum(BLP15_err.^2)))/(M * N);
RMSblp15 = sqrt(MSE15)
%cutoff 30
BLP30_err = im_original - double(BLP30);
MSE30 = (sum(sum(BLP30_err.^2)))/(M * N);
RMSblp30 = sqrt(MSE30)
%cutoff 45
BLP45_err = im_original - double(BLP45);
MSE45 = (sum(sum(BLP45_err.^2)))/(M * N);
RMSblp45 = sqrt(MSE45)

%gaussian lowpass filter 
H_G15 = double(exp((-(D).^2)./(2.*((cutoff15).^2))));
H_G30 = double(exp((-(D).^2)./(2.*((cutoff30).^2))));
H_G45 = double(exp((-(D).^2)./(2.*((cutoff45).^2))));
G_G15 = H_G15.*fft; 
G_G30 = H_G30.*fft; 
G_G45 = H_G45.*fft;
%inverse fft
GLP15 = ifft2(ifftshift(G_G15));
GLP30 = ifft2(ifftshift(G_G30));
GLP45 = ifft2(ifftshift(G_G45));

% RMS gaussian
%cutoff 15
GLP15_err = im_original - double(GLP15);
MSE15 = (sum(sum(GLP15_err.^2)))/(M * N);
RMSglp15 = sqrt(MSE15)
%cutoff 30
GLP30_err = im_original - double(GLP30);
MSE30 = (sum(sum(GLP30_err.^2)))/(M * N);
RMSglp30 = sqrt(MSE30)
%cutoff 45
GLP45_err = im_original - double(GLP45);
MSE50 = (sum(sum(GLP45_err.^2)))/(M * N);
RMSglp45 = sqrt(MSE50)

figure('Name', 'Ideal lowpass filter');
subplot(2,2,1);
imshow(im_noise);
title('original');

subplot(2,2,2);
imshow(real(lowpass15),[]);
title('cutoff 15');

subplot(2,2,3);
imshow(real(lowpass30),[]);
title('cutoff 30');

subplot(2,2,4);
imshow(real(lowpass45),[]);
title('cutoff 45');


figure('Name', 'Butterworth lowpass filter n=2');
subplot(2,2,1);
imshow(im_noise);
title('original');

subplot(2,2,2);
imshow(real(BLP15),[]);
title('cutoff 15');

subplot(2,2,3);
imshow(real(BLP30),[]);
title('cutoff 30');

subplot(2,2,4);
imshow(real(BLP45),[]);
title('cutoff 45');


figure('Name', 'Gaussian lowpass filter');
subplot(2,2,1);
imshow(im_noise);
title('original');

subplot(2,2,2);
imshow(real(GLP15),[]);
title('cutoff 15');

subplot(2,2,3);
imshow(real(GLP30),[]);
title('cutoff 30');

subplot(2,2,4);
imshow(real(GLP45),[]);
title('cutoff 45');

%im_noise = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Lenna_noise.pgm');
%im_original = double(imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Lenna.pgm'));
im_noise = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Chess_noise.pgm');
im_original = double(imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Chess.pgm'));

im_pad = padarray(im_noise, [1 1],'both');
[M, N] = size(im_noise);

for i = 1:M
    for j = 1:N
        window = zeros(9,1);
        idx=1; 
        for x = 1:3  
            for y = 1:3
                window(idx) = im_pad(x+i-1, y+j-1);
                idx = idx+1;    
            end
        end
        window = sort(window);
        im_new(i,j) = window(5);
    end        
end

%MSE
im_new = uint8(im_new);
im_original = double(im_original);
im_new_dou = double(im_new);
[M N] = size(im_original);
err = im_original - im_new_dou;
MSE = (sum(sum(err.^2)))/(M * N);
RMSmed = sqrt(MSE)

figure('Name', 'median filter');
imshow(im_new);
title('median filter');