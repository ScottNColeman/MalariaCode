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
end  
figure;
col = ['b-' 'g-' 'r-' 'm-' 'k-' 'b-' 'g-' 'r-' 'm-' 'k-'];
for i = 1:size(uInitu,3)
    if i == 6
<<<<<<< HEAD
        legend({'Sus','Inf (no)','Inf (yes)','Isolation'},'FontSize',16);
        title('Humans')
        figure;
    end
    if i ~= 5 && i~=10
        hold on;
        uu = transpose(uInitu(:,:,i));
        plot( t, sum(uu(:,:),1),col(i),'LineWidth',2) % total residence in each class against time
        xlabel('Time','FontSize',20); ylabel('Relative Population','FontSize',20)
    end

end
legend({'Young','Sus','Inf (Inc)','Inf'},'FontSize',16);
title('Mosquitos')
end
=======
        figure;
    end
    hold on;
    uu = transpose(uInitu(:,:,i));
    plot( t, sum(uu(:,:),1),col(i)) % total residence in each class against time
    xlabel('Time'); ylabel('Population')
    
end
end
>>>>>>> 18b1775e0b8f44731dfb905274af630adb65dee3
