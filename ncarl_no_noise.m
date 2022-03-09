function [X, obj, err] = ncarl_no_noise(M, P, alpha, k, max_iter, flag)
    if ~exist('max_iter', 'var')
        max_iter = 15;
    end
    if ~exist('flag', 'var')
        flag = false;
    end
    if flag 
        data = M;
        M = M .* P;
    else
        data = 0;
    end

    [m, n] = size(M);
    is_transpose = false;
    if m < n
        is_transpose = true;
        M = M';
        P = P';
        data = data';
        [m, n] = size(M);
    end
    X = M;
    obj = zeros(max_iter, 1);
    err = zeros(max_iter, 1);


    for i = 1: max_iter

        S = similarity2(X, k);
        W = (S + S') / 2;
        L = diag(sum(W,2))-W;
        L = max(L, L');

        D = X' * X;
        D = max(D', D);
        [U, Lambda] = eig(D);
        Lambda = max(diag(Lambda), 0).^0.5;
        Lambda = Lambda / sum(Lambda);
        Lambda(Lambda <= 10^-5) = 0;
        Lambda(Lambda > 10^-5) = Lambda(Lambda > 10^-5).^-1;
        Lambda = diag(Lambda);
        D = U * Lambda * U';



        inv_D = (D + alpha * L + 10^-6 * eye(n))^-1;
        V = zeros(m, n);
        for ii = 1: m
            p = P(ii, :);
            idx = find(p==1);
            V(ii, idx) = inv_D(idx, idx)\M(ii, idx)';
        end
        oldX = X;
        X = (V .* P) * inv_D;

        obj(i) = trace(X * (D + alpha * L) * X') / (m * n);
        if flag
            err(i) = relative_error(data, X, P);
        else
            err(i) = 0;
        end 
        if norm(X - oldX, 'fro') / (m * n) < 10^-6
            obj = obj(1:i);
            err = err(1:i);
            break;
        end

    end
    if is_transpose
        X = X';
    end
end