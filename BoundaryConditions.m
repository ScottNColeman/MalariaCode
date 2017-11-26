function u0 = BoundaryConditions(model,u)
%BOUNDARYCONDITIONS returns the new residents entering each of the classes
%
% INPUTS:  u  - residents in each of the classes at each residence times
% OUTPUTS: u0 - vector of u^(m+1)_0 values for each of the I classes

u0 = zeros(1,1,size(u,3));
for     s1 = 1:size(u,2)
    A = BuildMatrix(model,'A',s1,0,0);
    for     s2 = 1:size(u,2)
        P = BuildMatrix(model,'P',s1,s2,0);
        u_s2 = reshape(u(1,s2,:),size(u,3),1);
        ATPu = transpose(A)*P*u_s2;
        for     i = 1:size(u0,3)
            int_auTQu = 0;
            for     s3 = 1:size(u,2)
                Q = BuildMatrix(model,'Q',s1,s2,s3);
                u_s3 = reshape(u(1,s3,:),size(u,3),1);
                for     j = 1:size(Q,3)
                    int_auTQu = int_auTQu +...
                            A(j,i)*transpose(u_s2)*Q(:,:,j)*u_s3;
                end
            end
            u0(1,1,i) = u0(1,1,i) +ATPu(i) +int_auTQu;
        end
    end
 end