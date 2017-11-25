function MAT = BuildMatrix(model,matstr,s1,s2,s3)
switch model
    case 1
        classes = 4;
        hSus = 1;
        hInf = 2;
        mSus = 3;
        mInf = 4;
        switch matstr
            case 'P'
                r = 0.1;
                c = 0.2;
                MAT = zeros(classes);
                MAT(hSus,hInf) = r;
                MAT(hInf,hSus) = -r;
                MAT(mSus,mInf) = c;
                MAT(mInf,mSus) = -c;
            case 'Q'
                i = 0.01;
                b = 0.02;
                MAT = zeros(classes,classes,classes);
                MAT(hSus,mInf,hSus) = -i;
                MAT(hSus,mInf,hInf) = i;
                MAT(hInf,mSus,mSus) = -b;
                MAT(hInf,mSus,mInf) = b;
                for     q = 1:size(MAT,3)
                    MAT(:,:,q) = MAT(:,:,q) + MAT(:,:,q)';
                end
            case 'A'
                MAT = zeros(classes,classes);
                MAT(hSus,hInf) = 1;
                MAT(hInf,hSus) = 1;
                MAT(mSus,mInf) = 1;
                MAT(mInf,mSus) = 1;
        end
end