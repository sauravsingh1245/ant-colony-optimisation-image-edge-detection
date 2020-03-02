function [ eta ] = heuristic_compute( im, mx, my, lambda, func )
%   Summary of this function goes here
%   This function calculates the Heuristic information for the image
op=zeros(mx,my);
for rr=1:mx
    for cc=1:my
        temp1 = [rr-2 cc-1; rr-2 cc+1; rr-1 cc-2; rr-1 cc-1; rr-1 cc; rr-1 cc+1; rr-1 cc+2; rr cc-1];
        temp2 = [rr+2 cc+1; rr+2 cc-1; rr+1 cc+2; rr+1 cc+1; rr+1 cc; rr+1 cc-1; rr+1 cc-2; rr cc+1];
        for loop=1:8
            if temp1(loop,1)>0 & temp1(loop,1)<=mx & temp2(loop,1)>0 & temp2(loop,1)<=mx & temp1(loop,2)>0 & temp1(loop,2)<=my & temp2(loop,2)>0 & temp2(loop,2)<=my
                op(rr,cc)=op(rr,cc)+abs(im(temp1(loop,1),temp1(loop,2))-im(temp2(loop,1),temp2(loop,2)));
            end;
        end;
    end;
end;
switch func
    case 1
        op = lambda.*op;
    case 2
        op = lambda.*op.^2; 
    case 3
        op = sin(pi.*op./2./lambda);
    otherwise
        op = sin(pi.*op./lambda).*pi.*op./lambda;
end;
eta = op./(sum(sum(op)));

end

