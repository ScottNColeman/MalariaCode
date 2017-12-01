function u0 = BoundConds2(model,u,S,tStep)
%BOUNDARYCONDITIONS returns the new residents entering each of the classes
%
% INPUTS:  u  - residents in each of the classes at each residence times
% OUTPUTS: u0 - vector of u^(m+1)_0 values for each of the I classes
ds = S(2);
u0 = zeros(1,1,size(u,3));
for     i = 1:size(u0,3)
    for     s1 = 2:tStep
        A = BuildMatrix(model,'A',S(s1),0,0);
        P = BuildMatrix(model,'P',S(s1),S(s1),0);
        u_s1 = reshape(u(1,s1,:),size(u,3),1);
        ATPu = transpose(A)*P*u_s1;
        u0(1,1,i) = u0(1,1,i) +ATPu(i);
        for     j = 1:size(u0,3)
            for     s2 = 1:tStep
                Qa = BuildMatrix(model,'Q',S(s1),S(s2),S(s1));
                Qb = BuildMatrix(model,'Q',S(s1),S(s1),S(s2));
                u_s2 = reshape(u(1,s2,:),size(u,3),1);
                u0(1,1,i) = u0(1,1,i) +...
                        (A(j,i)*transpose(u_s2)*Qa(:,:,j)*u_s1 +...
                        A(j,i)*transpose(u_s1)*Qb(:,:,j)*u_s2)*ds^3;
            end
        end
    end
end