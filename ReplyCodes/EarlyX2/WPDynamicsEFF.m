% compare the dynamics from the effective hamiltonin evolution 
% with realistic Hamiltonian

% We calculate the inrease of the <x2>.


clear all;
clc;

sample=10;

lambda=10; % lambda; quasiperiodic potential 的大小
L=987;  % 系统的尺寸可取斐波那契

b=(sqrt(5)-1)/2;
% kappa=2
kapa=2;

% mosaic hopping Hamiltonian
hop=ones(1,L-1);
H0=diag(hop,1)+diag(hop,-1);


% 生成高斯波包

index = 1:L;
sigma = 1; % 控制波包宽度
gaussian_wave_packet = exp(-(index - L/2).^2 / (2 * sigma^2));
psi0=gaussian_wave_packet'/sqrt(sum(gaussian_wave_packet .*gaussian_wave_packet ));

psi02=psi0.*conj(psi0);
t=10^-20;
psi0a=Truncate(psi02,t);



T_all=10.^(0:0.01:3);

DataH=zeros(1,length(T_all));
DataHeff=zeros(1,length(T_all));
X=linspace(1,L,L)-floor(L/2);
X2=diag(X.*X);




for s=1:sample
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

        % Next, we give the gaussian wavepacket dynamics
    Hn=H;
    [Ve,V]=eig(Hn,'vector');

    for m=1:length(T_all)
        T=T_all(m);
        psi0=psi0a;
        psit=Ve*diag(exp(-1i*T*V))*Ve'*psi0;
        DataH(1,m)=DataH(1,m)+real(psit'*X2*psit);
    end
      
    
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
            
            S(i,i+1)=-t/mu(i+1);
            S(i+1,i)=t/mu(i+1);
            S(i+1,i+2)=t/mu(i+1);
            S(i+2,i+1)=-t/mu(i+1);
        end
    end
    

    % Next, we give the gaussian wavepacket dynamics
    Hn=Heff;
    [Ve,V]=eig(Hn,'vector');   
    for m=1:length(T_all)
        T=T_all(m);
        psi0=expm(S)*psi0a;
        psit=Ve*diag(exp(-1i*T*V))*Ve'*psi0;
        psit=expm(-S)*psit;
        DataHeff(1,m)=DataHeff(1,m)+real(psit'*X2*psit);
    end
      
end

loglog(T_all,real(DataHeff)/sample)
hold on;
loglog(T_all,real(DataH)/sample)



function sq1=Truncate(sq,t)
% 原始序列
original_sequence = sq; % 请将[your_sequence]替换为你的实际序列

% 设定阈值
threshold_value = t; % 请将5替换为你想要的阈值

% 将小于阈值的数设为0
sq1 = original_sequence;
for m=1:length(sq1)
    if sq1(m)<t
        sq1(m)=0;
    end
end

end