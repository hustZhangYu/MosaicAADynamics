import numpy as np
import matplotlib.pyplot as plt


# 自定义函数：EVIprPlot
def EVIprPlot(V_all, DataEAll, DataAll):

    L = DataEAll.shape[1]
    DataX = np.ones((len(V_all), L))
    for i in range(len(V_all)):
        DataX[i, :] = np.ones(L) * V_all[i]

    plt.figure(figsize=(10, 6))
    for i in range(len(V_all)):
        scatter = plt.scatter(DataX[i, :], DataEAll[i, :], c=DataAll[i, :], cmap='viridis', s=1)
    # 添加colorbar并设置其字体大小
    cbar = plt.colorbar(scatter)
    cbar.ax.tick_params(labelsize=30)  # 设置colorbar刻度字体大小
    cbar.set_label('Colorbar Label', fontsize=30)  # 设置colorbar标签字体大小
    cbar.set_label('') 

# 自定义函数：Ipr
def Ipr(psi):

    a = np.abs(psi) ** 2
    a2 = np.sum(a ** 2)
    return a2


# 设置参数
L = 987  # 可取斐波那契
b = (np.sqrt(5) - 1) / 2
kappa = 2  # kappa的值

# mosaic Hamiltonian
hop = np.ones(L - 1)
H0 = np.diag(hop, 1) + np.diag(hop, -1)

phase = 2 * np.pi * np.random.rand()
mu = np.zeros(L)

lambda_all = np.arange(0, 10.1, 0.1)

DataA = np.zeros((len(lambda_all), L))
DataB = np.zeros((len(lambda_all), L))

# 主循环
for m in range(len(lambda_all)):
    lambda_val = lambda_all[m]
    for j in range(L):
        if j % kappa == 0:
            mu[j] = 2 * np.cos(2 * np.pi * b * j + phase)
        else:
            mu[j] = 0
    H = lambda_val * np.diag(mu) + H0
    # 求解特征值和特征向量
    eigvals, eigvecs = np.linalg.eig(H)
    # 获取特征向量
    DataA[m, :] = eigvals
    for k in range(L):
        DataB[m, k] = Ipr(eigvecs[:, k])

# 绘制图形
EVIprPlot(lambda_all, DataA, -np.log(DataB) / np.log(L))
plt.xlabel(r'$\lambda$', fontsize=30)  # x轴标签字体大小
plt.ylabel(r'$E$', fontsize=30)  # y轴标签字体大小
plt.clim(0, 1)

# 设置 x 轴坐标轴字体大小
plt.tick_params(axis='x', labelsize=30)  # 设置x轴刻度字体大小
plt.tick_params(axis='y', labelsize=30)  # 设置y轴刻度字体大小

# 画红色虚线
plt.plot(lambda_all, 1 / lambda_all, 'r--', linewidth=2)
plt.plot(lambda_all, -1 / lambda_all, 'r--', linewidth=2)

# 设置x轴和y轴范围
plt.xlim(0, np.max(lambda_all))
plt.ylim(-5, 5)

# 设置legend
# plt.legend(['$\lambda^{-1}$', '$-\lambda^{-1}$'], fontsize=16)  # legend字体大小

plt.savefig('EVIpr_plot.png', dpi=300, bbox_inches='tight')

plt.show()

# 保存数据
np.save('Dlambda.npy', lambda_all)
np.save('DDataA.npy', DataA)
np.save('DDataB.npy', -np.log(DataB) / np.log(L))
