# Ubuntu搭建EasyN2N小黄鸭并使用

## 服务端

服务端操作系统为 **Ubuntu20**，参考使用N2N搭建虚拟局域网联机游戏（服务端）。

### 安装n2n

```shell
wget https://github.com/ntop/n2n/releases/download/3.0/n2n-3.0.0-1038.x86_64.rpm
sudo apt install alien
sudo alien -k n2n-3.0.0-1038.x86_64.rpm
sudo dpkg -i n2n_3.0.0-1038_amd64.deb
```

### 安装编译环境

```shell
sudo apt-get install autoconf make gcc -y
```

### 编译

```shell
cd /opt
sudo wget https://github.com/ntop/n2n/archive/refs/tags/3.0.tar.gz
sudo tar xzvf 3.0.tar.gz
cd n2n-3.0
sudo ./autogen.sh
sudo ./configure
sudo make && make install
```

### 启动服务端

详细的服务端参数见 [EasyN2N 服务端（Supernode）附加参数](#)。

```shell
sudo ufw allow 9527/udp
sudo supernode -p 9527 -f
```

### 关闭服务端

如果使用 `sudo supernode -p 9527`​ 后台挂起了，可以使用以下方法关闭进程：

```shell
ps -ef | grep supernode
sudo kill <PID>
```

或者使用 `screen`​ 挂起应用，执行以下指令，然后使用 `ctrl`​ + `a`​ 组合键，然后按 `d`​ 即可挂起。

使用 `sudo screen -r easyn2n`​ 又可重新访问。

```shell
sudo screen -S easyn2n supernode -p 9527 -f -v
```

## 客户端

### Windows

参考 [使用N2N搭建虚拟局域网联机游戏（EasyN2N\小黄鸭）](#)。

客户端下载地址，此教程下载的版本为当前最新版 `3.12`​。

请以管理员权限运行n2n.exe（**小黄鸭图标右键 —— 以管理员身份运行**）。

在主页面输入 `ip:端口`​，例如： `150.128.49.178:9527`​，然后点击 `启动`​ 等待自动获取IP，可自行设置小组名称。

### Android

参考 [手机端使用N2N虚拟局域网的方法（安卓）](#)。

到 [hin2n release link](#) 下载最新版本。

## 参考文档

* [使用N2N搭建虚拟局域网联机游戏（EasyN2N\小黄鸭）](#)
* [使用N2N搭建虚拟局域网联机游戏（服务端）](#)
* [EasyN2N 服务端（Supernode）附加参数](#)
* [EasyN2N（N2N启动器） v3.1.2](#)
* [EasyN2N 常见问题解决方法](#)
* [手机端使用N2N虚拟局域网的方法（安卓）](#)
* [hin2n仓库](#)
