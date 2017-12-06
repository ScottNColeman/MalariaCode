function [value] = B(model,s1,s2)
% Biting rate
%
% INPUTS:  s1 - residence time of M1
%          s2 - residence time of H2

b = 1/2;
switch model
    case 1
        value = b;
    case 2
        if s1 < 10
            value = 0;
        else
            value = b;
        end
    otherwise
        value = b;
end

end

