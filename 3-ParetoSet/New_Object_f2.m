function [f2] = New_Object_f2(x,f1)

r=x;
length = 9.14 ;                 % unit: m
E = 200e9 ;                     % unit: Pa
F = zeros(12,1) ;               % unit: N
F(4) = -1e7 ; 

[~,Q] = TenBarAnalysis( r, length, E, F );

f2 = sqrt(Q(3)^2+Q(4)^2);