function [ tou_new ] = local_update( pos, tou, phi, tou_init )
%   Summary of this function goes here
%   This function handles local pheromone update

tou(pos(1),pos(2)) = (1-phi)*tou(pos(1),pos(2)) + phi*tou_init;
tou_new = tou;

end

