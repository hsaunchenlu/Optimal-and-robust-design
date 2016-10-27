function[g, geq] = Nonlcon_f1(x,f1)
length = 9.14 ;
r=x;
rho = 7860 ;                    % unit: kg/m^3

g = ((6*pi()*r(1)^2*length) + (4*pi()*r(2)^2*sqrt(2)*length))*rho - f1;
geq = [];
