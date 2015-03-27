im = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Cross.pgm');
one_arr = ones(size(im));
im_rotate = imrotate(im, 30, 'crop', 'bilinear');
tmp = imrotate(one_arr, 30, 'crop', 'bilinear');
im_rotate(tmp == 0) = 255;

fft = fftshift(fft2(im_rotate));	%shift origin to center
ampitude = log(abs(fft)+1);     %start x axis at 1
ampitude = mat2gray(ampitude);   % scale 0-1

figure;
imshow(im_rotate);
title ('Rotate 30 degree');

figure;
subplot(1,2,1);
imshow(ampitude);
title ('Amplitude');

subplot(1,2,2);
imshow(angle(fft));
title('Phase spectrum');