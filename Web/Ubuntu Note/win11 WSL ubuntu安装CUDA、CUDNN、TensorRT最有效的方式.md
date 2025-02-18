# win11 WSL ubuntu安装CUDA、CUDNN、TensorRT最有效的方式

## )目录

1. 前言（准备）
2. 安装cuda、cudnn、TensorRT

    * 2.1 CUDA安装
    * 2.2 CUDNN安装
    * 2.3 TensorRT安装
    * 2.4 torch、torchvision、torchaudio安装
3. 补充

    * Nvidia-driver安装与卸载

## 一、前言（准备）

* 所有的安装在电脑上具有nvidia的gpu基础上进行。
* 且已经安装好nvidia driver。
* 通过wsl已经安装好ubuntu。
* 理论上来说，如果windows上具有nvidia driver，wsl不需要再安装。
* 通过nvidia-smi查看电脑上cuda版本。

## 二、安装cuda、cudnn、TensorRT

### 2.1 CUDA安装

确定安装的版本，比如我这里是cuda11.6（小于等于nvidia-smi的，建议直接安装等于11.6,别想太多，否则因为你安装了小于等又没有保持所有cuda版本的一致性而报错，直接安装等于nvidia-smi显示的版本）。

**注意WSL ubuntu安装cuda有它特殊的安装，跟其他非wsl ubuntu的安装不一样**

1. 选择版本安装11.6，点进对应cuda toolkit版本选择的网址：[NVIDIA Developer](https://developer.nvidia.com/cuda-toolkit-archive)。
2. 选择对应的版本进行下载，比如11.6.2（11.6.1，11.6.0都可以),点击对应的选项，**一定要选择WSL-Ubuntu**。
3. 在网页下方会弹出安装命令，依次执行：

```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda-repo-wsl-ubuntu-11-6-local_11.6.2-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-11-6-local_11.6.2-1_amd64.deb
sudo apt-key add /var/cuda-repo-wsl-ubuntu-11-6-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
```

4. 验证

* 安装成功后会在ubuntu `/usr/loacl`​ 文件下出现关于你安装的cuda版本的文件夹。
* 系统环境配置

```bash
sudo touch /etc/profile.d/cuda.sh
echo 'export PATH=/usr/local/cuda/bin/:$PATH' | sudo tee -a /etc/profile.d/cuda.sh
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:/usr/lib/wsl/lib/:$LD_LIBRARY_PATH' | sudo tee -a /etc/profile.d/cuda.sh
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda-11.6/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-11.6/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export CUDA_HOME=/usr/local/cuda-11.6
```

* 命令验证：关闭ubuntu终端重新打开输入 `nvcc -V`​，显示如下信息表示安装成功。

### 2.2 CUDNN安装

CUDNN选择对应的tar包进行安装

