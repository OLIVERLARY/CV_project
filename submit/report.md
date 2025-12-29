<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div align=center>
    <font size=20 face=黑体>
计算机视觉导论<br/><br/> Project:基于2DGS的三维重建
    </font>
    <font size=5 face=楷体>
<br/><br/>
杨亿酬 3230105697<br/>
韩泰睿 3230104705
2025-11-27 ~ 2025-12-21
    </font>
</div>

<div STYLE="page-break-after: always;"></div>

### 1.问题分析  
3DGS在物体表面重建的问题上会面临多视角不一致的问题，2DGS的提出解决了这个问题，本项目尝试对自行采集的数据进行处理重建出三维结构（点云和相机位姿）并进一步通过2DGS恢复出精细的物体结构，进行自由视点渲染。  
针对弱纹理的物体，尝试通过基于2DGS的改进得到良好的表面。  

### 2.基础实现
自行采集玩偶熊的视频，通过SAM(Segment Anything Model)进行物体提取，通过2DGS的pipeline完成训练与渲染，得到多视角渲染的三维结构。  

### 3.进阶探索
对比DTU数据集在2DGS,PGSR,Sparse2DGS上的效果，发现PGSR对物体弱纹理区域能够获得精细地重建效果。  
PGSR基于平面约束，无偏深度估计与多视角正则既解决了3DGS多视角不一致的问题又在引入了深度估计与平面约束解决了2DGS高斯圆片飘浮与缺少深度信息导致弱纹理区域几何信息获取困难的问题。  
通过PGSR与（可能的）SAGA(Segment Any 3D Gaussians)实现弱纹理马克杯的精细重建并获得良好的表面。  

<div STYLE="page-break-after: always;"></div>

### 4.实验结果
#### 基础实现

#### 进阶探索
##### DTU

##### mug

<div STYLE="page-break-after: always;"></div>

### 5.小组分工
杨亿酬：论文调研，思路提出，部分数据采集与训练，汇报展示  
韩泰瑞：数据采集，数据处理，训练与结果对比，效果呈现  