function P = Pmat(s1,s2,n,model)
switch model
    case 1
        r = 0.1;
        c = 0.2;
        P = zeros(n);
        P(1,2) = r;
        P(2,1) = -r;
        P(3,4) = c;
        P(4,4) = -c;
end