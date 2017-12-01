function du = DirecDeriv2(model,u,S,tStep)
%DIRECTIONALDERIVATIVE returns (du/dt + du/ds) required to update PDE
%
% INPUTS:  u  - residents in each of the I classes at the previous time and
%               resident time step i.e. u^(m-1)_(n-1) for all classes
% OUTPUTS: du - the vector of (du/dt + du/ds) for each class (1 x 1 x I)
ds = S(2);
du = zeros(size(u));
for     j = 1:size(du,3)
    for     s1 = 2:tStep % Should these be from index 1, considering uAdv(1) = 0
        P = BuildMatrix(model,'P',S(s1),S(s1),0);
        u_s1 = reshape(u(1,s1,:),size(u,3),1);
        Pu_s1 = P*u_s1;
        du(1,s1,j) = du(1,s1,j) +Pu_s1(j);
        for     s2 = 1:tStep
            Qa = BuildMatrix(model,'Q',S(s1),S(s2),S(s1));
            Qb = BuildMatrix(model,'Q',S(s1),S(s1),S(s2));
            u_s2 = reshape(u(1,s2,:),size(u,3),1);
            du(1,s1,j) = du(1,s1,j) +...
                    (transpose(u_s2)*Qa(:,:,j)*u_s1 +...
                    transpose(u_s1)*Qb(:,:,j)*u_s2)*ds^3;
        end
    end
end