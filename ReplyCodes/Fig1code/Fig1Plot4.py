import matplotlib.pyplot as plt
from matplotlib import image as mpimg
import matplotlib.gridspec as gridspec

# 假设你有多个 PNG 文件
eps_files = ['EVIpr_plot.png', 'N.png', 'plot.png']

# 创建图形
fig = plt.figure(figsize=(12, 8))  # 设置图形的整体尺寸

# 使用 GridSpec 来调整子图尺寸
gs = gridspec.GridSpec(2, 2, width_ratios=[1, 2.5], height_ratios=[1, 0.9])  # 第二列宽度是第一列的三倍

# 在每个子图上加载并显示对应的 PNG 文件
# 第一个图像（左上）
ax1 = plt.subplot(gs[0, 0])
img1 = mpimg.imread(eps_files[0])
ax1.imshow(img1)
ax1.axis('off')
# ax1.set_title(f'{eps_files[0]}', fontsize=12)

# 第二个图像（左下）
ax2 = plt.subplot(gs[1, 0])
img2 = mpimg.imread(eps_files[1])
ax2.imshow(img2)
ax2.axis('off')
# ax2.set_title(f'{eps_files[1]}', fontsize=12)

# 第三个图像（右边，跨越上下两行）
ax3 = plt.subplot(gs[0:2, 1])  # 让第三个图像跨越第一和第二行
img3 = mpimg.imread(eps_files[2])
ax3.imshow(img3)
ax3.axis('off')
# ax3.set_title(f'{eps_files[2]}', fontsize=12)

# 设置整个图形的标题
# plt.suptitle('组合的PNG文件', fontsize=16)

# 调整子图之间的间距
plt.subplots_adjust(left=0.1,  right=0.9, top=0.85, bottom=0.15, hspace=0.01, wspace=0.01)

# 保存拼接后的图像为一个新的 PNG 文件
plt.savefig('merged_output.png', format='png')

# 显示合成后的图像
plt.show()
