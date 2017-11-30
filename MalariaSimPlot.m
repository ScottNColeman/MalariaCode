function MalariaSimPlot(uInit,u,numSteps,stepSize)

t = (0:numSteps) * stepSize; % uses n index
s = t; % uses m index, half of these values are useless
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
    plot( t, sum(uu(:,:),1) ) % total residence in each class against time
    xlabel('Time'); ylabel('Population')
end