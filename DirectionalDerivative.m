function du = DirectionalDerivative(model,u)
%DIRECTIONALDERIVATIVE returns (du/dt + du/ds) required to update PDE
%
% INPUTS:  u  - residents in each of the I classes at the previous time and
%               resident time step i.e. u^(m-1)_(n-1) for all classes
% OUTPUTS: du - the vector of (du/dt + du/ds) for each class (1 x 1 x I)
du = zeros(size(u));
for     s1 = 1:size(du,2)
    for     j = 1:size(du,3)
        int_Pu_uTQu = 0;
        for     s2 = 1:size(du,2)
            P = BuildMatrix(model,'P',s1,s2,0);
            u_s2 = reshape(u(1,s2,:),size(u,3),1);
            int_uTQu = 0;
            for     s3 = 1:size(du,2)
                Q = BuildMatrix(model,'Q',s1,s2,s3);
                u_s3 = reshape(u(1,s3,:),size(u,3),1);
                int_uTQu = int_uTQu +transpose(u_s2)*Q(:,:,j)*u_s3;
            end
            int_Pu_uTQu = int_Pu_uTQu +P*u_s2 +int_uTQu;
        end
        du(1,s1,j) = int_Pu_uTQu;
    end
end