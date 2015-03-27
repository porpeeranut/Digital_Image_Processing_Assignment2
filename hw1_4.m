im = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Cross.pgm');
im_resize = imresize(im, 0.5);
fft = fftshift(fft2(im_resize));	%shift origin to center
ampitude = log(abs(fft)+1);     %start x axis at 1
ampitude = mat2gray(ampitude);   % scale 0-1

figure;
subplot(1,2,1);
imshow(ampitude);
title ('Amplitude');

subplot(1,2,2);
imagesc(angle(fft));
title('Phase spectrum');