function [ stress ] = TenBarAnalysis( r, length, E, F )
% TenBarAnalysis: Calculate stresses in each element by given spec. and force of the truss structure. 
%   input: radius r (composed of r1, r2), length l, Young's modulous E,
%   and Force array F.
%           Array F is composed of the external forces applied on each
%           node. The elements in F are respectively F1x, F1y, F2x, F2y, 
%           F3x, F3y, ...
%% Element Table Construction
% Node Table
n(1,:)=length*[2,1];
n(2,:)=length*[2,0];
n(3,:)=length*[1,1];
n(4,:)=length*[1,0];
n(5,:)=length*[0,1];
n(6,:)=length*[0,0];

% Element Connectivity Table
ec( 1,:)=[3 5];
ec( 2,:)=[1 3];
ec( 3,:)=[4 6];
ec( 4,:)=[2 4];
ec( 5,:)=[3 4];
ec( 6,:)=[1 2];
ec( 7,:)=[4 5];
ec( 8,:)=[3 6];
ec( 9,:)=[2 3];
ec(10,:)=[1 4];

% Element table
length_e(1:10,1) = NaN ;
l(1:10,1) = NaN ;
m(1:10,1) = NaN ;

for i=1:10
    length_e(i)=sum((n(ec(i,2),:)-n(ec(i,1),:)).^2).^0.5;
    l(i)=(n(ec(i,2),1)-n(ec(i,1),1))/length_e(i);
    m(i)=(n(ec(i,2),2)-n(ec(i,1),2))/length_e(i);
end

r = [r(1)*ones(6,1);r(2)*ones(4,1)] ;
A = pi*r.^2 ;

K=0;

for i=1:10

    k=zeros(12,12);
    k_small = E*A(i)/length_e(i)*[l(i) m(i)]'*[l(i) m(i)];
    k(ec(i,1)*2-1:ec(i,1)*2,ec(i,1)*2-1:ec(i,1)*2)=k_small;
    k(ec(i,2)*2-1:ec(i,2)*2,ec(i,2)*2-1:ec(i,2)*2)=k_small;
    k(ec(i,1)*2-1:ec(i,1)*2,ec(i,2)*2-1:ec(i,2)*2)=-k_small;
    k(ec(i,2)*2-1:ec(i,2)*2,ec(i,1)*2-1:ec(i,1)*2)=-k_small;
    
    K=K+k;
end

%% DOF Reduction
K_re=K(1:8,1:8) ;
F_re=F(1:8);

%% Displacement Calculatuin
Q_re=K_re^-1*F_re;
Q=[Q_re ;zeros(4,1)];

%% Stress Calculatuion
for i=1:10
    stress(i,:)=E/length_e(i,:)*[-l(i,:) -m(i,:) l(i,:) m(i,:)]...
        *[Q(ec(i,1)*2-1) Q(ec(i,1)*2) Q(ec(i,2)*2-1) Q(ec(i,2)*2)]' ;
end

K_R=K(9:12,:);
R=K_R*Q;
R=[zeros(8,1);R]; %Reactant Force on node 5 and node 6

end

