import numpy as np
import matplotlib.pyplot as plt
from scipy.linalg import eigh

# plt.rcParams.update({
#    "text.usetex": True,          # 启用 LaTeX 渲染
#    "font.family": "serif",       # 设置字体为 serif（常见的数学字体）
#    "font.serif": ["Times New Roman"]  # 选择具体的 serif 字体
# })


# 计算态密度（Density of States）
def getDos(E, Ev):
    Ddata2 = E
    domega = 2 / 200
    omega_all = np.arange(-1, 1 + domega, domega)
    fw = np.zeros(len(omega_all))
    Delta = np.zeros(len(omega_all))

    epslion = 0.01
    for i, omega in enumerate(omega_all):
        Delta[i] = np.sum(1 / ((Ddata2 - omega) * np.conj(Ddata2 - omega) + epslion**2))
        Delta[i] = epslion * Delta[i] / np.pi

    return Delta


# 计算Inverted Participation Ratio (IPR)
def Ipr(psi):
    # IPR计算公式：sum_i |psi_i|^4
    a = np.abs(psi) ** 2
    return np.sum(a ** 2)



# 设置参数
L = 987  # 可取斐波那契
lambda_all = np.arange(0.1, 10.1, 0.1)  # lambda范围

Data = np.zeros(len(lambda_all))

for mm, lambda_val in enumerate(lambda_all):
    b = (np.sqrt(5) - 1) / 2  # 黄金比
    kapa = 2

    # mosaic Hamiltonian
    hop = np.ones(L - 1)
    H0 = np.diag(hop, 1) + np.diag(hop, -1)
    phase = 2 * np.pi * np.random.rand()
    mu = np.zeros(L)

    mu1 = []
    for j in range(L):
        if j % kapa == 0:
            mu[j] = 0
        else:
            mu[j] = 2 * np.cos(2 * np.pi * b * j + phase)
            mu1.append(mu[j])

    H = lambda_val * np.diag(mu) + H0
    # 计算特征值和特征向量
    E, Ev = eigh(H)

    # 使用逻辑索引找到在 -1/lambda 和 1/lambda 之间的元素
    selected_elements = E[(E >= -1 / lambda_val) & (E <= 1 / lambda_val)]

    # 统计在 -1/lambda 和 1/lambda 之间的元素数量
    Data[mm] = len(selected_elements)

# 绘制结果
plt.figure(figsize=(8, 6))
plt.plot(lambda_all, Data / L, '-o', linewidth=2)
plt.ylim([0, 1.1])
plt.xlim([0, np.max(lambda_all)])
plt.xlabel(r'$\lambda$', fontsize=30)
plt.ylabel(r'$\frac{N_e}{L}$', fontsize=30)
plt.tick_params(axis='both', labelsize=30)
plt.grid(True)
plt.tight_layout()

plt.savefig('N.png', dpi=300, bbox_inches='tight')  # 保存为 PNG 格式，dpi 300 高质量，裁剪边界
plt.show()

# 保存数据
np.save('ENlambda.npy', lambda_all)
np.save('ENdata.npy', Data / L)

