function du = DirectionalDerivative(model,u,S,tStep)
%DIRECTIONALDERIVATIVE returns (du/dt + du/ds) required to update PDE
%
% INPUTS:  u  - residents in each of the I classes at the previous time and
%               resident time step i.e. u^(m-1)_(n-1) for all classes
% OUTPUTS: du - the vector of (du/dt + du/ds) for each class (1 x 1 x I)
du = zeros(size(u));
for     s1 = 1:tStep % Should these be from index 1, considering uAdv(1) = 0
    for     s2 = 1:tStep
        P = BuildMatrix(model,'P',S(s1),S(s2),0);
        u_s2 = reshape(u(1,s2,:),size(u,3),1);
        Pu_s2 = P*u_s2;
        for     s3 = 1:tStep
            Q = BuildMatrix(model,'Q',S(s1),S(s2),S(s3));
            u_s3 = reshape(u(1,s3,:),size(u,3),1);
            for     j = 1:size(du,3)
                du(1,s1,j) = du(1,s1,j) +...
                        Pu_s2(j) +transpose(u_s2)*Q(:,:,j)*u_s3;
            end
        end
    end
end