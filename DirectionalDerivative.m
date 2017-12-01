function du = DirectionalDerivative(u,m,s)
%DIRECTIONALDERIVATIVE returns (du/dt + du/ds) required to update PDE
%
% INPUTS:  u  - residents in each of the I classes at the previous time and
%               resident time step i.e. u^(m-1)_(n-1) for all classes
% OUTPUTS: du - the vector of (du/dt + du/ds) for each class (1 x 1 x I)

global I B R C;

%ds = s(2) - s(1);
du = zeros(1,1,size(u,3));

du(1,1,2) = R * u(m-1,1,2);
du(1,1,4) = C * u(m-1,1,4);

for i = 1:length(s)
    du(1,1,1) = du(1,1,1) + I * u(i,1,4);
    du(1,1,3) = du(1,1,3) + B * u(i,1,2);
end

du(1,1,1) = u(m-1,1,1) * du(1,1,1);
du(1,1,3) = u(m-1,1,3) * du(1,1,3);