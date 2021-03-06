function u0 = BoundaryConditions(model,u,S,tStep)
%BOUNDARYCONDITIONS returns the new residents entering each of the classes
%
% INPUTS:  u  - residents in each of the classes at each residence times
% OUTPUTS: u0 - vector of u^(m+1)_0 values for each of the I classes
ds = S(2);
u0 = zeros(1,1,size(u,3));
for     s1 = 2:tStep
    A = BuildMatrix(model,'A',S(s1),0,0);
    for     s2 = 1:tStep
        P = BuildMatrix(model,'P',S(s1),S(s2),0);
        u_s2bob = reshape(u(1,s2,:),size(u,3),1);
        ATPu = transpose(A)*P*u_s2bob;
        for     s3 = 1:tStep
            Q = BuildMatrix(model,'Q',S(s1),S(s2),S(s3));
            u_s3 = reshape(u(1,s3,:),size(u,3),1);
            for     i = 1:size(u0,3)
                u0(1,1,i) = u0(1,1,i) + ATPu(i)*ds^2;
                for     j = 1:size(Q,3)
                    u0(1,1,i) = u0(1,1,i) + ...
                            A(j,i)*transpose(u_s2bob)*Q(:,:,j)*u_s3*ds^3;
                end
            end
        end
    end
end