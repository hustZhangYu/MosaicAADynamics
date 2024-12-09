function [] = CompareIPR(L,Ev,Eva,Evb,index)
%COMPAREIPR 此处显示有关此函数的摘要
%   此处显示详细说明
figure()
IPR=zeros(1,L);
IPR1=zeros(1,size(Eva,1));
IPR2=zeros(1,size(Evb,1));

for i=1:L
   IPR(i)=Ipr(Ev(:,i)); 
end

for i=1:size(Eva,1)
   IPR1(i)=Ipr(kron(Eva(:,i),[1;0])); 
end

for i=1:size(Evb,1)
   IPR2(i)=Ipr(kron(Evb(:,i),[1;0])); 
end



semilogy(IPR,'k.','markersize',3)
hold on;
IPRn1=[IPR1,IPR2];
IPRn=IPRn1*0;
for i=1:L
    IPRn(i)=IPRn1(index(i));
end

for i=1:L
   if index(i)<=size(Eva,1)
%       color=[color,'r']; 
      semilogy(i,IPRn(i),'ro','markersize',3)
   else
%       color=[color,'y'];
      semilogy(i,IPRn(i),'bo','markersize',3)
   end
end

xlabel('$n$','interpreter','latex')
ylabel('$IPR$','interpreter','latex')
set(gca,'fontsize',24)

legend('$H$','$H_o$','$H_e$','interpreter','latex','location','east')
end


function a2 = Ipr(psi)
%IPR get the Ipr for a vector \sum_i|psi_i|^4
%  
a=psi.*conj(psi);
a2=sum(a.^2);
end
