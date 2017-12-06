function main(model, tmax)

% Initial matrices to store t and s values
t = linspace(0, tmax, 600); % uses n index
s = t; % uses m index, half of these values are useless

i = 1 / 20;
b = 1 / 2;
r = 1 / 14;
c = 1 / 6;

Init = [(r * (b + c)) / (b * (i + r));
        (b * i - c * r) / (b * (i + r));
        (c * (i + r)) / (i * (b + c));
        (b * i - c * r) / (i * (b + c))];

% Initialise each class
u = zeros(length(t), length(s), 4);

% Initial conditions
% u(1,1,:) = [0.9, 0.1, 1, 0];
u(1,1,:) = [1, 0, 0.9, 0.1];
% u(1,1,:) = Init;
disp(1)

for n = 2:length(t)
    u(:, n, :) = PartialDifferentialEquation(u(:, n-1, :), t(n), t(n) - t(n - 1), model);
    disp(n)
end

%% Plotting

% Plot colour maps
gap = 1; % If takes ages to plot, increase this to plot less values
%st = transpose((0:gap:numSteps)*stepSize);

for k = 1:size(u, 3)
    % figure;
    % contourf(t(1:gap:end), s(1:gap:end), u(1:gap:end, 1:gap:end,k))
    % colorbar
    % xlabel('Time'); 
    % ylabel('Residence Time')
    
    %figure;
    %test = log(1+u(:,:,k));
    %contourf(t(1:gap:end), s(1:gap:end), test(1:gap:end,1:gap:end))
    %colorbar
    %xlabel('Time'); ylabel('Residence Time')
    
    %figure;
    %plot(s,u(:,end,k))
    %(sum(transpose(s).*u(:,end,k)))/(sum(u(:,end,k)));
    
    %figure;
    %plot(s,u(:,end-100,k))
    %sum(transpose(s).*u(:,end-100,k))/(sum(u(:,end-100,k)))
    
end

% plot humans
figure('Name', 'Humans');
hold on;
YLIM_MAX = 1.2;
LINEWIDTH = 2;

k = 1; % Suspectible humans
plot(t, sum(u(:, :, k), 1), 'b-', 'LineWidth', LINEWIDTH) % total residence in each class against time
plot(t, Init(k) * ones(size(t)), 'b--') % analytic equilibrium

k = 2; % Infected humans
plot(t, sum(u(:, :, k), 1), 'r-', 'LineWidth', LINEWIDTH) % total residence in each class against time
plot(t, Init(k) * ones(size(t)), 'r--') % analytic equilibrium

xlabel('Time'); ylabel('Population')
legend('Susceptible', 'Susceptible steady state', 'Infected', 'Infected steady state')
ylim([0, YLIM_MAX])

% plot mosquitos 
figure('Name', 'Mosquitos');
hold on;

k = 3; % Suspectible mosquitos
plot(t, sum(u(:, :, k), 1), 'b-', 'LineWidth', LINEWIDTH) % total residence in each class against time
plot(t, Init(k) * ones(size(t)), 'b--') % analytic equilibrium

k = 4; % Infected mosquitoes 
plot(t, sum(u(:, :, k), 1), 'r-', 'LineWidth', LINEWIDTH) % total residence in each class against time
plot(t, Init(k) * ones(size(t)), 'r--') % analytic equilibrium

xlabel('Time'); ylabel('Population')
legend('Susceptible', 'Susceptible steady state', 'Infected', 'Infected steady state')
ylim([0, YLIM_MAX])


%%
class = 1;

switch class
    case 1
        % H1
        a = (r * (b * i - c * r)) / (b * (i + r));
        b = (r * i - c * r) / (b + c);
    case 2
        % H2
        a = (r * (b * i - c * r)) / (b * (i + r));
        b = R;
    case 3
        % M1
        a = (c * (b * i - c * r)) / (i * (b + c));
        b = (b * i - c * r) / (i + r);
    case 4
        % M2
        a = (c * (b * i - c * r)) / (i * (b + c));
        b = c;
end

u_pred = (s(2) - s(1)) * a * (1 - (s(2) - s(1)) * b) .^ (0:length(s) - 1);

%figure;
%plot(s,u(:,end,class),'r-')
%hold on
%plot(s,u_pred,'g--')
