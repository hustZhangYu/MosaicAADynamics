from matplotlib import pyplot as plt
import numpy as np
import scipy.io

# 启用 LaTeX 字体
# plt.rc('text', usetex=True)
# plt.rc('font', **{'family': 'serif', 'serif': ['Times New Roman']})

# 加载数据
data1 = scipy.io.loadmat('psialleff.mat')
variable_name1 = 'psiall'
matrix_data1 = data1[variable_name1]

data2 = scipy.io.loadmat('psiallrea.mat')
variable_name2 = 'psiallb'
matrix_data2 = data2[variable_name2]

data3 = scipy.io.loadmat('psiallrea_2.mat')
variable_name3 = 'psiall'
matrix_data3 = data3[variable_name3]

data4 = scipy.io.loadmat('psiallrea_1.mat')
variable_name4 = 'psiall'
matrix_data4 = data4[variable_name4]

# 获取列数（每一列数据画在一个子图里）
num_columns = matrix_data1.shape[1]

# 使用 gridspec 来调整子图布局
fig = plt.figure(figsize=(16, 12))
gs = fig.add_gridspec(num_columns, 3, width_ratios=[1, 1, 1])  # 将数据1和数据2合并为一个图，宽度为2

# 创建子图
axes_left = [fig.add_subplot(gs[i, 0]) for i in range(num_columns)]  # data4 的子图
axes_middle = [fig.add_subplot(gs[i, 1]) for i in range(num_columns)]  # data3 的子图
axes_right = [fig.add_subplot(gs[i, 2]) for i in range(num_columns)]  # data1 和 data2 的合并图

# 绘图函数：提取奇偶索引数据
def get_odd_even_data(x, y):
    odd_x = [x[j] for j in range(len(x)) if x[j] % 2 != 0]
    odd_y = [y[j] for j in range(len(y)) if x[j] % 2 != 0]
    even_x = [x[j] for j in range(len(x)) if x[j] % 2 == 0]
    even_y = [y[j] for j in range(len(y)) if x[j] % 2 == 0]
    return odd_x, odd_y, even_x, even_y

# 绘制每一列的数据
for i in range(num_columns):
    # 提取当前列的数据
    x1, y1 = range(len(matrix_data1[:, i])), matrix_data1[:, i]
    x2, y2 = range(len(matrix_data2[:, i])), matrix_data2[:, i]
    x3, y3 = range(len(matrix_data3[:, i])), matrix_data3[:, i]
    x4, y4 = range(len(matrix_data4[:, i])), matrix_data4[:, i]
    
    odd_x1, odd_y1, even_x1, even_y1 = get_odd_even_data(x1, y1)
    odd_x2, odd_y2, even_x2, even_y2 = get_odd_even_data(x2, y2)
    odd_x3, odd_y3, even_x3, even_y3 = get_odd_even_data(x3, y3)
    odd_x4, odd_y4, even_x4, even_y4 = get_odd_even_data(x4, y4)

    # 绘制 data4 在最左边的图（axes_left）
    axes_left[i].scatter(odd_x4, odd_y4, edgecolors='r', facecolors='none', label='$Even$ ', marker='o', s=15)
    axes_left[i].scatter(even_x4, even_y4, edgecolors='b', facecolors='none', label='$Odd$ ', marker='d', s=15)
    if i == 0:
        axes_left[i].plot(y4, linestyle='--', color='k')

    # 绘制 data3 在中间的图（axes_middle）
    axes_middle[i].scatter(odd_x3, odd_y3, edgecolors='r', facecolors='none', label='$Even $', marker='o', s=15)
    axes_middle[i].scatter(even_x3, even_y3, edgecolors='b', facecolors='none', label='$Odd$ ', marker='d', s=15)
    if i == 0:
        axes_middle[i].plot(y3, linestyle='--', color='k')

    # 绘制 data1 和 data2 合并在右侧的图（axes_right）
    axes_right[i].scatter(odd_x1, odd_y1, edgecolors='r', facecolors='none', label='$Even$ ', marker='o', s=15)
    axes_right[i].scatter(even_x1, even_y1, edgecolors='b', facecolors='none', label='$Odd$ ', marker='d', s=15)
    axes_right[i].plot(odd_x2, odd_y2, color='k', label='$H_{eff}(Even)$', linestyle='-', linewidth=1.5)
    axes_right[i].plot(even_x2, even_y2, color='orange', label='$H_{eff}(Odd)$ ', linestyle='--', linewidth=1.5)

    # 设置 y 坐标为对数尺度
    axes_left[i].set_yscale('log')
    axes_middle[i].set_yscale('log')
    axes_right[i].set_yscale('log')

    # 设置 y 坐标的显示范围
    axes_left[i].set_ylim(1e-10, 1)
    axes_middle[i].set_ylim(1e-10, 1)
    axes_right[i].set_ylim(1e-10, 1)

    # 设置 x 坐标的范围
    axes_left[i].set_xlim(0, 987)  # 限定 x 轴的范围
    axes_middle[i].set_xlim(0, 987)
    axes_right[i].set_xlim(0, 987)

    # 只在第一个子图显示图例
    if i == 0:
        # axes_left[i].legend()
        # axes_middle[i].legend()
        # axes_right[i].legend()
        axes_left[i].legend(fontsize=16)
        axes_middle[i].legend(fontsize=16)
        axes_right[i].legend(fontsize=16)

    # 只在最下面一个子图显示 x 轴标签，其他隐藏
    if i != num_columns - 1:
        axes_left[i].set_xticklabels([])  # 隐藏其他子图的 x 轴标签
        axes_middle[i].set_xticklabels([])
        axes_right[i].set_xticklabels([])

    # 设置标题和 y 轴标签，仅为新数据集显示 y 轴标签
    axes_left[i].set_ylabel('$N_j(t)$', fontsize=24)  # 新数据集（matrix_data3）的 y 轴标签
    axes_middle[i].get_yaxis().set_visible(False)  # 新数据集（matrix_data3）的 y 轴标签
    axes_right[i].get_yaxis().set_visible(False)

    # 调整坐标轴刻度字体大小
    axes_left[i].tick_params(axis='both', labelsize=30)  # 设置字体大小
    axes_middle[i].tick_params(axis='both', labelsize=30)
    axes_right[i].tick_params(axis='both', labelsize=30)



# 设置最下面的子图 x 轴标签
axes_left[-1].set_xlabel('$j$', fontsize=30)
axes_middle[-1].set_xlabel('$j$', fontsize=30)
axes_right[-1].set_xlabel('$j$', fontsize=30)

# 调整子图之间的垂直距离（hspace）和水平距离（wspace）
plt.subplots_adjust(hspace=0, wspace=0)  # 你可以根据需要调整这些值

# 自动调整布局，使子图不重叠
# plt.tight_layout()

plt.savefig('plot.png', dpi=300)
# 显示图像
plt.show()
