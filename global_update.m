function [ tou_new ] = global_update( tou, move, row, eta, ants )
%   Summary of this function goes here
%   This function handles global pheromone update

temp=zeros(size(tou));
tour_steps=size(move,1);
temp2=zeros(size(tou));
for k=1:ants
    for i=1:tour_steps
        x=move(i,1,k);
        y=move(i,2,k);
        temp(x,y)=temp(x,y)+eta(x,y);
        temp2(x,y)=temp2(x,y)+1;
    end;
end;
temp2(temp2<=1)=0;
temp2(temp2~=0)=1;
tou_new=(1-row/2)*tou + row*temp.*temp2;
%tou_new=(1-row)*tou + row*temp;
% tou_new=(1-0.01)*tou_new + 0.01*temp2.*tou_new;
end