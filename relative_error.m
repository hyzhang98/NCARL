function err = relative_error(X, X_recons, mask)
    mask = ~mask;
    err = norm((X - X_recons) .* mask, 'fro');
    err = err / norm(X .* mask, 'fro');
end