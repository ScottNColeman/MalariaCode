function MAT = BuildMatrix(model,matstr,s1,s2,s3)
switch model
    case 1
        classes = 4;
        hSus = 1;
        hInf = 2;
        mSus = 3;
        mInf = 4;
        switch matstr
            case 'uInit'
                MAT = zeros(1,s2,classes);
                switch s1
                    case 1
                        MAT(1,1,hSus) = 0.9;
                        MAT(1,1,hInf) = 0.1;
                        MAT(1,1,mSus) = 1;
                        MAT = 1000*MAT;%%optional
                    case 2
                        MAT(1,1,hSus) = 0.5;
                        MAT(1,1,hInf) = 0.5;
                        MAT(1,1,mSus) = 0.5;
                        MAT(1,1,mInf) = 0.5;
                end
            case 'P'
                r = 0.001;
                c = 0.002;
                MAT = zeros(classes);
                MAT(hInf,hInf) = r;
                MAT(mInf,mInf) = c;
            case 'Q'
                i = 0.00001;
                b = 0.00002;
                MAT = zeros(classes,classes,classes);
                MAT(hSus,mInf,hSus) = i;
                MAT(hInf,mSus,mSus) = b;
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