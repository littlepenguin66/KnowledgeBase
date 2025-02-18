# 第九章 FIR 数字滤波器的设计

### 引言

1. **数字滤波器设计概述**

    * 数字滤波器设计需根据实际问题确定技术要求，选择合适方法设计期望的数字信号处理系统，包括时域滤波和频域频谱分析，本章主要介绍FIR滤波器设计方法。
    * 着重讨论因果滤波器设计，其设计分三步：确定技术要求（如截止频率、阻带衰减等）；用因果离散时间系统逼近满足指标的滤波器；通过硬件或软件实现系统（滤波器）。
    * 技术指标在频域通过滤波器期望幅度和相位响应给出，幅度要求有绝对指标（针对幅度响应函数）和相对指标（以分贝形式），常用相对指标表示。
2. **FIR滤波器优势及设计思路**

    * FIR数字滤波器具相位响应可线性、设计相对容易（无稳定性问题）、实现高效且可用DFT提高运算效率等优势，线性相位响应有诸多优点，如设计仅实数运算、无延时失真（仅固定时延）、运算次数为$N/2$量级。
    * 设计FIR滤波器即求其系统函数$H(z)$或单位冲激响应$h(n)$，用窗函数设计法和频率采样设计法逼近线性相位FIR滤波器。

### 数字滤波器设计的基本概念

1. **设计步骤与要求**

    * 数字滤波器设计与实现分三步：技术要求（根据实际确定，如截止频率、阻带衰减等）；系统逼近（用相关概念和数学工具给出滤波器表达式）；系统实现（基于表达式用硬件或软件实现）。
2. **绝对指标**

    * 以低通滤波器为例，绝对技术要求包括通带$[0,\omega_{p}]$（通带波纹$\delta_{1}$）、阻带$[\omega_{s},\pi]$（阻带波纹$\delta_{2}$）和过渡带$[\omega_{p},\omega_{s}]$，$\omega_{p}$为通带截止频率，$\omega_{s}$为阻带截止频率（图示展示）。
3. **相对指标（dB）**

    * 低通滤波器相对指标以$R_{p}$（通带波纹，dB）和$A_{s}$（阻带衰减，dB）表示，与绝对指标参数有关系，如$R_{p}=20\lg\frac{1-\delta_{1}}{1+\delta_{1}}$，$A_{s}=20\lg\frac{\delta_{2}}{1+\delta_{1}}$，设计参数中频带波纹和通带截止频率重要。
4. **设计思路**

    * 设计低通滤波器需确定其系统函数$H(z)$等，FIR滤波器单位冲激响应有限长，设计是求$h(n)$，用窗函数设计法和频率采样设计法逼近线性相位FIR滤波器。

### 用窗函数法设计线性相位FIR滤波器原理

1. **基本原理**

    * 给定理想频率选择滤波器单位冲激响应$h_{d}(n)$（频率响应$H_{d}(e^{j\omega}) = H_{d}(\omega)e^{-j(\alpha\omega-\beta)}$），设计FIR滤波器$H(e^{j\omega})$逼近$H_{d}(e^{j\omega})$，先对$H_{d}(e^{j\omega})$傅氏反变换得$h_{d}(n)$，用有限长“窗函数”$w(n)$截取$h_{d}(n)$得$h(n)=w(n)\cdot h_{d}(n)$，窗函数形状与长度影响$h(n)$性能。
2. **以理想低通滤波器为例分析**

    * 理想低通滤波器截止频率$\omega_{c}$，群延时$\alpha$，其$h_{d}(n)$是无限长非因果偶对称序列，用矩形窗$w(n)=R_{N}(n)$截取，使$h(n)$满足线性相位特性（$h(n)=h(N - 1 - n)$），此时$\alpha=(N - 1)/2$。
    * 窗函数$w(n)$与$h_{d}(n)$时域点积，$W(e^{j\omega})$和$H_{d}(e^{j\omega})$频域卷积，$H(e^{j\omega})$逼近$H_{d}(e^{j\omega})$程度取决于$W(e^{j\omega})$。矩形窗频谱$W_{R}(e^{j\omega})$有主瓣和旁瓣，主瓣宽度影响过渡带，旁瓣幅度影响肩峰和波纹（吉布斯现象），增加截取长度$N$可减小过渡带宽，但不能改变肩峰相对值。

### 各种常见窗函数

1. **矩形窗**

    * 公式为$w(n)=\begin{cases}1, & 0\leq n\leq N - 1\\0, & 其他\end{cases}$，频谱$W_{R}(e^{j\omega}) = W_{R}(\omega)e^{-j\frac{N - 1}{2}\omega}$，$W_{R}(\omega)=\frac{\sin\frac{\omega N}{2}}{\sin\frac{\omega}{2}}$，其设计滤波器幅度函数$H(\omega)=\frac{1}{2\pi}\int_{-\pi}^{\pi}H_{d}(\theta)W_{R}(\omega-\theta)d\theta$，最小阻带衰减为$-21dB$，过渡带宽约为$1.8\pi/N$。
