clc; clear; close all;

%% ==============================
% 1. GÖRÜNTÜLERÝ YÜKLE
%% ==============================
base_path = 'field10_json';
I  = imread(fullfile(base_path, 'img.png'));      % Orijinal
GT = imread(fullfile(base_path, 'label_p.jpg'));  % Ground Truth
P  = imread(fullfile(base_path, 'my.jpg'));       % Proposed

I_gray = rgb2gray(I);

%% ==============================
% 2. GT ? BINARY (KIRMIZI = vegetation)
%% ==============================
R = GT(:,:,1);
G = GT(:,:,2);
B = GT(:,:,3);

GT_bin = (R > G) & (R > B);   % kýrmýzý dominant

figure; imshow(GT_bin); title('GT Binary');

%% ==============================
% 3. PROPOSED ? BINARY (MAVÝ = vegetation)
%% ==============================
R = P(:,:,1);
G = P(:,:,2);
B = P(:,:,3);

S_prop = (B > R) & (B > G);   % mavi dominant

figure; imshow(S_prop); title('Proposed Binary');

%% ==============================
% 4. OTSU
%% ==============================
level_otsu = graythresh(I_gray);
S_otsu = I_gray > level_otsu * 255;

%% ==============================
% 5. KAPUR
%% ==============================
counts = imhist(I_gray);
p = counts / sum(counts);

H = zeros(256,1);

for t = 1:255
    p1 = p(1:t);
    p2 = p(t+1:end);

    w1 = sum(p1);
    w2 = sum(p2);

    if w1 > 0 && w2 > 0
        H1 = -sum((p1/w1) .* log(p1/w1 + eps));
        H2 = -sum((p2/w2) .* log(p2/w2 + eps));
        H(t) = H1 + H2;
    end
end

[~, t_opt] = max(H);
level_kapur = t_opt / 255;

S_kapur = I_gray > level_kapur * 255;

%% ==============================
% 6. BOYUT EÞÝTLEME (KRÝTÝK)
%% ==============================
GT_size = size(GT_bin);

S_otsu  = imresize(S_otsu,  [GT_size(1) GT_size(2)]);
S_kapur = imresize(S_kapur, [GT_size(1) GT_size(2)]);
S_prop  = imresize(S_prop,  [GT_size(1) GT_size(2)]);

% binary tekrar garanti altýna al
S_otsu  = S_otsu  > 0.5;
S_kapur = S_kapur > 0.5;
S_prop  = S_prop  > 0.5;

%% ==============================
% 7. METRÝKLER
%% ==============================
compute_metrics = @(S,GT) deal( ...
    psnr(double(S), double(GT)), ...
    immse(double(S), double(GT)), ...
    ssim(double(S), double(GT)) ...
);

[psnr_o, mse_o, ssim_o] = compute_metrics(S_otsu, GT_bin);
[psnr_k, mse_k, ssim_k] = compute_metrics(S_kapur, GT_bin);
[psnr_p, mse_p, ssim_p] = compute_metrics(S_prop, GT_bin);

%% ==============================
% 8. SONUÇ TABLOSU
%% ==============================
Results = [
    psnr_o, mse_o, ssim_o;
    psnr_k, mse_k, ssim_k;
    psnr_p, mse_p, ssim_p
];

Methods = {'Otsu'; 'Kapur'; 'Proposed'};

T = array2table(Results, ...
    'VariableNames', {'PSNR','MSE','SSIM'}, ...
    'RowNames', Methods);

disp('=== SONUÇLAR ===');
disp(T);

%% ==============================
% 9. GÖRSEL KARÞILAÞTIRMA
%% ==============================
figure;
subplot(2,3,1); imshow(I); title('Original');
subplot(2,3,2); imshow(GT_bin); title('Ground Truth');
subplot(2,3,3); imshow(S_otsu); title('Otsu');
subplot(2,3,4); imshow(S_kapur); title('Kapur');
subplot(2,3,5); imshow(S_prop); title('Proposed');

figure;
imshowpair(GT_bin, S_prop, 'blend');
title('GT vs Proposed Overlay');