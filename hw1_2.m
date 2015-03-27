im = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Cross.pgm');
fft = fftshift(fft2(im));	%shift origin to center
ampitude = log(abs(fft)+1);     %start x axis at 1
ampitude = mat2gray(ampitude);   % scale 0-1

[u,v] = meshgrid(-100:99, -100:99);
shiftedVal = (exp(-2j*pi*( ((20*u)./200) + ((30*v)./200) ))).*fft;
im_new = ifft2(ifftshift(shiftedVal));

figure;
subplot(1,2,1);
imagesc(im);  
colormap(gray);
title('Original')

subplot(1,2,2);
imagesc(im_new);  
colormap(gray);
title('Shifted image');