2. **三角形窗（Bartlett）**

    * 公式$w(n)=\begin{cases}\frac{2n}{N - 1}, & 0\leq n\leq\frac{N - 1}{2}\\2-\frac{2n}{N - 1}, & \frac{N - 1}{2}\lt n\leq N - 1\\0, & 其他n值\end{cases}$，频谱$W(e^{j\omega})=\frac{2}{N - 1}(\frac{\sin(\frac{N - 1}{4}\omega)}{\sin\frac{\omega}{2}})^{2}\cdot e^{-j\frac{N - 1}{2}\omega}\approx\frac{2}{N}(\frac{\sin\frac{\omega N}{4}}{\sin\frac{\omega}{2}})^{2}\cdot e^{-j\frac{N - 1}{2}\omega}$（$N\gg1$时），主瓣宽度为$8\pi/N$。
3. **汉宁窗（Hanning）**

    * 公式$w(n)=\begin{cases}\frac{1}{2}(1-\cos\frac{2\pi n}{N - 1}), & 0\leq n\leq N - 1\\0, & 其他n值\end{cases}$，频谱$W(e^{j\omega}) = [0.5W_{R}(\omega)+0.25[W_{R}(\omega-\frac{2\pi}{N - 1})+W_{R}(\omega+\frac{2\pi}{N - 1})]]e^{-j\frac{N - 1}{2}\omega}$，主瓣宽度为$8\pi/N$，旁瓣能量更集中，阻带最小衰减为$-44dB$。
4. **海明窗（Hamming）**

    * 公式$w(n)=\begin{cases}0.54 - 0.46\cos\frac{2\pi n}{N - 1}, & 0\leq n\leq N - 1\\0, & 其他n值\end{cases}$，频谱幅度函数$W(\omega)\approx0.54W_{R}(\omega)+0.23[W_{R}(\omega-\frac{2\pi}{N})+W_{R}(\omega+\frac{2\pi}{N})]$，主瓣宽度$8\pi/N$，$99.963\%$能量集中在主瓣，旁瓣幅度更小，应用广泛。
5. **布拉克曼窗（Blackman）**

    * 公式$w(n)=0.42 - 0.5\cos\frac{2\pi n}{N - 1}+0.08\cos\frac{4\pi n}{N - 1}$（$0\leq n\leq N - 1$），频谱幅度函数$W(\omega)=0.42W_{R}(\omega)+0.25[W_{R}(\omega-\frac{2\pi}{N - 1})+W_{R}(\omega+\frac{2\pi}{N - 1})]+0.04[W_{R}(\omega-\frac{4\pi}{N - 1})+W_{R}(\omega+\frac{4\pi}{N - 1})]$，主瓣宽度为$12\pi/N$，阻带最小衰减为$-74dB$。
6. **凯泽窗（Kaiser）**

    * 公式$w(n)=\frac{I_{0}\{\beta\sqrt{1 - [((n - \alpha)/\alpha)]^{2}}\}}{I_{0}(\beta)}$（$0\leq n\leq N - 1$），$I_{0}(\cdot)$是第一类变形零阶贝塞尔函数，$\alpha=(N - 1)/2$，$\beta$可调整主瓣宽度与旁瓣幅值，$\beta$越大，窗宽越窄，旁瓣越小，主瓣越宽，设计时可根据$\omega_{p}$、$\omega_{s}$、$R_{p}$、$A_{s}$确定$N$和$\beta$。
7. **窗函数法设计步骤**

    * 确定$H_{d}(e^{j\omega})$；求$h_{d}(n)=\mathcal{F}^{-1}[H_{d}(e^{j\omega})]$；根据过渡带宽及阻带最小衰减要求选定窗形状及$N$（通过试探确定）；计算$h(n)=h_{d}(n)w(n)$得FIR滤波器，若$H_{d}(e^{j\omega})$复杂需用FFT计算离散傅氏反变换，注意$M$取值（$M\gg N$）。窗函数法简单实用，但通带、阻带截止频率不易控制，波动非最小。

### 频率采样设计法

