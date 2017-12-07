function u0 = BoundConds2(model,u,S,tStep)
%BOUNDARYCONDITIONS returns the new residents entering each of the classes
%
% INPUTS:  u  - residents in each of the classes at each residence times
% OUTPUTS: u0 - vector of u^(m+1)_0 values for each of the I classes
u0 = zeros(1,1,size(u,3));
for     i = 1:size(u0,3)
    for     s1 = 2:tStep
        G = BuildMatrix(model,'G',S(s1),S(s1),0);
        Ap = BuildMatrix(model,'Ap',S(s1),0,0);
        P = BuildMatrix(model,'P',S(s1),S(s1),0);
        u_s1 = reshape(u(1,s1,:),size(u,3),1);
        Gu = G*u_s1;
        ApTPu = transpose(Ap)*P*u_s1;
        u0(1,1,i) = u0(1,1,i) +ApTPu(i);% -Gu(i);
        Aq = BuildMatrix(model,'Aq',S(s1),0,0);
        for     j = 1:size(u0,3)
            for     s2 = 1:tStep
                %Aq = BuildMatrix(model,'Aq',S(s1),S(s2),0);
                Q = BuildMatrix(model,'Q',S(s1),S(s1),S(s2));
                u_s2 = reshape(u(1,s2,:),size(u,3),1);
                u0(1,1,i) = u0(1,1,i) +...
                        Aq(j,i)*transpose(u_s1)*Q(:,:,j)*u_s2;
            end
        end
    end
end