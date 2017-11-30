function [uInit,u] = MalariaSim(numSteps,stepSize,model,init)

t = (0:numSteps) * stepSize; % uses n index
s = t; % uses m index, half of these values are useless

% Initialise each class
%%%I = 2; % number of classes
%%%u = zeros(length(t),length(s),I);

% Initial conditions
uInit = BuildMatrix(model,'uInit',init,numSteps+1,0);
%%%u(1,1,:) = [1,0]; % must be size I x 1

u = zeros(numSteps,numSteps+1,size(uInit,3));
u(1,:,:) = PartialDifferentialEquation(model,uInit,stepSize,2);
disp(1)
for n = 2:numSteps
    u(n,:,:) = PartialDifferentialEquation(model,u(n-1,:,:),stepSize,n+1);%, t(n), t(n)-t(n-1));
    disp(n)
end
% MATT - Previously u(:,n,:) was used, potentially inconsistent with u =
% zeros(length(t),length(s),I) as this suggests t should vary across the
% first dimension of u...?