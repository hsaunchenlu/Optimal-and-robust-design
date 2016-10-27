clc
clear
close all

%% Input Data 

failure_data = xlsread('failure_data.xlsx','A1:A38');
failure_situation = xlsread('failure_data.xlsx','B1:B38');

%% Parametric
di = 0;                             % ���ĭӼ� ��l��
N = 39;                             % N-1�����ռ˥���                          
P = zeros(38,1,'double');           % Phat �x�s��
T = zeros(38,1);                    % Time �x�s��
s = 1 ;                             % Shat ��l��
S = zeros(38,1,'double');           % Shat �x�s��
F = zeros(38,1,'double');           % Probability �x�s��
v = 0;                              % Var  ��l��
Var = zeros(38,1,'double');         % Var  �x�s��
Sef = zeros(38,1,'double');         % Sef  �x�s��
CI  = zeros(38,2,'double');         % CI   �x�s��

for i = 1 : 38
    if failure_situation(i) ~= 0
        di = 1;
        N = N - 1;
    elseif failure_situation(i) == 0 
        di = 0;
        N = N -1;
    end
    P(i) = di/N;                                    
    T(i) = failure_data(i);
    s = s * (1-P(i)); 
    S(i) = s; 
    F(i) = 1 - S(i);
    v = P(i)/(N*(1-P(i)));
    Var(i) = S(i)^2 * v;
    Sef(i) = sqrt(Var(i));
    CI(i,1) = F(i) - 1.96*0.095*Sef(i);
    CI(i,2) = F(i) + 1.96*0.095*Sef(i);
    
end
figure;
stairs(T,F); hold on;
axis([0 30000 0 1]);

figure;
stairs(T,CI(:,1),'g'); hold on;
stairs(T,CI(:,2),'r'); hold on;
stairs(T,F);
axis([0 30000 0 1]);

figure;
stairs(T,CI(:,1),'g:*'); hold on;
stairs(T,CI(:,2),'r:*'); hold on;
stairs(T,F);
axis([0 30000 0 1]);

[phat,pci] = mle(failure_data,'distribution','weibull','cencoring',failure_situation == 0)



% for i = 1 : 28100
%     
%     if i  == failure_data(n)
%         if failure_situation(n) ~= 0
%             di = 1 ;
%             N = N - 1;
%         elseif failure_situation(n) == 0  
%             di = 0;
%             N = N - 1;    
%         end
%     F(failure_data(n)) = di/N;
%     n = n + 1;
%     elseif i == failure_data(n) + 1
%         if failure_situation(n) ~= 0
%             di = 2 ;
%             N = N - 1;
%         elseif failure_situation(n) == 0  
%             di = 1;
%             N = N - 1;
%         end
%     F(failure_data(n-1)) = di/N;
%     F(failure_data(n)) = di/N;
%     n = n + 1;
%     elseif i ~= failure_data(n)
%         F(i) = 0;
%     end
%     T(i) = i; 
%     
% end
% figure;
% plot(T,F);
% axis([0 28100 0 1]);