1. **直接设计法**

    * 对理想频率响应$H_{d}(e^{j\omega})$在$0\sim2\pi$等间隔采样得$H_{d}(k)$，作为实际滤波器频率特性采样值$H(k)$，由$H(k)$确定有限长序列$h(n)=\frac{1}{N}\sum_{k = 0}^{N - 1}H(k)e^{j\frac{2\pi nk}{N}}$（$0\leq n\leq N - 1$），且$h(n)=\sum_{r = -\infty}^{\infty}h_{d}(n + rN)$，利用内插公式$H(e^{j\omega})=\sum_{k = 0}^{N - 1}H(k)\Phi(\omega-\frac{2\pi}{N}k)$（$\Phi(\omega)=\frac{1}{N}\cdot\frac{\sin(\frac{\omega N}{2})}{\sin(\frac{\omega}{2})}\cdot e^{-j\frac{N - 1}{2}\omega}$）得FIR滤波器频率响应$H(e^{j\omega})$。在采样点上逼近误差为零，采样点间逼近误差取决于理想频率响应曲线形状，通带边缘逼近误差较大。对于线性相位FIR滤波器，采样值$H(k)$幅度和相位需满足线性相位约束条件。
2. **最优设计法**

    * 为提高逼近精度，在理想频率响应不连续点边缘加过渡采样点增加过渡带，可减小频带边缘突变和起伏振荡，提高阻带最小衰减，如低通滤波器设计中，加不同数量过渡采样点可使阻带最小衰减达到不同水平，通过实例展示了优化过程及效果。

### 习题与思考题讲解

1. **习题9 - 1**

    * 已知阶数$N - 1 = 24$，理想低通滤波器频率响应$\vert H(e^{j\omega})\vert=\begin{cases}1, & \vert\omega\vert\leq0.2\pi\\0, & 0.2\pi\lt\vert\omega\vert\leq\pi\end{cases}$。
    * 首先求$h_{d}(n)$，$h_{d}(n)=\frac{1}{2\pi}\int_{-\pi}^{\pi}H_{d}(e^{j\omega})e^{j\omega n}d\omega=\frac{1}{2\pi}\int_{-0.2\pi}^{0.2\pi}e^{j\omega n}d\omega=\frac{\sin(0.2\pi n)}{\pi n}$。
    * 然后用矩形窗截取，$h(n)=h_{d}(n)w(n)=\frac{\sin(0.2\pi n)}{\pi n}R_{25}(n)$（$R_{25}(n)$为长度25的矩形窗）。
2. **习题9 - 2**

    * 技术指标为$0.99\leq\vert H(e^{j\omega})\vert\leq1.01$（$0\leq\vert\omega\vert\leq0.3\pi$），$\vert H(e^{j\omega})\vert\leq0.01$（$0.35\pi\lt\vert\omega\vert\leq\pi$）。
    * 先根据过渡带宽和阻带最小衰减要求选择窗函数，由指标可知过渡带宽$\Delta\omega = 0.35\pi - 0.3\pi = 0.05\pi$，阻带最小衰减大于$-44dB$，可选Hanning窗。
    * 确定$N$，对于Hanning窗，过渡带宽$\Delta\omega=\frac{6.2\pi}{N}$，可得$N=\frac{6.2\pi}{\Delta\omega}=\frac{6.2\pi}{0.05\pi}=124$。
    * 求$h_{d}(n)$（过程类似习题9 - 1），再计算$h(n)=h_{d}(n)w(n)$（$w(n)$为Hanning窗）。
3. **习题9 - 3**

    * 已知阻带截止频率$\omega_{s}=0.22\pi$，通带截止频率$\omega_{p}=0.28\pi$，阻带波纹$51dB$。
    * 根据指标选择Kaiser窗，由阻带波纹$51dB$，参考表9 - 1确定$\beta$值（$\beta$在$4 - 9$之间，可通过计算或试凑确定具体值）。
    * 计算标准过渡带带宽$\Delta\omega=\omega_{p}-\omega_{s}=0.28\pi - 0.22\pi = 0.06\pi$，再由公式$N\approx\frac{A_{s}-7.95}{2.286\Delta\omega}$确定$N$值（代入$A_{s}=51dB$计算）。
    * 确定$h_{d}(n)$（根据高通滤波器理想频率响应求反变换，高通滤波器理想频率响应在通带为$e^{-j\omega\alpha}$（$\omega_{s}\leq\vert\omega\vert\leq\pi$），阻带为$0$（$0\leq\vert\omega\vert\lt\omega_{s}$），$\alpha=(N - 1)/2$），然后计算$h(n)=h_{d}(n)w(n)$（$w(n)$为Kaiser窗）。
