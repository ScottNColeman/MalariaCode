function [uInit,u] = MalariaSim(numSteps,stepSize,model,init)

t = (0:numSteps) * stepSize; % uses n index
s = t; % uses m index, half of these values are useless

% Initialise each class
%%%I = 2; % number of classes
%%%u = zeros(length(t),length(s),I);

% Initial conditions
uInit = BuildMatrix(model,'uInit',init,numSteps+1,0);
uAge1 = BuildMatrix(model,'uAge',0,numSteps+1,t);

%%%u(1,1,:) = [1,0]; % must be size I x 1

u = zeros(numSteps,numSteps+1,size(uInit,3));
uAge = zeros(numSteps,numSteps+1,size(uAge1,3));
[new_u,new_age] = PartialDifferentialEquation(model,uInit,uAge1,stepSize,2);
u(1,:,:) = new_u;
uAge(1,:,:) = new_age;

disp(1)
for n = 2:numSteps
    [new_u,new_age] = PartialDifferentialEquation(model,u(n-1,:,:),uAge(n-1,:,:),stepSize,n+1);
    u(n,:,:) = new_u;
    uAge(n,:,:) = new_age;
    disp(n)
end
% MATT - Previously u(:,n,:) was used, potentially inconsistent with u =
% zeros(length(t),length(s),I) as this suggests t should vary across the
% first dimension of u...?