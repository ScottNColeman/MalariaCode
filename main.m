function main(model, tmax, ic, class)

% Initial matrices to store t and s values
t = linspace(0, tmax, 601); % uses n index
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
switch ic
    case 'ih'
        u(1,1,:) = [0.9, 0.1, 1, 0];
    case 'im'
        u(1,1,:) = [1, 0, 0.9, 0.1];
    case 'eq'
        u(1,1,:) = Init;
end

disp(1)

for n = 2:length(t)
    u(:, n, :) = PartialDifferentialEquation(u(:, n-1, :), t(n), t(n) - t(n - 1), model);
    disp(n)
end

%% Plotting

% Plot colour maps
% gap = 1; % If takes ages to plot, increase this to plot less values
% %st = transpose((0:gap:numSteps)*stepSize);

% for k = 1:size(u, 3)
%     % figure;
%     % contourf(t(1:gap:end), s(1:gap:end), u(1:gap:end, 1:gap:end,k))
%     % colorbar
%     % xlabel('Time'); 
%     % ylabel('Residence Time')
    
%     %figure;
%     %test = log(1+u(:,:,k));
%     %contourf(t(1:gap:end), s(1:gap:end), test(1:gap:end,1:gap:end))
%     %colorbar
%     %xlabel('Time'); ylabel('Residence Time')
    
%     %figure;
%     %plot(s,u(:,end,k))
%     %(sum(transpose(s).*u(:,end,k)))/(sum(u(:,end,k)));
    
%     %figure;
%     %plot(s,u(:,end-100,k))
%     %sum(transpose(s).*u(:,end-100,k))/(sum(u(:,end-100,k)))
    
% end

% plot humans
figure('Name', 'Humans');
hold on;
YLIM_MAX = 1.2;
LINEWIDTH = 2;

switch model
    case 1
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
    
    otherwise
        k = 1; % Suspectible humans
        plot(t, sum(u(:, :, k), 1), 'b-', 'LineWidth', LINEWIDTH) % total residence in each class against time
        plot(t, Init(k) * ones(size(t)), 'b--') % analytic equilibrium

        k = 2; % Infected humans
        plot(t, sum(u(:, :, k), 1), 'r-', 'LineWidth', LINEWIDTH) % total residence in each class against time
        plot(t, Init(k) * ones(size(t)), 'r--') % analytic equilibrium

        xlabel('Time'); ylabel('Population')
        legend('Susceptible', 'Original susceptible steady state', 'Infected', 'Original infected steady state')
        ylim([0, YLIM_MAX])
        vline(14, 'k', sprintf('Minimum time at which\npeople can recover.'))
        
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
        legend('Susceptible', 'Original susceptible steady state', 'Infected', 'Original infected steady state')
        ylim([0, YLIM_MAX])
end
%%

switch class
    case 0
        A0 = 0; A1 = 1;
    case 1
        % H1
        A0 = (r * (b * i - c * r)) / (b * (i + r));
        %A0 = u(1,end,1);
        A1 = (b * i - c * r) / (b + c);
    case 2
        % H2
        A0 = (r * (b * i - c * r)) / (b * (i + r));
        A1 = r;
    case 3
        % M1
        A0 = (c * (b * i - c * r)) / (i * (b + c));
        A1 = (b * i - c * r) / (i + r);
    case 4
        % M2
        A0 = (c * (b * i - c * r)) / (i * (b + c));
        A1 = c;
end

ds = s(2) - s(1);
u_pred = ds * A0 * ( ( 1 - ds * A1 ) .^ (0:(length(s) - 1)) );
%u_pred = A0 * ( ( 1 - ds * A1 ) .^ (0:(length(s) - 1)) );

if class ~= 0
    figure('Name', 'Residence Times');
    temp = u(:,end,class) / sum(u(:,end,class));
    %plot(s,u(:,end,class),'r-')
    plot(s,temp,'r-')
    hold on
    temp = u_pred / Init(class);
    plot(s,temp,'g--')
    xlabel('Residence Time'); ylabel('Proportion of Class')
    legend('Residence Step Model','Original Residence Model')
    xlim([0 100])
end