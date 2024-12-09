L_all=[233,377,610,987];
data=zeros(1,length(L_all));
sample=100;
for s=1:sample
    for i=1:length(L_all)
        data(i)=data(i)+get(L_all(i),1);
    end
end
data=data/sample;

figure()
a=plot(1./log(L_all),-log(data)./log(L_all),'bo','linewidth',2);
hold on;

p=polyfit(1./log(L_all),-log(data)./log(L_all),1);
plot(linspace(0,0.3,100),p(1)*linspace(0,0.3,100)+p(2),'k','linewidth',2)


data=zeros(1,length(L_all));
for s=1:sample
    for i=1:length(L_all)
        data(i)=data(i)+get(L_all(i),2);
    end
end
data=data/sample;

b=plot(1./log(L_all),-log(data)./log(L_all),'ro','linewidth',2);
hold on;

p=polyfit(1./log(L_all),-log(data)./log(L_all),1);
plot(linspace(0,0.3,100),p(1)*linspace(0,0.3,100)+p(2),'k','linewidth',2)

axis([0,0.3,0,1])
xlabel('$1/\ln(L)$','interpreter','latex','fontsize',24)
ylabel('$-\ln(I_2)/\ln(L)$','interpreter','latex','fontsize',24)
set(gca,'fontsize',24)

legend([a,b],'$n/L\approx 0.25$','$n/L\approx0.45$','interpreter','latex','location','west')

function data=get(L,m)
lambda=20;
b=(sqrt(5)-1)/2; %可取黄金比也可以rational number
kapa=2;

% mosaic Hamiltonian
hop=ones(1,L-1);
H0=diag(hop,1)+diag(hop,-1);
phase=2*pi*rand();
mu=zeros(1,L);

mu1=[];
for j=1:L
    if mod(j,kapa)==1
        mu(j)=0;
    else
    mu(j)=cos(2*pi*b*j+phase);
    mu1=[mu1,mu(j)];
    end
end
H=lambda*diag(mu)+H0;

% 构造有效哈密顿量 Heff
HL=diag(mu1+2*ones(1,length(mu1))./mu1);
He=zeros(L-length(mu1),L-length(mu1));
He(1,1)=-1/mu1(1);
for i=2:size(He,1)-2
    He(i,i-1)=-1/mu1(i);
    He(i-1,i)=-1/mu1(i);
    He(i,i)=-1/mu1(i)-1/mu1(i+1);
end
He(i+1,i+1)=-1/mu1(i);



[Ev2,Eb]=eig(He,'vector');
if m==1
    n=floor(length(He)/4);
else
    n=floor(0.45*length(He));
end
% psi=kron(Ev2(:,n),[1;0]);
psi=Ev2(:,n);
data=Ipr(psi)


end


function alpha = scalingexponent(L_all,data1)
%SCALINGEXPONENT 此处显示有关此函数的摘要
%   L_all 代表的是相应的格点尺寸
%   data1 代表的平均IPR ，或者是 typical的
    x=log(L_all);
    y=log(data1);
    p=polyfit(x,y,1);
    alpha=-p(1);
end

function [alpha,b] = scalingexponent1(L_all,data1)
%SCALINGEXPONENT 此处显示有关此函数的摘要
%   L_all 代表的是相应的格点尺寸
%   data1 代表的平均IPR ，或者是 typical的
    x=log(L_all);
    y=log(data1);
    p=polyfit(x,y,1);
    alpha=p(1);
    b=p(2);
end

function a2 = Ipr(psi)
%IPR get the Ipr for a vector \sum_i|psi_i|^4
%  
a=psi.*conj(psi);
a2=sum(a.^2);
end