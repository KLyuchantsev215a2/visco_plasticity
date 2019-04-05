function [devx]=dev(x)
% input:  x = 3x3 matrix
% output: devx = dev(x)
devx=x - 1/3*trace(x)*eye(3);