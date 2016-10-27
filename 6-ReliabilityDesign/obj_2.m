function f2 = obj_2(r,length,E,F)

[~;Q] = TenBarAnalysis(r,length,E,F);

f2 = sqrt(Q(3)^2+Q(4)^2);
