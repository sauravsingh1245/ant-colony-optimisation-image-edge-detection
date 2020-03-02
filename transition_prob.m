function [ prob, next_pos] = transition_prob( pos, max, eta, tou, alpha, beta )
%   Summary of this function goes here
%   This function calculates the probability of selecting a path out of
%   all neighbouring paths available
%   pos is a 2X1 matrix [row column] for current position of the ant
%   
%   prob:[1 2 3 4 5 6 7 8]
%   [   1       2       3   ]
%   [   4     (x,y)     5   ]
%   [   6       7       8   ]

prob=zeros(8,1);
next_pos=zeros(8,2);

x=pos(1)+1;
y=pos(2)+1;
mx=max(1);
my=max(2);

eta=[zeros(1,my);     eta;      zeros(1,my)];
eta=[zeros(mx+2,1)    eta       zeros(mx+2,1)];
tou=[zeros(1,my);     tou;      zeros(1,my)];
tou=[zeros(mx+2,1)    tou       zeros(mx+2,1)];

temp=zeros(3,3);

for i=1:3
    for j=1:3
        temp(i,j)= (tou(x+i-2,y+j-2)^alpha)*(eta(x+i-2,y+j-2)^beta);
    end;
end;

prob=[temp(1,1) temp(1,2) temp(1,3) temp(2,1) temp(2,3) temp(3,1)... 
    temp(3,2) temp(3,3)];

den=sum(prob);

if den ~= 0
    prob=prob./den;
end;

next_pos=[  pos(1)-1    pos(2)-1;
            pos(1)-1    pos(2);
            pos(1)-1    pos(2)+1;
            pos(1)      pos(2)-1;
            pos(1)      pos(2)+1;
            pos(1)+1    pos(2)-1;
            pos(1)+1    pos(2);
            pos(1)+1    pos(2)+1    ];

end