close all;
clear all;
clc;

im=double(imread('coins.jpg'))./255;

if size(im,3) ~= 1
    im=rgb2gray(im);
end;

tic;
[mx,my]=size(im);
lambda=10;
func_type=4;

% Compute the heuristic information of the image
eta=heuristic_compute(im, mx, my, lambda,func_type);

% Initialize Pheramone Matrix
tou_init=0.00001;
tou=tou_init*ones(mx,my);

%initialize variables
alpha=1;                    % probability alpha
beta=0.1;                     % probability beta
row=0.1;                    % global evaporation rate
phi=0.05;                   % local decay coeff.
qo=0.8;   
iter=3;
const_iter=80;              %80 step size

% initialize ants

K=round(sqrt(mx*my));                   % number of ants
ant.pos=rand(K,2);
ant.pos(:,1)=round(ant.pos(:,1)*mx);
ant.pos(:,2)=round(ant.pos(:,2)*my);
ant.pos(ant.pos==0)=1;
% ACO iterations

for iteration=1:iter
    ant.move=zeros(const_iter,2,K);         % ant memory
    q=rand(K,const_iter);
    for construction_step=1:const_iter
        for k=1:K                       %for each ant
%             comment the line below: adds about 26 seconds in execution
%             fprintf('Iteration: %d;  Construction Step: %d;  ant: %d\n', iteration, construction_step, k); 
            [prob, next_pos] = transition_prob( ant.pos(k,:), [mx my], eta, tou, alpha, beta );             
            [x,y] = goto_next( qo, q(k,construction_step), [mx my], prob, next_pos, ant.move(:,:,k));
            ant.move(construction_step,:,k)=[x y];
            ant.pos(k,:)=[x y];
            tou = local_update( [x y], tou, phi, tou_init );
        end;
    end;
    tou = global_update( tou, ant.move, row, eta, K );
end;
time=toc;

T = func_seperate_two_class(tou);
edges=ones(size(tou));
edges(tou>T)=2;
imshow(edges,[]);