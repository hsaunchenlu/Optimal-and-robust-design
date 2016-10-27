clear;
clc;
%% Parameter Setup
length = 9.14 ;                 % unit: m
E = 200e9 ;                     % unit: Pa

F = zeros(12,1) ;               % unit: N
F(4) = -1e7 ; 

sigma_y = 250e6 ;               % unit: Pa
rho = 7860 ;                    % unit: kg/m^3

%% Optimal Disign
%Initial Condition     
r0 = [1;1];
%r0 = [20;20];
%r0 = [30;30];

%Object Function
object = @(r)(6*pi()*r(1)^2*length) + (4*pi()*r(2)^2*sqrt(2)*length);

%Constrain Eq
A = [];                         %   linear inequalities
B = [];                         %   linear inequalities A*X <= B
Aeq = [];                       %   linear equalities 
Beq = [];                       %   linear equalities Aeq*X = Beq
lb = [];                        %   lower bound
ub = [];                        %   upper bound
nonlcon = @(r)radii(r,length,E,F,sigma_y); %nonlinear constrains
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
%options = optimset;

[r,fval,exitflag] = fmincon(object,r0,A,B,Aeq,Beq,lb,ub,nonlcon,options)
%   r is the optimal radius 
%   fval is the optimal value 
%   exitflag is the exit condition
wieght = fval * rho    %    optimal weight of tenbar system

    
