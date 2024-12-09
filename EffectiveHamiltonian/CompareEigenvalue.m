function [index] = CompareEigenvalue(L,lambda,E,Ea,Eb)
%COMPAREEIGENVALUE �˴���ʾ�йش˺�����ժҪ
%   ͨ����Ч���ܶ����ع�ϵͳ�ı���̬
% E Ϊ�����ԭ���ܶ�������̬
% Ea, Eb�ֱ�Ϊ��Ч��չ��������ܶ����ı���ֵ
% L Ϊϵͳ�ߴ�,lambda Ϊdisorderǿ�ȣ���Ҫ���ƻ�ͼ��Χ
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

