%% Parameter Input

 E = 200e9;              % unit: Pa
 Rho = 7860;             % unit: kg/m^3
 F = zeros(12,1);        % unit: N
 F(4) = 1e4;
 length = 1;             % unit: m
 sigma_y = 250e6;        % unit: Pa


r0 = [0.1,0.1];
options = optimset;
[ Ropt,Fopt, exitflag] = fmincon('obj_1',r0,[],[],[],[],[],[],'nonlcon',options);

[ Qopt,Fqopt, exitflag2] = fmincon('boj_2',r0,[],[],[],[],[],[],'nonlcon',options);
