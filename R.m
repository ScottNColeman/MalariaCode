function [value] = R(s,model)
%R Summary of this function goes here
%   Detailed explanation goes here
% INPUTS:  s - residence time of class H2

r = 1/14;
switch model
    case 1
        value = r;
    case 2
        if s < 14
            value = 0;
        else
            value = r;
        end
    otherwise
        value = r;
end

end