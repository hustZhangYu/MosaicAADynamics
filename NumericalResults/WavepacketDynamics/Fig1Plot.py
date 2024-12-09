# We plot figure 1
from matplotlib import pyplot as plt
import numpy as np
import scipy.io

# 加载数据
data1 = scipy.io.loadmat('psialleff.mat')
variable_name1 = 'psiall'
matrix_data1 = data1[variable_name1]

data2 = scipy.io.loadmat('psiallrea.mat')
variable_name2 = 'psiallb'
matrix_data2 = data2[variable_name2]

# 获取列数（每一列数据画在一个子图里）
num_columns = matrix_data1.shape[1]

# 使用 gridspec 来调整子图高度
fig = plt.figure(figsize=(10, 6))
gs = fig.add_gridspec(num_columns, 1, height_ratios=[1]*num_columns)  # 你可以根据需要调整比例

# 创建子图
axes = [fig.add_subplot(gs[i]) for i in range(num_columns)]

# 绘制每一列的数据，并设置 y 坐标为对数尺度，限制 y 坐标范围
for i in range(num_columns):
    # 提取当前列的奇数和偶数索引数据
    x1 = range(len(matrix_data1[:, i]))
    y1 = matrix_data1[:, i]
    
    x2 = range(len(matrix_data2[:, i]))
    y2 = matrix_data2[:, i]
    
    # 奇数索引的数据
    odd_x1 = [x1[j] for j in range(len(x1)) if x1[j] % 2 != 0]
    odd_y1 = [y1[j] for j in range(len(y1)) if x1[j] % 2 != 0]
    
    even_x1 = [x1[j] for j in range(len(x1)) if x1[j] % 2 == 0]
    even_y1 = [y1[j] for j in range(len(y1)) if x1[j] % 2 == 0]
    
    # 第二个数据集的奇数和偶数索引数据
    odd_x2 = [x2[j] for j in range(len(x2)) if x2[j] % 2 != 0]
    odd_y2 = [y2[j] for j in range(len(y2)) if x2[j] % 2 != 0]
    
    even_x2 = [x2[j] for j in range(len(x2)) if x2[j] % 2 == 0]
    even_y2 = [y2[j] for j in range(len(y2)) if x2[j] % 2 == 0]
    
    # 绘制第一个数据集（数据集1）的线条
    axes[i].plot(odd_x1, odd_y1, color='r', label='Odd Index (Dataset 1)', linestyle='-', marker='')  # 红色实线，奇数索引
    axes[i].plot(even_x1, even_y1, color='b', label='Even Index (Dataset 1)', linestyle='-', marker='')  # 蓝色实线，偶数索引
    
    # 绘制第二个数据集（数据集2）的空心标记
    axes[i].scatter(odd_x2, odd_y2, edgecolors='g', facecolors='none', label='Odd Index (Dataset 2)', marker='^')  # 绿色空心三角形
    axes[i].scatter(even_x2, even_y2, edgecolors='y', facecolors='none', label='Even Index (Dataset 2)', marker='d')  # 黄色空心菱形
    
    # 设置 y 坐标为对数尺度
    axes[i].set_yscale('log')
    
    # 设置 y 坐标的显示范围
    axes[i].set_ylim(1e-10, 1)

    # 设置 x 坐标的范围
    axes[i].set_xlim(0, 987)  # 限定 x 轴的范围
    
    # 只在第一个子图显示图例
    if i == 0:
        axes[i].legend()

    # 只在最下面一个子图显示 x 轴标签，其他隐藏
    if i != num_columns - 1:
        axes[i].set_xticklabels([])

    # 设置标题和 y 轴标签
    axes[i].set_ylabel('Value')

# 设置最下面的子图 x 轴标签
axes[-1].set_xlabel('Index')

# 调整子图之间的垂直距离（hspace）和水平距离（wspace）
plt.subplots_adjust(hspace=0.01, wspace=0.2)  # 你可以根据需要调整这些值

# 自动调整布局，使子图不重叠
# plt.tight_layout()

# 显示图像
plt.show()