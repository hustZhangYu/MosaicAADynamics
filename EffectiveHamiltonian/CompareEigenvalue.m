function [index] = CompareEigenvalue(L,lambda,E,Ea,Eb)
%COMPAREEIGENVALUE 此处显示有关此函数的摘要
%   通过有效哈密顿量重构系统的本征态
% E 为输入的原哈密顿量本征态
% Ea, Eb分别为有效扩展，局域哈密顿量的本征值
% L 为系统尺寸,lambda 为disorder强度，主要控制画图范围
E1=[Ea;Eb];

[E1,index]=sort(E1);
figure()

plot(E,'k.','markersize',10)
hold on;

color=[];
for i=1:L
   if index(i)<=length(Ea)
%       color=[color,'r']; 
      plot(i,E1(i),'ro','markersize',3)
   else
%       color=[color,'y'];
      plot(i,E1(i),'bo','markersize',3)
   end
   
end

ylim([-lambda,lambda])
xlabel('$n$','interpreter','latex')
ylabel('$E$','interpreter','latex')
set(gca,'fontsize',24)

legend('$H$','$H_o$','$H_e$','interpreter','latex','location','east')
end

