function [value] = C(s,model)
% Circulation rate -  rebirth of mosquitoes
%   Detailed explanation goes here
% INPUTS:  s - residence time of class M2

c = 1/6;
switch model
    case 1
        value = c;
    case 2
        value = c;
    case 3
        value = c;
    otherwise
        value = c;
end

end