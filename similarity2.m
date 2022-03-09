function S = similarity2(X, k)
    D = EuDist2(X', X', false);
    n = size(D, 1);
    sorted_D = sort(D, 2);
    k_D = sorted_D(:, k+1) + 10^-6;
    top_k_sum = sum(sorted_D(:, 1:k), 2);
    S = max(repmat(k_D, 1, n) - D, 0);
    S = S ./ repmat(k * k_D - top_k_sum, 1, n);
end