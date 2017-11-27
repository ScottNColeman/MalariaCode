function Q = Qmat(s1,s2,s3,n,model)
switch model
    case 1
        i = 0.01;
        b = 0.02;
        Q = zeros(n,n,n);
        Q(1,4,1) = -i;
        Q(1,4,2) = i;
        Q(2,3,3) = -b;
        Q(2,3,4) = b;
        for     q = 1:size(Q,3)
            Q(:,:,q) = Q(:,:,q) + Q(:,:,q)';
        end
end