% 计算态密度
clear all;
clc;
L=987;%可取斐波那契
lambda=30;
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
    mu(j)=2*cos(2*pi*b*j+phase);
    mu1=[mu1,mu(j)];
    end
end
H=lambda*diag(mu)+H0;
[Ev,E]=eig(H,'vector');
Delta=getDos(E,Ev);

domega=2/200;
omega_all=-1:domega:1;
plot(omega_all,Delta/(sum(Delta)*domega))
hold on;

% xlabel('$E$','interpreter','latex')
% ylabel('$\rho(E)$','interpreter','latex')
% legend('$\lambda=10$','$\lambda=20$','interpreter','latex')


function Delta=getDos(E,Ev)

Ddata2=E;

domega=2/200;
omega_all=-1:domega:1;
fw=zeros(1,length(omega_all));
Delta=zeros(1,length(omega_all));

epslion=0.01;
for i=1:length(omega_all)
    omega=omega_all(i);
    Delta(i)=sum(1./((Ddata2-omega*ones(size(Ddata2))).*conj(Ddata2-omega*ones(size(Ddata2)))+epslion^2*ones(size(Ddata2))));
    Delta(i)=epslion*Delta(i)/pi;
end

end



function a2 = Ipr(psi)
%IPR get the Ipr for a vector \sum_i|psi_i|^4
%  
a=psi.*conj(psi);
a2=sum(a.^2);
end