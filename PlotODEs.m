function PlotODEs(Model,Timespan,Stepsize)
tic
% Creates Timespace
t = linspace(0,Timespan,(Timespan/Stepsize));

% Ratio of mosquitos to humans
M = 1;

%% Set Parameters
r = 1/14;   % recovery rate
%r = 0.001;
i = 1/20;   % infection rate
%i = 0.00001;
d = 0.002;      % death rate
c = 1/6;    % "circulation" rate
%c = 0.002;
b = 1/2;    % biting rate
%b = 0.00002;
N = 1/10;   % incubation period/rate

O = 0.1;   % likelihood of human receiving treatment 

p = 1/180; % Mosquito birth rate

q = 1/5; % Mosquito death rate

m = 1/2; % Mosquito maturity rate

%% Create non-linear ODE

 % Original model with 5 classes
if Model == 1
    x0 = [0.5;0.5;0;0.5*M;0.5*M];
    %x0 = [(r*(b+c))/(b*(i+r));(b*i-c*r)/(b*(i+r));0;(c*(i+r))/(i*(b+c));(b*i-c*r)/(i*(b+c))];
    f = @(t,x) [r*x(2)-i*x(1)*x(5);-(r+d)*x(2)+i*x(1)*x(5);d*x(2); ... 
        c*x(5)-b*x(2)*x(4);-c*x(5)+b*x(2)*x(4)];
    
% Addition of infected but not showing symptoms class. (Assumes they cannot
% transmit the disease 
elseif Model == 2 
    x0 = [1;0;0;0;0.999*M;0.001*M];
    f = @(t,x) [r*x(3)-i*x(1)*x(6);i*x(1)*x(6)-N*x(2);-(r+d)*x(3)+N*x(2);d*x(3); ... 
        c*x(6)-b*x(3)*x(5);-c*x(6)+b*x(3)*x(5)];
    
% Addition of infected but not showing symptoms class removing assumption 
elseif Model == 3 
    x0 = [1;0;0;0;0.999*M;0.001*M];
    f = @(t,x) [r*x(3)-i*x(1)*x(6);i*x(1)*x(6)-N*x(2);-(r+d)*x(3)+N*x(2);d*x(3); ... 
        c*x(6)-b*x(3)*x(5)-b*x(2)*x(5);-c*x(6)+b*x(3)*x(5)+b*x(2)*x(5)];
 
% Addition of isolation treatment class
elseif Model == 4
    x0 = [0.99;0;0.01;0;0;1*M;0*M];
    f = @(t,x) [r*x(4)-i*x(1)*x(7);i*x(1)*x(7)-N*x(2);-(d+O)*x(3)+N*x(2); ...
        O*x(3) - (d+r)*x(4);d*(x(3)+x(4));c*x(7)-b*x(3)*x(6)-b*x(2)*x(6);...
        -c*x(7)+b*x(3)*x(6)+b*x(2)*x(6)];
    
% Addition of new Malaria classes: juvenial and dead. Mosquito population
% depends on birth rate and can rise above what it was initially.
elseif Model == 5
    x0 = [0.99;0;0.01;0;0;0;1*M;0;0];
    f = @(t,x) [r*x(4)-i*x(1)*x(8);i*x(1)*x(8)-N*x(2);-(d+O)*x(3)+N*x(2);...
        0*x(3)-(d+r)*x(4);d*(x(3)+x(4));p-m*x(6);m*x(6)-b*x(7)*(x(2)+x(3));...
        b*x(7)*(x(2)+x(3))-q*x(8);q*x(8)];
end


%% Solve ODE using ode45
opts = odeset('RelTol',1e-3, 'AbsTol' ,1e-6);
[t,x] = ode45(f,t,x0,opts);

%% Plot the results


% plot(t,ones(size(t))*x2(1),'b--')
% plot(t,ones(size(t))*x2(2),'g--')
% plot(t,ones(size(t))*x2(3),'r--')

if Model == 1
    figure;
    plot(t,x(:,1),'b-',t,x(:,2),'r-',t,x(:,3),'k-');
    legend('Sus','Inf','Dead')
    xlabel('Time'); ylabel('Relative Population')
    title('Humans')
    figure;
    plot(t,x(:,4),'c-',t,x(:,5),'m-');
    legend('Sus','Inf');
    xlabel('Time'); ylabel('Relative Population')
    title('Mosquitoes');
elseif Model == 2 || Model == 3
    figure;
    plot(t,x(:,1),'b-',t,x(:,2),'g-',t,x(:,3),'r-',t,x(:,4),'k-');
    legend('Sus','Inf (no)','Inf (yes)','Dead')
    xlabel('Time'); ylabel('Relative Population')
    title('Humans')
    figure;
    plot(t,x(:,5),'c-',t,x(:,6),'m-');
    legend('Sus','Inf');
    xlabel('Time'); ylabel('Relative Population')
    title('Mosquitoes');
elseif Model == 4
    figure;
    plot(t,x(:,1),'b-',t,x(:,2),'g-',t,x(:,3),'r-',t,x(:,4),'m-',t,x(:,5),'k-');
    legend('Sus','Inf (no)','Inf (yes)','Isolation','Dead')
    xlabel('Time'); ylabel('Relative Population')
    title('Humans')
    figure;
    plot(t,x(:,6),'c-',t,x(:,7),'m-');
    legend('Sus','Inf');
    xlabel('Time'); ylabel('Relative Population')
    title('Mosquitoes');
elseif Model == 5
    figure;
    plot(t,x(:,1),'b-',t,x(:,2),'g-',t,x(:,3),'r-',t,x(:,4),'m-',t,x(:,5),'k-');
    legend('Sus','Inf (no)','Inf (yes)','Isolation','Dead')
    xlabel('Time'); ylabel('Relative Population')
    title('Humans')
    figure;
    plot(t,x(:,6),'c-',t,x(:,7),'m-',t,x(:,8),'k-',t,x(:,9),'b-');
    legend('Young','Sus','Inf','Dead');
    xlabel('Time'); ylabel('Relative Population')
    title('Mosquitoes');
end
% plot(t,ones(size(t))*x2(4),'c--')
% plot(t,ones(size(t))*x2(5),'m--')

toc
end

