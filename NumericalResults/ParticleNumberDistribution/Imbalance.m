% In this part, we take sample averages for different disorder realization 

% parameters
L=100;
N=L/2;

% initial state :all the odd sites are occupied.
P=zeros(L,N);
for i=1:N
   P(2*i-1,i)=1;
end

% for i=1:N
%    P(i,i)=1;
% end


Cij=zeros(L,L);

for i=1:L
    for j=1:L
       Pa=zeros(L,N+1);
       Pa(:,1:N)=P;
       Pa(i,N+1)=1;
       Pb=zeros(L,N+1);
       Pb(:,1:N)=P;
       Pb(j,N+1)=1;
       Cij(i,j)=det(Pb'*Pa);
    end
end
Cij=eye(L)-Cij;

sample=100;
% this part ,we give the Hamiltonian and give the spectrum

T_all=10.^(-2:0.01:4);

lambda_all=[0.1,1,5,10];

omega=(sqrt(5)-1)/2;
Data=zeros(length(lambda_all),length(T_all));
H0=diag(ones(1,L-1),1)+diag(ones(1,L-1),-1);
for s=1:sample

    phi=2*pi*rand();
    for n=1:length(lambda_all)
        lambda=lambda_all(n);
        V=lambda*cos(2*pi*omega*linspace(1,L,L)+phi);
        V(2:2:L)=0;
        H=H0+diag(V);

        [U,E]=eig(H,'vector');

        for m=1:length(T_all)
            T=T_all(m);
            D=conj(U)*diag(exp(1i*E*T))*conj(inv(U))*Cij*inv(U).'*diag(exp(-1i*E*T))*U.';
            X=-1*(-1).^linspace(1,L,L)/N;
            Data(n,m)=Data(n,m)+sum(real(diag(D)).*X');
        end
    
    end


end
Data=Data/sample;


figure()

c=[237,173,197]/255;
semilogx(T_all,Data(1,:),'-','Color',c,'linewidth',1.5) 
hold on;

c=[206,170,208]/255;
semilogx(T_all,Data(2,:),'-','Color',c,'linewidth',1.5) 
hold on;


c=[149,132,193]/255;
semilogx(T_all,Data(3,:),'-','Color',c,'linewidth',1.5) 
hold on;

c=[108,190,195]/255;
semilogx(T_all,Data(n,:),'-','Color',c,'linewidth',1.5) 
hold on;


interval = 30;
markerIndices = 1:interval:length(T_all);


x=T_all;y1=Data(1,:);
c=[237,173,197]/255;
a1=semilogx(x(markerIndices), 20*ones(1,length(markerIndices))+y1(markerIndices), '-+', 'MarkerSize', 8,'Color',c, 'LineWidth', 1.5);
x=T_all;y2=Data(2,:);
c=[206,170,208]/255;
a2=semilogx(x(markerIndices), 20*ones(1,length(markerIndices))+y2(markerIndices), '-o', 'MarkerSize', 8,'Color',c, 'LineWidth', 1.5);
x=T_all;y3=Data(3,:);
c=[149,132,193]/255;
a3=semilogx(x(markerIndices), 20*ones(1,length(markerIndices))+y3(markerIndices), '-s', 'MarkerSize', 8,'Color',c, 'LineWidth', 1.5);
x=T_all;y4=Data(4,:);
c=[108,190,195]/255;
a4=semilogx(x(markerIndices), 20*ones(1,length(markerIndices))+y4(markerIndices), '-d', 'MarkerSize', 8,'Color',c, 'LineWidth', 1.5);


x=T_all;y1=Data(1,:);
c=[237,173,197]/255;
semilogx(x(markerIndices), y1(markerIndices), '+', 'MarkerSize', 8,'Color',c, 'LineWidth', 1.5);
x=T_all;y2=Data(2,:);
c=[206,170,208]/255;
semilogx(x(markerIndices), y2(markerIndices), 'o', 'MarkerSize', 8,'Color',c, 'LineWidth', 1.5);
x=T_all;y3=Data(3,:);
c=[149,132,193]/255;
semilogx(x(markerIndices), y3(markerIndices), 's', 'MarkerSize', 8,'Color',c, 'LineWidth', 1.5);
x=T_all;y4=Data(4,:);
c=[108,190,195]/255;
semilogx(x(markerIndices), y4(markerIndices), 'd', 'MarkerSize', 8,'Color',c, 'LineWidth', 1.5);


ylim([-1,1])

xlabel('$t$','interpreter','latex','fontsize',18)
ylabel('$\mathcal{I}(t)$','interpreter','latex','fontsize',18)
set(gca,'fontsize',18)
legend([a1,a2,a3,a4],'$\lambda=0.1$','$\lambda=1$','$\lambda=5$','$\lambda=10$','interpreter','latex','location','southeast')


