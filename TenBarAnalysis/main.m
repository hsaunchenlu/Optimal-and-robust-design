%% Parameter Setup

r= [0.4 0.4]; % r1, r2;         % unit: m
length = 9.14 ;                 % unit: m
E = 200e9 ;                     % unit: Pa

F = zeros(12,1) ;               % unit: N
F(4) = -1e7 ;
% Array F is composed of the external forces applied on each node. 
% The elements in F are respectively F1x, F1y, F2x, F2y, F3x, F3y, ...

sigma_y = 250e6 ;               % unit: Pa
rho = 7860 ;                    % unit: kg/m^3



%% Analysis
[ stress ] = TenBarAnalysis( r, E, length, F )