% Initial matrices to store t and s values
t = linspace(0,30,13); % uses n index - WORKS FOR 13, NOT FOR 10
s = t; % uses m index, half of these values are useless

% Sam Test Commit 
%Again


% Initialise each class
I = 2; % number of classes
u = zeros(length(t),length(s),I);

% Initial conditions
u(1,1,:) = [1,0]; % must be size I x 1

for n = 2:length(t)
    u(:,n,:) = PartialDifferentialEquation( u(:,n-1,:), t(n), t(n)-t(n-1));
end

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