# WSL2安装CUDA保姆级教程

## 概述

目前很多服务器是unix系统或者linux系统，想学习Linux系统上调用GPU进行程序加速，但是没有Linux系统设备，要弄双系统也觉得麻烦。Windows系统有一个适用于Linux的windows子系统，叫做WSL，可以在Windows下使用Linux编程。因此这篇文章就是记录自己在wsl上安装cuda并进行程序测试的过程。

安装过程中由于ubuntu系统、NVIDIA显卡驱动以及cuda版本（包括后面可能安装pytorch等一些包）的适配问题，会有非常多的坑，因此，**明确自己各个设备的版本** 十分有必要。

### 设备及软件版本

* NVIDIA GeForce GTX 750 ti显卡
* NVIDIA 显卡驱动472.212
* ubuntu22.04
* cuda11.4

## 一、确认装好WSL2并设置为默认版本，同时安装Ubuntu子系统

这个网上有很多教程，自己找个装就好了。这里贴一个：[Win11 WSL2 安装教程](#)。

**注意**，ubuntu安装过程会附带安装某个版本的gcc、g++，但是这个版本可能会与cuda版本不匹配，这个我们会讲。

## 二、安装cuda

此处参考教程：[如何使用 GTX750 或 1050 显卡安装 CUDA11+ 和 win11 WSL ubuntu安装CUDA、CUDNN、TensorRT最有效的方式](#)。

### Step 1: 查询当前驱动程序以及可安装的最高CUDA版本

要安装 CUDA 的条件是电脑有独立显卡，并且显卡是英伟达也就是 N 卡。打开“控制面板”，点击“硬件和声音”，找到“NVIDIA控制面板”并打开，点击“系统信息”。

​![系统信息](network-asset-fb40ca1d52216c61e8159d9dd8c9eea1-20241109002132-1a26qqe.png)​

“显示”里面可以看到当前驱动的版本。“组件”里面可以看到支持当前驱动的最高cuda版本。如果你想下载高版本cuda，那么就需要更新显卡驱动程序了。

或者打开命令行窗口，输入：

```bash
nvidia-smi
```

​![nvidia-smi](network-asset-78f2265e35a61014c55c8f89565a4f05-20241109002133-nrxq33i.png)​

也可以看到驱动程序版本和最高支持的cuda版本。如果 cmd 输入后找不到该命令，需要把 “C:\\Program Files\\NVIDIA Corporation\\NVSMI” (监控工具默认位置) 添加到 “path” 的环境变量中。

### Step 2: 更新NVIDIA显卡驱动程序

首先 **查看显卡的型号**，打开“任务管理器”，点击“性能”，找到GPU，这里将显示显卡的型号。

​![任务管理器](network-asset-cd36194810004209c58fb0b3fc0cc801-20241109002133-d94o7yr.png)​

然后 **下载显卡驱动**。进入英伟达驱动下载网站：[NVIDIA Driver Downloads](#)。选择对应显卡型号的驱动程序并下载一个最新的。

​![驱动下载](network-asset-5f473f9b0f6ab9266c2f133c8efc0a25-20241109002133-z8h8ght.png)​

下载完之后双击进行安装。安装之后可以把原来版本的驱动程序给卸载。

重启计算机之后，驱动程序应该更新到了下载好的版本！可以在Step1再次查看是否更新成功，并且查看当前最高支持的cuda版本。

### Step 3: 安装对应版本的cuda

打开网站[Cuda](developer.nvidia.com/cuda-toolkit-archive "Cuda")，找一个满足条件的cuda版本，比如我的驱动程序最高支持cuda11.4，于是选择cuda11.4.0.按照如图所示选择，下面会显示下载的指令。

之后，我们以管理员身份运行命令行窗口，并输入wsl切换至ubuntu系统。然后依次输入上面的下载指令。

注意，安装过程可能会出现如下问题：

* 运行安装指令时，出现apt-key过时的问题：

  ```
  W: http://mirrors.aliyun.com/kubernetes/apt/dists/kubernetes-xenial/InRelease: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
  ```

  可以直接忽略，也可以参考链接：[ubuntu 安装 cuda](#) 以去除“warning”代码提示。
* 出现libcufile11-4没有安装的问题：

  ```
  The following packages have unmet dependencies:
  libcufile-11-4 : Depends: liburcu6 but it is not installable
  E: Unable to correct problems, you have held broken packages.
  ```

  参考链接: [WSL2 Ubuntu22.04 + 3070安装cuda11.6 +Pytorch1.13.0全纪录](#) 进行解决。

安装时间可能比较长，耐心等待就好。

### Step 4: 将cuda添加至环境变量

使用 `cd ~`​ 命令切换至用户文件夹下，并用nano文本编辑器(没有这个就 `sudo install nano`​)打开 `.bashrc`​ 文件。

```bash
nano .bashrc
```

```bash
#config cuda
export CUDA_HOME=/usr/local/cuda-11.4
export PATH=$PATH:$CUDA_HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/extras/CUPTI/lib64
```

按 `ctrl+X`​ 退出， `Y`​ 保存， `enter`​ 确定。然后输入：

```bash
source ~/.bashrc
```

环境变量生效。

如果这几步没有问题，cuda程序就安装好了，使用命令：

```bash
nvcc --version
```

如果安装成功，会输出类似如下信息：

## 三、利用VSCode运行cpp测试代码

确保windows下面安装了vscode，安装教程可以网上找。

首先安装WSL插件，确保WSL-Ubuntu系统下也能调用vscode。

在命令窗口，创建cpp文件夹并用vscode打开：

```bash
mkdir myproject
cd myproject
mkdir cpp
cd cpp
code .
```

在该文件夹下创建一个 `test.cu`​ 文件，并输入下面的测试代码并保存：

```c
#include <stdio.h>

__global__ void myKernel()
{
    printf("Hello, world from the device!\n");
}

int main()
{
    myKernel<<<4,4>>>();
    cudaError_t cudaError = cudaGetLastError();
    if (cudaError != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(cudaError));
        return 1;
    } else {
        printf("No CUDA error\n");
    }
    cudaDeviceSynchronize();
}
```

该代码调用4个线程块，每个线程块有4个线程，因此将会输出16个"Hello, world from the device!".

新建一个终端，在终端输入下面指令进行编译：

```bash
nvcc test.cu -o test
```

输入下面指令进行运行：

```bash
./test
```

如果输出结果为16个"Hello, world from the device!"，那么测试成功！你已经可以成功调用GPU进行编程！

**注意**，也有可能出现如下的问题：

* 回顾开头说的，出现gcc,g++版本不匹配的问题：

  ```
  #error -- unsupported GNU version! gcc versions later than 10 are not supported! The nvcc flag '-allow-unsupported-compiler' can be used to override this version check; however, using an unsupported host compiler may cause compilation failure or incorrect run time execution. Use at your own risk.
  ```

  **解决方法：**  这说明cuda不支持ubuntu自带的gcc版本，因此我们需要重新安装gcc和g++，参考解决链接 [CUDA与我的gcc版本不兼容](#)。在命令行窗口依次执行以下命令：

  ```bash
  # 安装支持的gcc版本
  sudo apt-get install gcc-10
  sudo apt-get install g++-10

  # 更改软连接
  cd /usr/bin
  sudo rm gcc
  sudo rm g++
  sudo ln -s /usr/bin/gcc-10 gcc
  sudo ln -s /usr/bin/g++-10 g++
  ```
* cuda内核无法调用的问题：

  ```
  CUDA error: no kernel image is available for execution on the device
  ```

  **解决方法：**  在cuda调用GPU内核时，会默认指定GPU架构，不同版本cuda可能会有差异？如果默认的架构与我们的显卡架构不一致，就会出现内核无法调用的问题。按照链接 [CUDA GPUs - Compute Capability](#)，查找显卡的算力。

  比如我的GTX 750 ti算力为5.0，因此算力架构为 `compute_50 sm_50`​，编译cpp代码时指定相应GPU架构编译再运行就不会出现上面的问题了。

  ```bash
  nvcc -arch=compute_50 -code=sm_50 test.cu -o test
  ```

 如果不想每次编译时都这么复杂，那也可以为nvcc设置别名，用nano编辑 `.bashrc`​ 并在末尾加入：

```bash
  #  命名一个别名，以指定调用gpu的架构
  alias nvcc='nvcc -arch=compute_50 -code=sm_50'
```

  保存并source。这样，运行：

```bash
  nvcc test.cu -o test
```

  和运行上面指定GPU架构的编译命令就没什么区别了。
