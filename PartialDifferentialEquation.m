function [new_u] = PartialDifferentialEquation(model, u, t, dt)
% PARTIALDIFFERENTIALEQUATION returns the new u values for all s at the
% next time interval
%
% INPUTS:  u     - M x 1 x I matrix of residents in each class with each
%                residence time at the previous time step
%          t     - time at which the number of residents is to be calculated
%          dt    - time step in t and s to be used
%
% OUTPUTS: new_u - M x 1 x I matrix of residents at the new time step

%s = 0:dt:t; % local s vector
M = round(t/dt,0);
s = linspace(0,t,M+1);

new_u = zeros(size(u));

% MATT - starting to include proper equations...
uLeave = zeros(size(u));
for     s1 = 1:size(uLeave,2)
    for     j = 1:size(uLeave,3)
        int_Pu_uTQu = 0;
        for     s2 = 1:size(uLeave,2)
            P = BuildMatrix(model,'P',s1,s2,0);
            u_s2 = reshape(u(1,s2,:),size(u,3),1);
            int_uTQu = 0;
            for     s3 = 1:size(uLeave,2)
                Q = BuildMatrix(model,'Q',s1,s2,s3);
                u_s3 = reshape(u(1,s3,:),size(u,3),1);
                int_uTQu = int_uTQu +transpose(u_s2)*Q(:,:,j)*u_s3;
            end
            int_Pu_uTQu = int_Pu_uTQu +P*u_s2 +int_uTQu;
        end
        uLeave(1,s1,j) = int_Pu_uTQu;
    end
end

% MATT - ...end of current edit section



% Apply boundary condition at s = 0
new_u(1,1,:) = BoundaryConditions(u);

%u(:,1,1) %DEBUGGING

% Calculate changes in different classes
for m = 2:length(s)
    new_u(m,1,:) = u(m-1,1,:) + dt * DirectionalDerivative( u(m-1,1,:) );
end
% new_u(m,1,:) = u(m-1,1,:) + dt * DirectionalDerivative( u(m-1,1,:) );
% any values of new_u(m,1,:) = 0 for m > length(s) since initialised zeros

end