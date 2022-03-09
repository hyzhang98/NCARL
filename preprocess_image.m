function [data, M, P] = preprocess_image(data, r, noise_type)
    if ~exist('noise_type', 'var')
        noise_type = 0;
    end
    [d1,d2,~]=size(data);
    M=data;
    P=ones(d1,d2);
    if noise_type == 0
        rate = r;
        k = randperm(d1 * d2);
        for i = 1: floor(d1 * d2 * rate)
            M(k(i)) = 0;
            P(k(i)) = 0;
        end
    elseif noise_type == 1
        k1=randperm(d1);
        k2=randperm(d2);
        rownoiserate=r; 
        colnoiserate=r;
        for i=1:floor(d1*rownoiserate)
            for j=1:floor(d2*colnoiserate)
                M(k1(i),k2(j))=0;
                P(k1(i),k2(j))=0;
            end
        end
    end
end


