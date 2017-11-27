% Initial matrices to store t and s values
numSteps = 20;
% MATT - Time step:
stepSize = 1;

t = (0:numSteps) * stepSize; % uses n index
s = t; % uses m index, half of these values are useless

% MATT - current model iteration.
model = 1;
% MATT - initial condition index.
startInd = 1;

% Initialise each class
%%%I = 2; % number of classes
%%%u = zeros(length(t),length(s),I);

% Initial conditions
uInit = BuildMatrix(model,'uInit',startInd,numSteps+1,0);
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

%%
% Plot colour maps
uInitu = [uInit;u];
gap = 1; % If takes ages to plot, increase this to plot less values
%st = transpose((0:gap:numSteps)*stepSize);
for i = 1:size(uInitu,3)
    figure;
    uu = transpose(uInitu(:,:,i));
    contourf(t(1:gap:end), s(1:gap:end), uu(1:gap:end,1:gap:end))
    colorbar
    xlabel('Time'); ylabel('Residence Time')
    
    figure;
    plot( t, sum(uu(:,:),2) ) % total residence in each class against time
    xlabel('Time'); ylabel('Population')
end