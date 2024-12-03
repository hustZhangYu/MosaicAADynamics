% compare the dynamics from the effective hamiltonin evolution 
% with realistic Hamiltonian

clear all;
clc;

sample=100;

lambda=1; % lambda; quasiperiodic potential �Ĵ�С
L=987;  % ϵͳ�ĳߴ��ȡ쳲�����

b=(sqrt(5)-1)/2;
% kappa=2
kapa=2;

% mosaic hopping Hamiltonian
hop=ones(1,L-1);
H0=diag(hop,1)+diag(hop,-1);


% ���ɸ�˹����

index = 1:L;
sigma = 1; % ���Ʋ������
gaussian_wave_packet = exp(-(index - L/2).^2 / (2 * sigma^2));
psi0=gaussian_wave_packet'/sqrt(sum(gaussian_wave_packet .*gaussian_wave_packet ));

psi02=psi0.*conj(psi0);
t=10^-20;
psi0a=Truncate(psi02,t);



T_all=[0,10^1,10^2,10^3,10^4];

psiall=zeros(L,length(T_all));
psialla=zeros(L,length(T_all));
psiallb=zeros(L,length(T_all));

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

    index = 1:L;
    

    [Ve,V]=eig(H,'vector');


    
    for m=1:length(T_all)
        T=T_all(m);
    
        dimt=length(T);
        JOt=zeros(1,dimt);
        
        psi0=psi0a;

     
        psit=Ve*diag(exp(-1i*T*V))*Ve'*psi0;
            
        psiall(:,m)=psiall(:,m)+psit.*conj(psit);
        
    end
      
end
psiall=psiall/sample;    
save('psiallrea_2','psiall')

figure()
for i=1:length(T_all)
    subplot(length(T_all),1,i)

    psi=psiall(:,i);
    psialla=psi(1:2:L);
    semilogy(1:2:L,psialla,'d','markersize',5,'Color','r')
    hold on;
    psialla=psi(2:2:L);
    semilogy(2:2:L,psialla,'s','markersize',5,'Color','b')
    hold on;
    xlim([1,L])
    ylim([10^(-15),10^0])
       
end

function sq1=Truncate(sq,t)
% ԭʼ����
original_sequence = sq; % �뽫[your_sequence]�滻Ϊ���ʵ������

% �趨��ֵ
threshold_value = t; % �뽫5�滻Ϊ����Ҫ����ֵ

% ��С����ֵ������Ϊ0
sq1 = original_sequence;
for m=1:length(sq1)
    if sq1(m)<t
        sq1(m)=0;
    end
end

end