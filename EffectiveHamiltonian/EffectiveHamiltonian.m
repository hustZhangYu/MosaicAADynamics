% here we study the time evolution of the effective Hamiltonian

clear all;
clc;

lambda=20; % lambda; quasiperiodic potential 的大小
L=987;  % 系统的尺寸可取斐波那契

b=(sqrt(5)-1)/2;
% kappa=2
kapa=2;

% mosaic hopping Hamiltonian
hop=ones(1,L-1);
H0=diag(hop,1)+diag(hop,-1);

    phase=2*pi*rand();
    mu=zeros(1,L);
    
    for j=1:L
        if mod(j,kapa)==0
           mu(j)=2*cos(2*pi*b*j+phase);
        else
            mu(j)=0;
        end
    end
    H=lambda*diag(mu)+H0;
    [Ve,V]=eig(H,'vector');
    
 
 % 上面给出的是真实哈密顿量给出的演化，接下来我们构造有效哈密顿量
 
 Heff=zeros(L,L);
 S=zeros(L,L);
 mu=lambda*mu;
 t=1;
 i=1;
Heff(i,i)=Heff(i,i)-t/mu(i+1);
Heff(i+2,i)=Heff(i+2,i)-t/mu(i+1);
Heff(i,i+2)=Heff(i,i+2)-t/mu(i+1);
Heff(i+2,i+2)=Heff(i+2,i+2)-t/mu(i+1);
Heff(i+1,i+1)=mu(i+1)+2*t/mu(i+1);
Heff(i+1,i+3)=t*(mu(i+1)+mu(i+3))/(mu(i+1)*mu(i+3));
Heff(i+3,i+1)=t*(mu(i+1)+mu(i+3))/(mu(i+1)*mu(i+3));
 for i=1:2:L
    if i+3<=L 
        Heff(i,i)=Heff(i,i)-t/mu(i+1);
        Heff(i+2,i)=Heff(i+2,i)-t/mu(i+1);
        Heff(i,i+2)=Heff(i,i+2)-t/mu(i+1);
        Heff(i+2,i+2)=Heff(i+2,i+2)-t/mu(i+1);
        Heff(i+1,i+1)=mu(i+1)+2*t/mu(i+1);
        Heff(i+1,i+3)=t*(mu(i+1)+mu(i+3))/(2*mu(i+1)*mu(i+3));
        Heff(i+3,i+1)=t*(mu(i+1)+mu(i+3))/(2*mu(i+1)*mu(i+3));   
    end
 end
 

 % 接下来得到He和Hl
[rows, cols] = size(Heff);
% 选择奇数行和奇数列的索引
oddRows = 1:2:rows;
oddCols = 1:2:cols;
% 从原始矩阵中提取奇数行和奇数列的元素
He = Heff(oddRows, oddCols);
[Ev,E]=eig(He,'vector');

% 选择偶数行和偶数列的索引
oddRows = 2:2:rows;
oddCols = 2:2:cols;
% 从原始矩阵中提取奇数行和奇数列的元素
Hl = Heff(oddRows, oddCols);
[Ev1,E1]=eig(Hl,'vector');


index=CompareEigenvalue(L,lambda,V,E,E1);
CompareIPR(L,Ve,Ev,Ev1,index);