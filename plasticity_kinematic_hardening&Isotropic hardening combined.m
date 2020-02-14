clear;clc
%% Constants
n=1000;
t = linspace(0,10,n);
epsilon = 0.002*sin(2*pi*t);
E = 70e3;
sigmaY = E*1e-3;
K = 0;
gamma =0;
sigmatr =0;
epsilone =0;
relsigma=0;
m=0;
H=0.2*E;
%% Database 
sigma = zeros(1,n);
epsilonP =zeros(1,n);
alpha = zeros(1,n);
qn=zeros(1,n);
%%
for i=2:n
  epsilone = epsilon(1,i)-epsilonP(1,i-1);
  sigmatr = E*epsilone;
  relsigma = sigmatr - qn(1,i-1);
  ftr = abs(relsigma) - sigmaY - K*alpha(1,i-1);
  if ftr <= 0
      sigma(1,i) = sigmatr;
      epsilonP(1,i) = epsilonP(1,i-1);
      alpha(1,i) = alpha(1,i-1);
      qn(1,i)= qn(1,i-1);
  else
      gamma = ftr/((K+H)+E);
      epsilonP(1,i) = epsilonP(1,i-1)+ gamma*sign(relsigma);
      sigma(1,i) = sigmatr - E*gamma*sign(relsigma);
      qn(1,i)=qn(1,i-1)+gamma*H*sign(relsigma);
      alpha(1,i) = alpha(1,i-1)+gamma;
 end
 
end

plot(epsilon,sigma)
grid on