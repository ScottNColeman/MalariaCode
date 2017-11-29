function PlotODEs

% Creates Timespace
t = linspace(0,100,101);

% Ratio of mosquitos to humans
M = 1;

% Set Rates
r = 1/14;
%r = 0.001;
i = 1/20;
%i = 0.00001;
d = 0;
c = 1/6;
%c = 0.002;
%b = 1/2;
b = 0.00002;

% Set initial values
x0 = [0.99;0.01;0;1*M;0*M];
x1 = [0.5;0.5;0;0.5*M;0.5*M];
x2 = [(r*(b+c))/(b*(i+r));(b*i-c*r)/(b*(i+r));0;(c*(i+r))/(i*(b+c));(b*i-c*r)/(i*(b+c))];

% Create non-linear ODE
f = @(t,x) [r*x(2)-i*x(1)*x(5);-(r+d)*x(2)+i*x(1)*x(5);d*x(2); ... 
    c*x(5)-b*x(2)*x(4);-c*x(5)+b*x(2)*x(4)];

% Solve ODE using ode45
opts = odeset('RelTol',1e-3, 'AbsTol' ,1e-6);
[t,x] = ode45(f,t,x0,opts);

% Plot humans
figure;
plot(t,x(:,1),'b-',t,x(:,2),'g-',t,x(:,3),'r-');
hold on
%plot(t,ones(size(t))*x2(1),'b--')
%plot(t,ones(size(t))*x2(2),'g--')
%plot(t,ones(size(t))*x2(3),'r--')
xlabel('Time'); ylabel('Relative Population')
legend('Sus','Inf','Dead')
title('Humans')

% Plot mosquitos
figure;
plot(t,x(:,4),'c-',t,x(:,5),'m-');
hold on
%plot(t,ones(size(t))*x2(4),'c--')
%plot(t,ones(size(t))*x2(5),'m--')
xlabel('Time'); ylabel('Relative Population')
legend('Sus','Inf')
title('Mosquitoes')

end

