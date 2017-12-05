function new_u = PartialDifferentialEquation(u,t,dt,model)
% PARTIALDIFFERENTIALEQUATION returns the new u values for all s at the
% next time interval
%
% INPUTS:  u     - M x 1 x I matrix of residents in each class with each
%                residence time at the previous time step
%          t     - time at which the number of residents is to be calculated
%          dt    - time step in t and s to be used
%
% OUTPUTS: new_u - M x 1 x I matrix of residents at the new time step

M = round(t/dt,0);
s = linspace(0,t,M+1);

new_u = zeros(size(u));

% Apply boundary condition at s = 0
new_u(1,1,:) = dt * BoundaryConditions(u,s,model);

% Calculate changes in different classes
for m = 2:length(s)
    new_u(m,1,:) = u(m-1,1,:) - dt * DirectionalDerivative(u,m,s,model);
end
% new_u(m,1,:) = u(m-1,1,:) + dt * DirectionalDerivative( u(m-1,1,:) );

% any values of new_u(m,1,:) = 0 for m > length(s) since initialised zeros