1. 进入到cudnn的官方下载网址：[NVIDIA Developer](https://developer.nvidia.com/cudnn)，勾选I agree。
2. 注意到勾选后，出现了v8.9.7这些版本可能很新，找不到11.6的，因此点击 Archived cuDNN Releases，出现如下界面，此时可选版本变多。
3. 根据自己的cuda版本去选择，发现出现了11.5但没出现11.6,可以推测在上面几个版本，再通过选择tar包时，显示的文件名（会弹出cuda的版本）进行最后的确认，我选择的是8.4.0。
4. 选择Local Installer for Linux86_64(Tar)。 **千万别选错了Tar包。**
5. 将下载后的tar包复制到ubuntu的一个文件夹下，本文是home/用户名下的Downloads，最后通过解压安装，然后进行配置即可。

```bash
tar -xvf cudnn-linux-x86_64-8.4.0.27_cuda11.6-archive.tar.xz
sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
sudo cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
```

6. 验证是否安装成功，输入如下命令，显示如下图即安装成功

```bash
cat /usr/local/cuda/include/cudnn_version.h | grep CUDNN_MAJOR -A 2
```

### 2.3 TensorRT安装

TensorRT选择对应的tar包进行安装

1. 进入到TensorRT官方下载网址：[NVIDIA Developer](https://developer.nvidia.com/nvidia-tensorrt-download)，点击勾选I agree。
2. 选择8.4 GA，注意到越网上对应的cuda版本越高，CUDA 11.6在8.4GA上可以找到。
3. 将下载后的tar包复制到ubuntu的一个文件夹下，本文是home/用户名下的Downloads，最后通过解压安装，然后进行配置即可。安装完成后会出现TensorRT-(版本)的文件夹，这里我们已经安装好了。

解压安装命令：

```bash
tar -xzvf TensorRT-version.Linux.{arch}-gnu.cuda.{cudnn}.tar.gz
```

4. 解压后的文件名为TensorRT-{版本名}，该文件夹下有如下文件目录。
5. 将TensorRT 下的lib绝对路径添加到系统环境中(根据自己的安装目录来)

```bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/xionglang/Downloads/TensorRT-8.4.1.5/lib
```

6. 切换到python目录下，安装tensorrt python whl文件

```bash
cd python
pip install tensorrt-8.4.1.5-cp39-none-linux_x86_64.whl
```

7. 安装其他whl包，根据自己的目录下文件名安装

```bash
# 安装uff whl
cd ../uff
pip install uff-0.6.9-py2.py3-none-any.whl
# 安装graphsurgeon whl
cd ../graphsurgeon
pip install graphsurgeon-0.4.6-py2.py3-none-any.whl
# 安装onnx_graphsurgeon whl
cd ../onnx_graphsurgeon
pip install onnx_graphsurgeon-0.3.12-py2.py3-none-any.whl
```

8. 验证安装

* 查看tensorRT安装版本

```bash
sudo find / -name NvInferVersion.h
```

* 运行tensort案例demo：切换到samples/sampleOnnxMNIST文件夹下编译，然后会在 **TensoRT-{版本}/targets/x86_64-linux-gnu/bin/**  文件夹下得到一个sample_onnx_mnist的可执行文件，运行

```bash
# 切换到TensorRT-{版本}/samples/sampleOnnxMNIST/目录下编译
cd samples/sampleOnnxMNIST/
make
# 切换到TensorRT-{版本}/targets/x86_64-linux-gnu/bin目录下运行sample_onnx_mnist
cd ../../targets/x86_64-linux-gnu/bin/
./sample_onnx_mnist
```

* python tesnorrt 验证

```bash
python
import tensorrt
print(tensorrt.__version__)
assert tensorrt.Builder(tensorrt.Logger())
```

### 2.4 torch、torchvision、torchaudio安装

最后我们在虚拟环境内安装的torch、torchvision、以及torchaudio也要保证cuda与上面3个保持一致性，去pytorch whl网站去下载对应版本的文件 [PyTorch](https://download.pytorch.org/whl/torch_stable.html)，然后进行安装

```bash
# torch安装
pip install torch-1.12.0+cu116-cp39-cp39-linux_x86_64.whl
# torchaudio安装
pip install torchaudio-0.12.0+cu116-cp39-cp39-linux_x86_64.whl
# torchvision安装
pip install torchvision-0.13.0+cu116-cp39-cp39-linux_x86_64.whl
```

## 

补充

### Nvidia-driver安装与卸载

之前没有安装过nvidia-driver则跳过卸载，若安装过重装nvidia-driver需要先卸载

* 卸载nvidia-driver

```bash
sudo apt-get remove --purge nvidia*
sudo apt remove --purge *nvidia*
```

* 下载nvidia-driver

  * 官网下载地址：[NVIDIA Driver Downloads](https://www.nvidia.cn/drivers/lookup/)
  * 根据自己的nvidia版本下载对应的run文件，如NVIDIA-Linux-x86_64-550.90.07.run
* 安装前的准备

  * **禁用nouveau：**  Nouveau是Ubuntu的默认开源NVIDIA驱动，需要禁用它以安装官方驱动

```bash
blacklist nouveau
blacklist lbm-nouveau
options nouveau modeset=0
alias nouveau off
alias lbm-nouveau off
```

* **关闭nouveau**

```bash
echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
```

* 验证是否禁用

```bash
lsmod | grep nouveau
```

无信息则说明被禁用

* 获取kernel source

```bash
sudo apt-get install linux-source
sudo apt-get install linux-headers-x.x.x-x-generic
```

x.x.x.x根据第上一行行命令可查看到所用到的版本号。

#### 安装Nvidia驱动

* 关闭图形界面

```bash
sudo service lightdm stop
```

* 安装，安装前给NVIDIA-Linux-x86_64-550.90.07.run授予权限

```bash
sudo ./NVIDIA-Linux-x86_64-550.90.07.run -no-x-check -no-nouveau-check -no-opengl-files
```

安装过程，根据提示勾选，建议：

* Would you like to register the kernel module souces with DKMS?This will allow DKMS to automatically build a new module, if you install a different kernel later? **选择 No**
* Nvidia’s 32-bit compatibility libraries? 选择 **No**
* Would you like to run the nvidia-x configutility to automatically update your x configuration so that the NVIDIA x driver will be used when you restart x? Any pre-existing x confile will be backed up. **选择 Yes**

如果出现报错信息，一定要去查看日志信息：/var/log/nvidia-installer.log，报错原因，比如出现核冲突，发现gcc该安装12，结果显示的版本是11，这样就需要重新安装gcc-12并通过设置默认gcc后成功安装

```bash
sudo apt install gcc-12
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 60 --slave /usr/bin/g++ g++ /usr/bin/g++-11
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 60 --slave /usr/bin/g++
g++ /usr/bin/g++-12
```

```bash
sudo update-alternatives --config gcc
```

选择安装后的版本如gcc-12作为默认配置。设置完成后重新执行

```bash
sudo ./NVIDIA-Linux-x86_64-550.90.07.run
```

不再出现之前的错误即成功安装。

**最后检查驱动是否安装成功：**

```bash
nvidia-smi
```
