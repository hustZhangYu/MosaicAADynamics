import numpy as np
from matplotlib import pyplot as plt

L=300

H=np.zeros([L,L])
for i in range(L-1):
    H[i,i+1]=1
    H[i+1,i]=1

psi=np.zeros([L,1])

sigma=10
c=0
for i in range(L):
    psi[i]=np.exp(-(i-L/2)**2/sigma**2)
    c=c+psi[i]*psi[i]

psi=psi/np.sqrt(c)

plt.plot(psi)
plt.show()

E, Ev=np.linalg.eig(H)

res=list()
for i in range(L):
    res.append(abs(psi.T.conj()@Ev[:,i])**2)

print(res)
        
plt.plot(E,res,'.')
plt.show()
print(H)