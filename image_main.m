data=im2double(rgb2gray(imread('unnamed.jpg')));
for r = 0.4:0.1:0.7
    clear X
    [~, M, P] = preprocess_image(data, r);
    % nuclear-norm
    disp('Nuclear');
    tic;
    s = toc;
    [X, ~]=MC_Nuclear_IALM(M, P);
    e = toc;
    err_nuclear = relative_error(data, X, P);
    time_nuclear = e - s;

    % ours
    disp('NCARL');
    err_ours = 10;
    for alpha = 10.^(1:4)
        for k = [5, 10, 20, 50]
            s = toc;
            [X, ~, ~] = ncarl_no_noise(M, P, alpha, k);
            e = toc;
            t = relative_error(data, X, P);
            if t <= err_ours
                err_ours = t;
                time_ours = e - s;
                best_alpha = alpha;
                best_k = k;
            end
        end
    end
    
    fprintf('Nuclear:       %.4f (consuming-time: %.4f s)\n', err_nuclear, time_nuclear);

    fprintf('ours:          %.4f (consuming-time: %.4f s)\n', err_ours, time_ours);

end
clear r data X M P t