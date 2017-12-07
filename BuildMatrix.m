function MAT = BuildMatrix(model,matstr,s1,s2,s3)
switch  model
    case    1
        classes = 4;
        hSus = 1;
        hInf = 2;
        mSus = 3;
        mInf = 4;
        switch  matstr
            case    'uInit'
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
            case    'P'
                %r = 0.001;
                r = 1/14;
                %c = 0.002;
                c = 1/6;
                MAT = zeros(classes);
                MAT(hInf,hInf) = r*(s1==s2);
                MAT(mInf,mInf) = c*(s1==s2);
            case    'Q'
                %i = 0.00001;
                infect = 1/20;
                %b = 0.00002;
                b = 1/2;
                MAT = zeros(classes,classes,classes);
                MAT(hSus,mInf,hSus) = infect*(s1==s2);
                %MAT(mInf,hSus,hSus) = i*(s1==s3);
                MAT(mSus,hInf,mSus) = b*(s1==s2);
                %MAT(mSus,hInf,mSus) = b*(s1==s3);
                %for     q = 1:size(MAT,3)
                %    MAT(:,:,q) = (MAT(:,:,q) + transpose(MAT(:,:,q)))/2;
                %end
                %MAT = MAT*100000;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case    'A'
                MAT = zeros(classes,classes);
                MAT(hSus,hInf) = 1;
                MAT(hInf,hSus) = 1;
                MAT(mSus,mInf) = 1;
                MAT(mInf,mSus) = 1;
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case    2
        classes = 5;
        hSus = 1;
        hInf = 2;
        hDead = 3;
        mSus = 4;
        mInf = 5;
        d = 1/2;
        r = 1/14;
        c = 1/6;
        infect = 1/20;
        b = 1/2;
        switch matstr
            case    'uInit'
                MAT = zeros(1,s2,classes);
                MAT(1,1,:) = reshape(s1,1,1,classes);
            case    'P'              
                MAT = zeros(classes);
                MAT(hInf,hInf) = (r+d)*(s1==s2);
                MAT(mInf,mInf) = c*(s1==s2);
            case    'Q'
                MAT = zeros(classes,classes,classes);
                MAT(hSus,mInf,hSus) = infect*(s1==s2);
                MAT(mSus,hInf,mSus) = b*(s1==s2);
            case    'A'
                MAT = zeros(classes,classes);
                MAT(hSus,hInf) = 1;
                MAT(hInf,hSus) = r/(r+d);
                MAT(hInf,hDead) = d/(r+d);
                MAT(mSus,mInf) = 1;
                MAT(mInf,mSus) = 1;
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case    3
        classes = 5;
        hSus = 1;
        hInf = 2;
        hDead = 3;
        mSus = 4;
        mInf = 5;
        d = 1/2;
        r = 1/14;
        c = 1/6;
        infect = 1/20;
        b = 1/2;
        switch matstr
            case    'uInit'
                MAT = zeros(1,s2,classes);
                MAT(1,1,:) = reshape(s1,1,1,classes);
            case    'P'              
                MAT = zeros(classes);
                MAT(hInf,hInf) = (r+d)*(s1==s2);
                MAT(mInf,mInf) = c*(s1==s2);
            case    'Q'
                MAT = zeros(classes,classes,classes);
                MAT(hSus,mInf,hSus) = infect*(s1==s2);
                MAT(mSus,hInf,mSus) = b*(s1==s2);
            case    'A'
                MAT = zeros(classes,classes);
                MAT(hSus,hInf) = 1;
                MAT(hInf,hSus) = r/(r+d);
                MAT(hInf,hDead) = d/(r+d);
                MAT(mSus,mInf) = 1;
                MAT(mInf,mSus) = 1;
        end
    case    4
        classes = 10;
        hSus = 1;
        hInf = 2;
        hInfS = 3;
        hInfST = 4;
        hDead = 5;
        mJuv = 6;
        mSus = 7;
        mInc = 8;
        mInf = 9;
        mDead = 10;
        
        symDevInt = [8,30];
        recovInt = [7 28];
        worstDay = 21;
        treatTime = 14;
        initRecov = 0.05;
        initDeathSym = 0.05;
        initDeathTreat = 0.1;
        admit = 0.1;
        hBirth = 19/365000;
        mBirth = 1/52;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CHECK
        matureTime = 14;
        bite = 1/2;
        infect = 1/20;
        mDeath = 1/52;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CHECK
        incTime = 7;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CHECK
        switch  matstr
            case    'uInit'
                MAT = zeros(1,s2,classes);
                MAT(1,1,:) = reshape(s1,1,1,classes);
            case    'P'
                MAT = zeros(classes,classes);
                MAT(hInf,hInf) = (min(1,heaviside(s1-symDevInt(1))*... 
                        (s1-symDevInt(1))/diff(symDevInt)))*(s1==s2);
                MAT(hInfS,hInfS) = (1-min(1-admit-initRecov-initDeathSym,...
                        heaviside(recovInt(end)-s1)*...
                        (1-admit-initRecov-initDeathSym)/diff(recovInt)*...
                        (recovInt(end)-s1)))*(s1==s2);
                MAT(hInfST,hInfST) = (1-heaviside(treatTime-s1)*...
                        (initDeathTreat/treatTime +1-initDeathTreat))*...
                        (s1==s2);
                MAT(mJuv,mSus) = heaviside(s1-matureTime)*(s1==s2);
                MAT(mSus,mSus) = mDeath*(s1==s2);
                MAT(mInc,mInc) = (mDeath +heaviside(s1-incTime)*...
                        (1-mDeath))*(s1==s2);
                MAT(mInf,mInf) = mDeath*(s1==s2);
            case    'Q'
                MAT = zeros(classes,classes,classes);
                MAT(hSus,mInf,hSus) = infect*(s1==s2);
                MAT(mSus,hInf,mSus) = bite*(s1==s2);
                MAT(mSus,hInfS,mSus) = bite*(s1==s2);
            case    'Ap'
                MAT = zeros(classes,classes);
                MAT(hInf,hInfS) = 1;
                hInfSscale = 1-min(1-admit-initRecov-initDeathSym,...
                        heaviside(recovInt(end)-s1)*...
                        (1-admit-initRecov-initDeathSym)/diff(recovInt)*...
                        (recovInt(end)-s1));
                MAT(hInfS,hInfST) = admit/hInfSscale;
                MAT(hInfS,hSus) = (initRecov +min(1-admit-initRecov,...
                        heaviside(s1-worstDay)*...
                        (1-admit-initRecov)/(recovInt(end)-worstDay)*...
                        (s1-worstDay)))/hInfSscale;
                MAT(hInfS,hDead) = 1/hInfSscale-sum(MAT(hInfS,:));
                MAT(hInfST,hSus) = s1>=treatTime;
                MAT(hInfST,hDead) = 1-sum(MAT(hInfST,:));
                MAT(mJuv,mSus) = 1;
                MAT(mSus,mDead) = 1;
                MAT(mInc,mInf) = s1>=incTime;
                MAT(mInc,mDead) = 1-sum(MAT(mInc,:));
                MAT(mInf,mDead) = 1;
            case    'Aq'
                MAT = zeros(classes,classes);
                MAT(hSus,hInf) = 1;
                MAT(mSus,mInc) = 1;
            case    'G'
                MAT = zeros(classes,classes);
                MAT(hSus,hSus) = hBirth;
                MAT(hSus,hInf) = hBirth;
                MAT(mJuv,mSus) = mBirth;
                MAT(mJuv,mInc) = mBirth;
                MAT(mJuv,mInf) = mBirth;
        end
        
end