function [ c,ceq ] = radii( r, length, E, F, sigma_y)

    [ stress, Q] = TenBarAnalysis(r,length, E, F );
    %constrain 1  
    for i = 1:6
        c(i) = (stress(i,:)*pi()*r(1)^2) - ((pi()^2*E*0.25*pi()*r(1)^4) / (length^2));
    end
    for i = 7:10
         c(i) = (stress(i,:)*pi()*r(2)^2) - ((pi()^2*E*0.25*pi()*r(2)^4) / ((sqrt(2)*length)^2));
    end
    %constrain 2
    for i = 11:20
        c(11) = abs(stress(i-10,:)) -  sigma_y;
        
    ceq = 0;
    end

