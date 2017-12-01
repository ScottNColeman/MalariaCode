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
                MAT(1,1,:) = reshape(s1,1,1,classes);
%                 switch s1
%                     case 1
%                         MAT(1,1,hSus) = 0.9;
%                         MAT(1,1,hInf) = 0.1;
%                         MAT(1,1,mSus) = 1;
%                         MAT = 1000*MAT;%%optional
%                     case 2
%                         MAT(1,1,hSus) = 0.5;
%                         MAT(1,1,hInf) = 0.5;
%                         MAT(1,1,mSus) = 0.5;
%                         MAT(1,1,mInf) = 0.5;
%                     case 3
%                         r = 1/14;
%                         c = 1/6;
%                         i = 1/20;
%                         b = 1/2;
%                         
%                         MAT(1,1,hSus) = (r*(b+c))/(b*(i+r));
%                         MAT(1,1,hInf) = (b*i-c*r)/(b*(i+r));
%                         MAT(1,1,mSus) = (c*(i+r))/(i*(b+c));
%                         MAT(1,1,mInf) = (b*i-c*r)/(i*(b+c));
%                     case 4
%                         MAT(1,1,hSus) = 1;
%                         MAT(1,1,hInf) = 0;
%                         MAT(1,1,mSus) = 0.9;
%                         MAT(1,1,mInf) = 0.1;
%                 end
            case 'P'
                %r = 0.001;
                r = 1/14;
                %c = 0.002;
                c = 1/6;
                MAT = zeros(classes);
                MAT(hInf,hInf) = r*(s1==s2);
                MAT(mInf,mInf) = c*(s1==s2);
            case 'Q'
                %i = 0.00001;
                i = 1/20;
                %b = 0.00002;
                b = 1/2;
                MAT = zeros(classes,classes,classes);
                MAT(hSus,mInf,hSus) = i*(s1==s2);
                MAT(mInf,hSus,hSus) = i*(s1==s3);
                MAT(hInf,mSus,mSus) = b*(s1==s2);
                MAT(mSus,hInf,mSus) = b*(s1==s3);
                %for     q = 1:size(MAT,3)
                %    MAT(:,:,q) = (MAT(:,:,q) + transpose(MAT(:,:,q)))/2;
                %end
                MAT = MAT*100000;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 'A'
                MAT = zeros(classes,classes);
                MAT(hSus,hInf) = 1;
                MAT(hInf,hSus) = 1;
                MAT(mSus,mInf) = 1;
                MAT(mInf,mSus) = 1;
        end
end