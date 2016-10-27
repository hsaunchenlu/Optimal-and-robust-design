function[f1] = Object_f1(x)
length = 9.14 ;
rho = 7860 ;                    % unit: kg/m^3

r=x;
f1 = ((6*pi()*r(1)^2*length) + (4*pi()*r(2)^2*sqrt(2)*length))*rho;


