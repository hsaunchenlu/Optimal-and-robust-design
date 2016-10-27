function [g,eq] = nonlcon(rmu,length,E,F,sigma_y)



MCS = 1000;

r1 = normrnd(rmu(1),0.1*rmu(1),MCS,1);
r2 = normrnd(rmu(2),0.1*rmu(2),MCS,1);
r = [r1,r2];
E = normrnd(E,0.1*E,MCS,1);
c1 = zeros(MCS,1);
c2 = zeros(MCS,1);
c3 = zeros(MCS,1);
c4 = zeros(MCS,1);
c5 = zeros(MCS,1);
c6 = zeros(MCS,1);
c7 = zeros(MCS,1);
c8 = zeros(MCS,1);
c9 = zeros(MCS,1);
c10 = zeros(MCS,1);
c11 = zeros(MCS,1);
c12 = zeros(MCS,1);
c13 = zeros(MCS,1);
c14 = zeros(MCS,1);
c15 = zeros(MCS,1);
c16 = zeros(MCS,1);
c17 = zeros(MCS,1);
c18 = zeros(MCS,1);
c19 = zeros(MCS,1);
c20 = zeros(MCS,1);
c21 = zeros(MCS,1);


for i = 1 : MCS
        [stress,Q] = TenBarAnalysis(r,length,E,F);
        
        c1(i) = (stress(1,i)*pi()*r(i,1)^2) - ((pi()^2*E*0.25*pi()*r(i,1)^4) / (length^2));
        c2(i) = (stress(2,i)*pi()*r(i,1)^2) - ((pi()^2*E*0.25*pi()*r(i,1)^4) / (length^2));
        c3(i) = (stress(3,i)*pi()*r(i,1)^2) - ((pi()^2*E*0.25*pi()*r(i,1)^4) / (length^2));
        c4(i) = (stress(4,i)*pi()*r(i,1)^2) - ((pi()^2*E*0.25*pi()*r(i,1)^4) / (length^2));
        c5(i) = (stress(5,i)*pi()*r(i,1)^2) - ((pi()^2*E*0.25*pi()*r(i,1)^4) / (length^2));
        c6(i) = (stress(6,i)*pi()*r(i,1)^2) - ((pi()^2*E*0.25*pi()*r(i,1)^4) / (length^2));
        
        c7(i) = (stress(7,i)*pi()*r(i,2)^2) - ((pi()^2*E*0.25*pi()*r(i,2)^4) / ((sqrt(2)*length)^2));
        c8(i) = (stress(8,i)*pi()*r(i,2)^2) - ((pi()^2*E*0.25*pi()*r(i,2)^4) / ((sqrt(2)*length)^2));
        c9(i) = (stress(9,i)*pi()*r(i,2)^2) - ((pi()^2*E*0.25*pi()*r(i,2)^4) / ((sqrt(2)*length)^2));
        c10(i) = (stress(10,i)*pi()*r(i,2)^2) - ((pi()^2*E*0.25*pi()*r(i,2)^4) / ((sqrt(2)*length)^2));


        c11(i) = abs(stress(1,i)) -  sigma_y;
        c12(i) = abs(stress(2,i)) -  sigma_y;
        c13(i) = abs(stress(3,i)) -  sigma_y;
        c14(i) = abs(stress(4,i)) -  sigma_y;
        c15(i) = abs(stress(5,i)) -  sigma_y;
        c16(i) = abs(stress(6,i)) -  sigma_y;
        c17(i) = abs(stress(7,i)) -  sigma_y;
        c18(i) = abs(stress(8,i)) -  sigma_y;
        c19(i) = abs(stress(9,i)) -  sigma_y;
        c20(i) = abs(stress(10,i)) -  sigma_y;

        c21(i) = sqrt(Q(3,i)^2 + Q(4,i)^2) - 2;
end

    Pg1 = sum(c1 >0)/MCS;
    Pg2 = sum(c2 >0)/MCS;
    Pg3 = sum(c3 >0)/MCS;
    Pg4 = sum(c4 >0)/MCS;
    Pg5 = sum(c5 >0)/MCS;
    Pg6 = sum(c6 >0)/MCS;
    Pg7 = sum(c7 >0)/MCS;
    Pg8 = sum(c8 >0)/MCS;
    Pg9 = sum(c9 >0)/MCS;
    Pg10 = sum(c10 >0)/MCS;
    Pg11 = sum(c11 >0)/MCS;
    Pg12 = sum(c12 >0)/MCS;
    Pg13 = sum(c13 >0)/MCS;
    Pg14 = sum(c14 >0)/MCS;
    Pg15 = sum(c15 >0)/MCS;
    Pg16 = sum(c16 >0)/MCS;
    Pg17 = sum(c17 >0)/MCS;
    Pg18 = sum(c18 >0)/MCS;
    Pg19 = sum(c19 >0)/MCS;
    Pg20 = sum(c20 >0)/MCS;
    Pg21 = sum(c21 >0)/MCS;
    
   g = [Pg1,Pg2,Pg3,Pg4,Pg5,Pg6,Pg7,Pg8,Pg9,Pg10,Pg11,Pg12,Pg13,Pg14,Pg15,Pg16,Pg17,Pg18,Pg19,Pg20,Pg21] ;
   