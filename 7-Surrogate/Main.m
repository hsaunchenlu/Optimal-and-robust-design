clc
clear 
close all

%% Parameter Input

 E = 200e9;              % unit: Pa
 Rho = 7860;             % unit: kg/m^3
 F = zeros(12,1);        % unit: N
 F(4) = 1e7;
 length = 9.14;             % unit: m
 sigma_y = 250e6;        % unit: Pa
 
%% 1
load('E:\Course\105 Semester 1\穩健與可靠度分析\HW8\surrogate_example\DOE2_60');
r =  0.4*x + 0.1;                                                              % scale the variables

%% 2
for i = 1 : 60
    [~, dis(i,1)] = TenBarAnalysis(r(i,:), length, E, F);                      % run 60 sample points using FEM
    
end

%% 3&4
for i = 1 : 60                                                                 % leave-one-out strategy
    S = r;
    S(i,:) = [];
    SS(:,:,i) = S;
end

for i = 1 :60
    for j = 1 : 59
        [~, dis2(j,i)] = TenBarAnalysis(SS(j,:,i), length, E, F);
    end
    
    x1 = SS(:,1,i);
    y1 = SS(:,2,i);
    z1 = dis2(:,i);
    
    fit2 = fit([x1,y1],z1,'poly22');
    fit3 = fit([x1,y1],z1,'poly33');
    
    ffit2(i,1) = fit2(r(i,1),r(i,2));
    ffit3(i,1) = fit3(r(i,1),r(i,2));
    
end

error2 = ffit2 - dis;
error3 = ffit3 - dis;



fit22 = fit(r,dis,'poly22');
fit33 = fit(r,dis,'poly33');

figure
stem(1:60,error2)
xlabel('60 samples')
ylabel('error of the 2nd order polynomial')


figure
stem(1:60,error3)
xlabel('60 samples')
ylabel('error of the 3rd order polynomial')


%% 5

r0=[0.1;0.1];       

           
options=optimset('display','iter-detailed','Algorithm','sqp');      
[r,fval,exitflag]=fmincon('obj_1',r0,[],[],[],[],[0,0],[0.5,0.5],@(r)Nonlcon(r,fit33),options)



