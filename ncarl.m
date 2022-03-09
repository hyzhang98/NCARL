function [X1, X, obj] = ncarl(M, P, lam, alpha, k, max_iter)

    if ~exist('max_iter', 'var')
        max_iter = 30;
    end

    [d1,d2] = size(M);
    S = similarity2(M, k);
    W = (S + S') / 2;
    L = diag(sum(W,2))-W;
    L = max(L, L');
    A = M' * M + 10^-6 * eye(d2);
    % A = M' * M;
    A = max(A, A');
    A = A^0.5;
    A = max(A, A');
    SI = (A / trace(A))^-1;
    % SI = pinv(A / trace(A));


    X = zeros(d1, d2, max_iter);
    obj = zeros(max_iter, 1);
    oldX = 0;

    for iter = 1:max_iter
        for i = 1:d1
            D = lam * SI + alpha * L;
            X(i,:,iter)=(M(i,:).*P(i,:)) * (diag(P(i,:)) + D + 10^-6 * eye(d2))^-1;
        end
        S =similarity2(X(:,:,iter),k);
        W = (S + S') / 2;
        L=diag(sum(W, 2))- W;
        L=max(L, L');
        B=X(:, :, iter)'*X(:, :, iter) + 10^-6 * eye(d2);
        % B=X(:, :, iter)'*X(:, :, iter);
        B = max(B, B');
        B = B^0.5;
        B = max(B, B');

        SI = (B / trace(B))^-1;
        % SI = pinv(B / trace(B));

        
    

        Xt = X(:, :, iter);
        obj_iter = norm(Xt .* P - M, 'fro')^2;
        obj_iter = obj_iter + trace(Xt * (lam * SI + alpha * L) * Xt');
        obj(iter) = obj_iter;

        % if norm(Xt - oldX, 'fro') / (d1 * d2) < 5*10^-6
        %     obj = obj(1:iter);
        %     break;
        % end
        oldX = Xt;
        % error = norm(data-X(:,:,iter),'fro');
        % err(iter)=error;
        % if iter>1 && err(iter-1)-err(iter)<0      
        %     X1=X(:,:,iter-1);
        %     return;
        % end
        % X1=X(:,:,iter); 
    end
    X1 = Xt;
end