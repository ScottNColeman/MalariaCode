function [value] = I(model,s1,s2)
% Infection rate of humans
%
% INPUTS:  s1 - residence time of H1
%          s2 - residence time of M2

i = 1/20;

switch model
    case 1
        value = i;
    case 2
        if s2 < 10
            value = 0;
        else
            value = i;
        end
    otherwise
        value = i;
end

end

