% 我们给出kappa=2情况下， 分形维度

clear all;
clc;


% lambda; quasiperiodic potential 的大小


L=987;%可取斐波那契
%2是AA的相变点

b=(sqrt(5)-1)/2;


kapa=2;

% mosaic Hamiltonian
hop=ones(1,L-1);
H0=diag(hop,1)+diag(hop,-1);

phase=2*pi*rand();
mu=zeros(1,L);


lambda_all=0:0.1:10;

DataA=zeros(length(lambda_all),L);
DataB=zeros(length(lambda_all),L);


for m=1:length(lambda_all)
    lambda=lambda_all(m);
    for j=1:L
        if mod(j,kapa)==0
            mu(j)=2*cos(2*pi*b*j+phase);
        else
            mu(j)=0;
        end
    end
    H=lambda*diag(mu)+H0;
    [Ve,V]=eig(H,'vector');
   
    DataA(m,:)=V;
    for k=1:L
        DataB(m,k)=Ipr(Ve(:,k));
    end

end
EVIprPlot(lambda_all,DataA,-log(DataB)/log(L))
xlabel('$ \lambda$','interpreter','latex');
ylabel('$ E $','interpreter','latex');    
caxis([0,1])

set(gca,'fontsize',24)
hold on;

plot(lambda_all,1./lambda_all,'r--','linewidth',2)
plot(lambda_all,-1./lambda_all,'r--','linewidth',2)
xlim([0,max(lambda_all)])
ylim([-5,5])
function [] = EVIprPlot(V_all,DataEAll,DataAll)
%EVIPRPLOT 画图显示 E_V_Ipr 图，其中 Ipr代表颜色栏。
%    parameters : 
%    V_all : 可调参数 
%    DataEAll: 输入能量的数值 为N*L 矩阵。（纵轴坐标）
%    DataAll: 输入 Ipr的数值 为 N*L 矩阵。 （颜色轴）
% 注意： DataEAll 的行指标是V ，纵指标是格点。

L=size(DataEAll,2);
DataX=zeros(length(V_all),L);
for i=1:length(V_all)
   DataX(i,:)=ones(1,L)*V_all(i);  
end
for i=1:length(V_all)
    scatter(DataX(i,:),DataEAll(i,:),'.','cdata',(DataAll(i,:)))
    hold on;
end
colorbar()

end
 
function a2 = Ipr(psi)
%IPR get the Ipr for a vector \sum_i|psi_i|^4
%  
a=psi.*conj(psi);
a2=sum(a.^2);
end
