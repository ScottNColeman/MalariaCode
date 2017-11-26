% Initial matrices to store t and s values
t = linspace(0,30,13); % uses n index - WORKS FOR 13, NOT FOR 10
s = t; % uses m index, half of these values are useless
tMax = 10;
sMax = tMax;
% Sam Test Commit 
%Again

% MATT - current model iteration.
model = 1;
% MATT - initial condition index.
startInd = 1;

% Initialise each class
%%%I = 2; % number of classes
%%%u = zeros(length(t),length(s),I);

% Initial conditions
uInit = BuildMatrix(model,'uInit',startInd,tMax,0);
%%%u(1,1,:) = [1,0]; % must be size I x 1

u = zeros(tMax,sMax,size(uInit,3));
u(1,:,:) = PartialDifferentialEquation(model,uInit);
disp(0)
for n = 2:tMax
    u(n,:,:) = PartialDifferentialEquation(model,u(n-1,:,:));%, t(n), t(n)-t(n-1));
    disp(n)
end
% MATT - Previously u(:,n,:) was used, potentially inconsistent with u =
% zeros(length(t),length(s),I) as this suggests t should vary across the
% first dimension of u...?

%%
% Plot colour maps
for i = 1:size(u,3)
    gap = 1; % If takes ages to plot, increase this to plot less values
    figure;
    contourf(t(1:gap:end), s(1:gap:end), u(1:gap:end,1:gap:end,i))
    colormap;
    xlabel('Time'); ylabel('Residence Time')    
    figure;
    plot( t, sum(u(:,:,i)) ) % total residence in each class against time
end