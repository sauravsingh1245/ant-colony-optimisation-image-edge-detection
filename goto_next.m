function [ nextx,nexty ] = goto_next( qo, q, Max, prob, next_pos, move )
%   Summary of this function goes here
%   Detailed explanation goes here


nextx=0;
nexty=0;

% remove previously visited nodes in this iteration
previous_visited=[];

for i=1:size(next_pos,1)
    for j=1:size(move,1)
        if next_pos(i,:)==move(j,:) & move(j,:)~=[0 0]
            next_pos(i,:)=[0,0];
            previous_visited=[previous_visited; move(j,:)];
            break;
        end;
    end;
end;

% remove out of bound next position
temp1=next_pos(:,1);
temp2=next_pos(:,2);
temp1(temp1<1 | temp1>Max(1))=0;
temp2(temp2<1 | temp2>Max(2))=0;
temp3=temp1.*temp2;
temp3(temp3~=0)=1;

next_pos=next_pos(temp3==1,:);
prob=prob(temp3==1);

if sum(prob)==0
    if sum(temp3)==0
        nextx=previous_visited(1,1);
        nexty=previous_visited(1,2);
    else
        nextx=next_pos(1,1);
        nexty=next_pos(1,2);
    end;
elseif q<qo
    [t1,t2]=max(prob);
    nextx=next_pos(t2,1);
    nexty=next_pos(t2,2);
else
    prob=prob./sum(prob);
    f = find(rand<=cumsum(prob),1,'first');
    nextx=next_pos(f,1);
    nexty=next_pos(f,2);
end;

end