im = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Lenna.pgm');
pad_size = (256-200)/2;
im_pad = padarray(im,[pad_size pad_size],'both');
fft = fftshift(fft2(im_pad));	%shift origin to center
ampitude = abs(fft);
ampitude_ifft = ifft2(ifftshift(ampitude));
phase_ifft = ifft2(ifftshift(angle(fft)));
phase_ifft = abs(phase_ifft);

figure;
subplot(1,2,1);
ampitude_ifft = mat2gray(ampitude_ifft);   % scale 0-1
imshow(ampitude_ifft);
title('Ampitude inverse FFT');

subplot(1,2,2);
phase_ifft = mat2gray(phase_ifft);   % scale 0-1
imshow(phase_ifft);
title('Phase inverse FFT');