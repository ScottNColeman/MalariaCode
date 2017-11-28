function PlotODEs

% Creates Timespace
t = linspace(0,100,101);

% Ratio of mosquitos to humans
M = 2;

% Set Rates
r = 1/14;
i = 1/20;
d = 1/1000;
c = 1/6;
b = 1/2;

% Set initial values
x0 = [1;0;0;1*M;0*M];
x1 = [0.5;0.5;0;0.5*M;0.5*M];

% Create non-linear ODE
f = @(t,x) [r*x(2)-i*x(1)*x(5);-(r+d)*x(2)+i*x(1)*x(5);d*x(2); ... 
    c*x(5)-b*x(2)*x(4);-c*x(5)+b*x(2)*x(4)];

% Solve ODE using ode45
opts = odeset('RelTol',1e-3, 'AbsTol' ,1e-6);
[t,x] = ode45(f,t,x1,opts);

% Plot humans
figure;
plot(t,x(:,1),'b-',t,x(:,2),'g-',t,x(:,3),'r-');

% Plot mosquitos
figure;
plot(t,x(:,4),'c-',t,x(:,5),'m-');