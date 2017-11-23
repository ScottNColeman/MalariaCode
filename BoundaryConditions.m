function [u0] = BoundaryConditions(u)
%BOUNDARYCONDITIONS returns the new residents entering each of the classes
%
% INPUTS:  u  - residents in each of the classes at each residence times
% OUTPUTS: u0 - vector of u^(m+1)_0 values for each of the I classes

u0 = zeros(1,1,size(u,3));

end