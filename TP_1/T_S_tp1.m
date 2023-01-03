%Manipulation 1:
close all
clear all
clc

t=-3:0.001:3;

sign1 = 2*sin(4*pi*t);
sign2=7*sin(8*pi*t);
sign3=0.5*sin(12*pi*t);
Signal_resultant= sign1 +sign2+sign3;

% figure(1)
% hold on
% plot(t,sign1,'y *');    
% plot(t,sign3,'b -');
% plot(t,sign2,'g');
% plot(t,Signal_resultant,'r *')
% legend('Sin1','Sin2','sin3','signal resultant')
% hold off



%Manipulation 2:
t=-1:0.001:1;
s=square(2*pi*t);

approx_1=Get_Approx(1,t);
approx_10=Get_Approx(10,t);
approx_100=Get_Approx(100,t);
approx_1000=Get_Approx(1000,t);

figure(2)
hold on;
plot(t,s,'black')
plot(t,approx_1,'y')
plot(t,approx_10,'g')
plot(t,approx_100,'r')
plot(t,approx_1000,'b')
legend('S(t)','Approximation 1','Approximation 10','Approximation 100','Approximation 1000')
hold off


approx_1=Get_Approx(1,t);
approx_2=Get_Approx(2,t);
approx_3=Get_Approx(3,t);
approx_4=Get_Approx(4,t);
approx_5=Get_Approx(5,t);

figure(3)
hold on
plot(t,s,'black')
% plot(t,approx_1,'r')
% plot(t,approx_2,'y')
% plot(t,approx_3,'g')
% plot(t,approx_4,'r')
plot(t,approx_5,'b')
legend('S(t)','Approximation 5')
hold off


