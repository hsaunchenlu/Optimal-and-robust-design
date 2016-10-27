clc
clear

%% Parameter Setup
length = 9.14 ;                 % unit: m
E = 200e9 ;                     % unit: Pa
F = zeros(12,1) ;               % unit: N
F(4) = -1e7 ; 
sigma_y = 250e6 ;               % unit: Pa
rho = 7860 ;                    % unit: kg/m^3

%% Find Utopia Point
nonlcon = @(r)Nonlcon(r,length,E,F,sigma_y);
r0 = [0.01,0.01];                                                                               % I.C
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');

[r_opt1,f_opt1] = fmincon('Object_f1',r0,[],[],[],[],[],[],nonlcon,options);                    % find optimal value of minimum weight of the truss system
A = [f_opt1,Object_f2(r_opt1)];                                                                 % 

[r_opt2,f_opt2] = fmincon('Object_f2',r0,[],[],[],[],[0,0],[1,1],nonlcon,options);              % find optimal value of minimum displacement at node 2
B = [Object_f1(r_opt2),f_opt2];

%% Find Pareto Set by Constrain Method
Obj_Space=figure;
plot(A(1),A(2),'r*',B(1),B(2),'b*'); hold on                                                                                    % plot two optimal point

figure(Obj_Space);
plot(A(1),B(2),'g*');                                                                                                           % plot Utopia point

N_Pareto = 1000;                                                                                                                % N segments

f1_const = linspace(f_opt1,Object_f1(r_opt2),N_Pareto);                                         

for i = 2 : N_Pareto-1
    [r_parset(i,:),f_parset(i)] = fmincon('New_Object_f2',r0,[],[],[],[],[0,0],[1,1],'Nonlcon_f1',options,f1_const(i));         % find the optimal value of f2 when f1 is fixed
    B(i,:) = [f1_const(i),f_parset(i)];                                                                                         % the point on Pareto set
    
    figure(Obj_Space)
    plot(B(i,1), B(i,2),'r*')                                                                                                   % plot the point on Pareto set  
end

fprintf('Utopia point is at (f1,f2) = (%8.5f kg,%8.5f m)',A(1),B(2))                                                            % value of Utopia point