function u0 = BoundaryConditions(u,s,model)
%BOUNDARYCONDITIONS returns the new residents entering each of the classes
%
% INPUTS:  u  - residents in each of the classes at each residence times
% OUTPUTS: u0 - vector of u^(m+1)_0 values for each of the I classes

%ds = s(2) - s(1);
u0 = zeros(1,1,size(u,3));

for i = 1:length(s)
    u0(1,1,1) = u0(1,1,1) + R(s(i),model) * u(i,1,2);
    u0(1,1,3) = u0(1,1,3) + C(s(i),model) * u(i,1,4);

    for j = 1:length(s)
        u0(1,1,2) = u0(1,1,2) + I(s(i),s(j),model) * u(i,1,1) * u(j,1,4);
        u0(1,1,4) = u0(1,1,4) + B(s(i),s(j),model) * u(i,1,3) * u(j,1,2);
    end
end