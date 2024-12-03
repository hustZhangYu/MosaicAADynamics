%  In this part, we study the expansion of Gaussian wavepacket 

% x^2 in the localized region 

% model 

L=987;
omega=(sqrt(5)-1)/2;
lambda=10;
H=diag(ones(1,L-1),1)+diag(ones(1,L-1),-1);
H=H+lambda*diag(cos(2*pi*omega*linspace(1,L,L)));
for m=1:L
   if mod(m,2)==0
      H(m,m)=0; 
   end
end

psi=zeros(L,1);
sigma=3;
for m=1:L
   psi(m,1)= exp(-(m-L/2)^2/sigma^2);
end
psi=psi/sqrt(sum(psi.*conj(psi)));
% plot(psi)

psi=zeros(L,1);
psi(floor(L/2),1)=1;

X=linspace(1,L,L)-L/2;
X2=diag(X.*conj(X));

T=0:0.05:3;
Data=zeros(1,length(T));
Data1=zeros(1,length(T));
Data2=zeros(1,length(T));

for m=1:length(T)
    T1=10^T(m);
    psit=expm(-1i*H*T1)*psi;
    Data(1,m)=real(psit'*X2*psit);
    psi2=psit.*conj(psit);
    psia=psit;
    psia(2:2:L)=0;
    Data1(1,m)=real(psia'*X2*psia);
    psia=psit;
    psia(1:2:L)=0;
    Data2(1,m)=real(psia'*X2*psia);
    hold off
    semilogy(1:2:L,psi2(1:2:L))
    hold on
    semilogy(2:2:L,psi2(2:2:L))
    xlim([1,L])
    ylim([10^(-10),1])
    f="t="+num2str(T(m));
    title(f)
%     pause(0.01)
   
end

figure()
semilogy(T,Data)
hold on;
semilogy(T,Data1)
semilogy(T,Data2)