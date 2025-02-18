# Ubuntu安装指定Python版本详解

### 下载Python

下载链接：[Python官网](https://www.python.org/ftp/python/) [华为镜像](https://mirrors.huaweicloud.com/python/)

选择需要的版本（以3.8.5为例）：

```bash
cd ~
sudo wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
```

### 安装Python（方法一：默认安装路径）

1. 解压安装包到当前目录下并且进入：

    ```bash
    sudo tar -zxvf Python-3.8.5.tgz -C ~
    cd Python-3.8.5
    ```
2. 初始化：

    ```bash
    sudo ./configure
    ```
3. 编译测试安装：

    ```bash
    sudo make
    sudo make test
    sudo make install
    ```

### 安装Python（方法二：自定义安装路径）

1. 解压安装包到当前目录下并且进入：

    ```bash
    sudo tar -zxvf Python-3.8.5.tgz -C ~
    cd Python-3.8.5
    ```
2. 初始化（指定安装路径）：

    ```bash
    ./configure --prefix=/usr/local/python3.8.5
    ```
3. 编译测试安装：

    ```bash
    sudo make
    sudo make test
    sudo make install
    ```
4. 添加环境变量：

    ```bash
    PATH=$PATH:$HOME/bin:/usr/local/python3.8.5/bin
    ```

使用`ls`​命令来查看系统中都有哪些Python可用：

```bash
ls /usr/bin/python*
```

执行如下命令查看默认的Python版本信息：

```bash
python --version
```

## 使用update-alternatives修改Python版本

### 列出所有可用的Python替代版本信息

以root身份登录，首先罗列出所有可用的python替代版本信息：

```bash
sudo update-alternatives --list python
```

### 安装Python替代版本

使用`--install`​选项创建符号链接，并指定优先级：

```bash
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 2
```

最后一个参数指定了此选项的优先级，如果没有手动设置替代选项，那么具有最高优先级的选项就会被选中。

### 查看当前Python版本

```bash
python --version
```

### 列出可用的Python替代版本

```bash
sudo update-alternatives --list python
```

### 在Python替代版本中切换

使用下方的命令随时在列出的Python替代版本中任意切换：

```bash
sudo update-alternatives --config python
```

### 查看切换后的Python版本

```bash
python --version
```

## 移除替代版本

一旦系统中不再存在某个Python的替代版本时，可以将其从`update-alternatives`​列表中删除掉。例如，移除列表中的`python2.7`​版本：

```bash
sudo update-alternatives --remove python /usr/bin/python2.7
```

## 用法

使用 `update-alternatives`​ 来管理多个CUDA版本的切换。

```bash
sudo update-alternatives --install /usr/local/cuda cuda /usr/local/cuda-12.2/ 122
```

## 配置环境变量

编辑 `.bashrc`​ 文件添加CUDA路径：

```bash
vim ~/.bashrc
```

添加以下两行：

```bash
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

```bash
source ~/.bashrc
```

## 配置 `update-alternatives`​

配置 `update-alternatives`​ 来管理CUDA版本：

```bash
sudo update-alternatives --config cuda
```

‍