4. **习题9 - 4**

    * 技术指标为$\vert H(e^{j\omega})\vert\leq0.01$（$0\leq\vert\omega\vert\leq0.2\pi$），$0.95\leq\vert H(e^{j\omega})\vert\leq1.05$（$0.3\pi\lt\vert\omega\vert\leq0.7\pi$），$\vert H(e^{j\omega})\vert\leq0.02$（$0.8\leq\vert\omega\vert\leq\pi$）。
    * 过渡带宽$\Delta\omega_{1}=0.3\pi - 0.2\pi = 0.1\pi$，$\Delta\omega_{2}=0.8\pi - 0.7\pi = 0.1\pi$，取$\Delta\omega = 0.1\pi$，阻带最小衰减大于$-74dB$，选择Blackman窗。
    * 由Blackman窗过渡带宽$\Delta\omega=\frac{11\pi}{N}$确定$N$（$N=\frac{11\pi}{\Delta\omega}=\frac{11\pi}{0.1\pi}=110$）。
    * 求$h_{d}(n)$（带通滤波器理想频率响应求反变换，带通滤波器理想频率响应在通带为$e^{-j\omega\alpha}$（$\omega_{c1}\leq\vert\omega\vert\leq\omega_{c2}$），阻带为$0$（$0\leq\vert\omega\vert\lt\omega_{c1}$和$\omega_{c2}\lt\vert\omega\vert\leq\pi$），先确定$\omega_{c1}$和$\omega_{c2}$，$\omega_{c1}=\frac{1}{2}(0.3\pi + 0.2\pi)=0.25\pi$，$\omega_{c2}=\frac{1}{2}(0.7\pi + 0.8\pi)=0.75\pi$，然后计算$h_{d}(n)=\frac{1}{2\pi}\int_{-\omega_{c2}}^{-\omega_{c1}}e^{j\omega n}d\omega+\frac{1}{2\pi}\int_{\omega_{c1}}^{\omega_{c2}}e^{j\omega n}d\omega$，再计算$h(n)=h_{d}(n)w(n)$（$w(n)$为Blackman窗）。
5. **思考题9 - 5**

    * **低通滤波器**：I型和II型都可以逼近低通滤波器。I型滤波器在$0\lt\omega\lt\pi$时，$H(\omega)\geq0$，适合设计低通滤波器；II型滤波器在$\omega = 0$和$\omega=\pi$处$H(\omega)=0$，也可用于低通滤波器设计，但在$\omega=\pi$附近频率响应特性不如I型好。
    * **高通滤波器**：IV型可以用来逼近高通滤波器。因为IV型滤波器在$0\lt\omega\lt\pi$时，$H(\omega)\leq0$，适合设计高通滤波器。
    * **带通滤波器**：I型和II型可用于逼近带通滤波器。I型滤波器在$0\lt\omega\lt\pi$时，$H(\omega)$有正有负，能满足带通滤波器频率响应特性；II型滤波器在$\omega = 0$和$\omega=\pi$处$H(\omega)=0$，可用于设计带通滤波器，但在$\omega=\pi$附近性能有特点（与I型比较）。
    * **带阻滤波器**：III型可用于逼近带阻滤波器。III型滤波器在$0\lt\omega\lt\pi$时，$H(\omega)$有正有负，且在$\omega = 0$和$\omega=\pi$处$H(\omega)=0$，适合设计带阻滤波器，能在通带和阻带之间实现较好的过渡。

### 知识点总结

1. **数字滤波器设计基础**

    * 设计步骤包括确定技术要求、系统逼近和系统实现。技术要求涵盖截止频率、阻带衰减等，幅度要求有绝对和相对指标，常用相对指标（如通带波纹$R_{p}$和阻带衰减$A_{s}$）。
    * 设计思路是求出滤波器系统函数$H(z)$或单位冲激响应$h(n)$，FIR滤波器在这方面有独特优势且设计多关注线性相位情况。
2. **窗函数法设计FIR滤波器**

    * 原理是用窗函数截取理想滤波器单位冲激响应$h_{d}(n)$得到$h(n)$，窗函数形状和长度影响$h(n)$性能。以矩形窗截取理想低通滤波器为例，分析了对频率特性的影响，如产生吉布斯现象（边缘展宽、肩峰和振荡、过渡带与$N$关系等）。
    * 常见窗函数有矩形窗、三角形窗、汉宁窗、海明窗、布拉克曼窗和凯泽窗等，各有特点（如主瓣宽度、旁瓣峰值幅度、阻带最小衰减、过渡带宽等），设计时根据指标选择合适窗函数并确定$N$，窗函数法简单但截止频率控制不易且波动非最优。
3. **频率采样设计法**

    * 直接设计法从频域采样理想频率响应$H_{d}(e^{j\omega})$得到$H(k)$确定$h(n)$，进而得到$H(e^{j\omega})$，采样点逼近误差为零但采样点间有误差，与理想频率响应曲线形状有关，线性相位滤波器采样值有约束条件。
    * 最优设计法通过在不连续点边缘加过渡采样点增加过渡带提高逼近精度，不同过渡采样点数量影响阻带最小衰减效果，通过实例展示了设计过程和优化效果。
