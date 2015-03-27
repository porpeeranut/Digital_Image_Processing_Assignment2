im = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Cross.pgm');
[M, N] = size(im);
center_x = (M-1)/2;
center_y = (N-1)/2;
[u, v] = meshgrid(-center_x:center_x, -center_y:center_y);
D = sqrt(u.^2 + v.^2);
cutoff15 = 15;
cutoff30 = 30;
cutoff45 = 45;
fft = fftshift(fft2(im));	%shift origin to center

%ideal low pass
H15 = double(D <= cutoff15);
H30 = double(D <= cutoff30);
H45 = double(D <= cutoff45);
G15 = H15.*fft;
G30 = H30.*fft;
G45 = H45.*fft;
%inverse fft
lowpass15 = ifft2(ifftshift(G15));
lowpass30 = ifft2(ifftshift(G30));
lowpass45 = ifft2(ifftshift(G45));

%butterworth lowpass filter
n2 = 2;
H_B15 = double(1./(1+(D./cutoff15).^(2*n2)));
H_B30 = double(1./(1+(D./cutoff30).^(2*n2)));
H_B45 = double(1./(1+(D./cutoff45).^(2*n2)));
G_B15 = H_B15.*fft;
G_B30 = H_B30.*fft;
G_B45 = H_B45.*fft;
%inverse fft
BLP15 = ifft2(ifftshift(G_B15));
BLP30 = ifft2(ifftshift(G_B30));
BLP45 = ifft2(ifftshift(G_B45));

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

figure('Name', 'Ideal lowpass filter');
subplot(2,2,1);
imshow(im);
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
imshow(im);
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
imshow(im);
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