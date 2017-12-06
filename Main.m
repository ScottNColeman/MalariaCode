% Initial matrices to store t and s values
t = linspace(0,121,1201); % uses n index
s = t; % uses m index, half of these values are useless

% MATT - current model iteration.
model = 2;

i = 1/20;
b = 1/2;
r = 1/14;
c = 1/6;

Init = [(r*(b+c))/(b*(i+r));
        (b*i-c*r)/(b*(i+r));
        (c*(i+r))/(i*(b+c));
        (b*i-c*r)/(i*(b+c))];

% Initialise each class
u = zeros(length(t),length(s),4);

% Initial conditions
u(1,1,:) = [0.9,0.1,1,0]; % must be size I x 1
%u(1,1,:) = [1,0,0.9,0.1];
%u(1,1,:) = Init;
disp(1)

for n = 2:length(t)
    u(:,n,:) = PartialDifferentialEquation( u(:,n-1,:), t(n), t(n)-t(n-1), model );%, t(n), t(n)-t(n-1));
    disp(n)
end

%%
% Plot colour maps
gap = 1; % If takes ages to plot, increase this to plot less values
%st = transpose((0:gap:numSteps)*stepSize);
for k = 1:size(u,3)
    figure;
    contourf(t(201:gap:end), s(201:gap:end), u(201:gap:end,201:gap:end,k))
    colorbar
    xlabel('Time'); ylabel('Residence Time')
    
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
    
    figure;
    plot( t, sum(u(:,:,k),1) ) % total residence in each class against time
    xlabel('Time'); ylabel('Population')
    hold on
    plot(t,Init(k)*ones(size(t)),'--')
    %ylim([0,1])
end

%%
class = 1;

switch class
    case 1
        % H1
        a = (R*(B*I-C*R))/(B*(I+R));
        b = (B*I-C*R)/(B+C);
    case 2
        % H2
        a = (R*(B*I-C*R))/(B*(I+R));
        b = R;
    case 3
        % M1
        a = (C*(B*I-C*R))/(I*(B+C));
        b = (B*I-C*R)/(I+R);
    case 4
        % M2
        a = (C*(B*I-C*R))/(I*(B+C));
        b = C;
end

u_pred = (s(2)-s(1))*a*(1-(s(2)-s(1))*b).^(0:length(s)-1);

%figure;
%plot(s,u(:,end,class),'r-')
%hold on
%plot(s,u_pred,'g--')
