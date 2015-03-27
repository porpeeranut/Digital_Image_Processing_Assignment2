im = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Cross.pgm');
pad_size = (256-200)/2;
im_pad = padarray(im,[pad_size pad_size],'both');
fft = fftshift(fft2(im_pad));	%shift origin to center
ampitude = log(abs(fft)+1);     %start x axis at 1
ampitude = mat2gray(ampitude);   % scale 0-1
phase = angle(fft);
figure; subplot(1,2,1);
imshow(ampitude);
title ('Amplitude');
subplot(1,2,2);
imagesc(phase);
title('Phase spectrum');