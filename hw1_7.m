im = imread('D:\\Google Drive\\CMU\\3rd\\semester 2\\261453 Digital Image Processing\\Assignment 2\\Chess.pgm');
[M, N] = size(im);
im_pad = padarray(im, [1 1], 'both');
im_new = zeros(size(im));
kernel = ones(3,3);
kernel = kernel/9;    %kernel
[Mk, Nk] = size(kernel);

%convolute
for i = 1:M
    for j = 1:N
        result = 0;
        for x = 1:Mk  
            for y = 1:Nk    
                tmp = double(kernel(x, y)).*double(im_pad(x+i-1, y+j-1));
                result = result+tmp;
            end
        end
        im(i, j) = double(result);
    end        
end

fft = fftshift(fft2(im));	%shift origin to center
pad_size = 256-3;
kernel_pad = padarray(kernel, [pad_size pad_size], 'post');
kernel_fft = fftshift(fft2(kernel_pad));
result = kernel_fft.*fft;
im_ifft =  ifft2(ifftshift(result));

figure;
subplot(1,2,1);
imshow(im);
title('Blur with covolution');

subplot(1,2,2);
imshow(uint8(abs(im_ifft)));
title('Blur in frequency domain');