% Initial matrices to store t and s values
t = linspace(0,300,601); % uses n index
s = t; % uses m index, half of these values are useless

% Horrible global variables
global I B R C;
I = 1/20;
B = 1/2;
R = 1/14;
C = 1/6;

% MATT - current model iteration.
model = 1;
% MATT - initial condition index.
startInd = 4;

Init = [(R*(B+C))/(B*(I+R));
        (B*I-C*R)/(B*(I+R));
        (C*(I+R))/(I*(B+C));
        (B*I-C*R)/(I*(B+C))];

% Initialise each class
u = zeros(length(t),length(s),4);

% Initial conditions
u(1,1,:) = [0.9,0.1,0.5,0.5]; % must be size I x 1
%u(1,1,:) = Init;
disp(1)

for n = 2:length(t)
    u(:,n,:) = PartialDifferentialEquation( u(:,n-1,:), t(n), t(n)-t(n-1) );%, t(n), t(n)-t(n-1));
    disp(n)
end

%%
% Plot colour maps
gap = 1; % If takes ages to plot, increase this to plot less values
%st = transpose((0:gap:numSteps)*stepSize);
for i = 1:size(u,3)
    figure;
    contourf(t(201:gap:end), s(201:gap:end), u(201:gap:end,201:gap:end,i))
    colorbar
    xlabel('Time'); ylabel('Residence Time')
    
    %figure;
    %test = log(1+u(:,:,i));
    %contourf(t(1:gap:end), s(1:gap:end), test(1:gap:end,1:gap:end))
    %colorbar
    %xlabel('Time'); ylabel('Residence Time')
    
    figure;
    plot( t, sum(u(:,:,i),1) ) % total residence in each class against time
    xlabel('Time'); ylabel('Population')
    hold on
    plot(t,Init(i)*ones(size(t)),'--')
    %ylim([0,1])
end