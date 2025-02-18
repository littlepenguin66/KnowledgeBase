# 使用FRP进行内网穿透

## 系列前置内容：使用FRP进行内网穿透

> 引言：
>
> 在我不算漫长的游戏生涯中，我不知为什么就成为了朋友们的开服工具。随着时间的积累，我积累了许多关于游戏的宝贵经验。我不希望这些经验白白浪费，因此决定将它们整理成文，以便那些尚未深入研究联机游戏的朋友们能够快速入门。于是，我便着手撰写了这个系列：《如何成为游戏好友们的“牛马”》。

**该系列的实操前提是你有台有公网IP的服务器，或是有一台VPS+无公网IP服务器，且该教程基于Ubuntu24.01，默认使用ssh连接服务器！！**

如果你有公网IP，这一篇就没有看的必要。

## 使用frp软件

在[frp](https://github.com/fatedier/frp)的官方中文页面中介绍到：

> frp 是一个专注于内网穿透的高性能的反向代理应用，支持 TCP、UDP、HTTP、HTTPS 等多种协议，且支持 P2P 通信。可以将内网服务以安全、便捷的方式通过具有公网 IP 节点的中转暴露到公网。

于是我们便可以知道，frp可以让我们轻松的把一台没有公网IP的服务器的某一个端口方便地使用各种协议映射到一台有公网IP的服务器上，实现内网穿透，接下来就是具体部署。

ps：本教程只提供最基础的使用方法！

### 有公网IP端配置

首先我们先去frp的github的release页面中选择适合自己系统的版本下载（不方便上github的可以使用镜像站下载）。

release页面链接：**https://github.com/fatedier/frp/releases。**

​![](https://imgheybox.max-c.com/web/bbs/2024/12/10/32342ddec4627cfd59a1969824c494ed.png)​

#### release界面

找到最新版本的release，在版本号旁边会有绿色的“Latest”，因为我使用的是x86平台的ubuntu，所以下载frp\_0.61.0\_linux\_amd64.tar.gz这个文件[frp_0.61.0_linux_amd64.tar.gz](https://github.com/fatedier/frp/releases/download/v0.61.0/frp_0.61.0_linux_amd64.tar.gz)（在蓝色文字上右键，选择复制下载链接）输入以下命令（吐槽一下小黑盒为什么不能输入代码块）：

```bash
mkdir frp

cd frp  # 建议使用前面两个命令，做好文件管理

wget https://github.com/fatedier/frp/releases/download/v0.61.0/frp\_0.61.0\_linux\_amd64.tar.gz
```

​![image](image-20241211012428-5v8h7vn.png)​

在服务端上，我们要使用的是frps和frps.toml。

我们首先编辑frps.toml。

```bash
cd frp\_0.61.0\_linux\_amd64

vim frps.toml
```

**在Vim中输入以下内容（可以先i再粘贴或者直接粘贴）**

```toml
# frps.toml

bindPort = 7000 # 服务端与客户端通信端口

auth.token = "token" # 身份验证令牌，frpc要与frps一致

# Server Dashboard，可以查看frp服务状态以及统计信息

webServer.addr = "0.0.0.0" # 后台管理地址

webServer.port = 7500 # 后台管理端口

webServer.user = "admin" # 后台登录用户名

webServer.password = "password" # 后台登录密码
```

**记得改token和password！！**

​![](https://imgheybox.max-c.com/web/bbs/2024/12/10/6785fe9853d79a4cae141c857b68a5d3.png)​

按Esc退出输入模式，然后输入:wq退出vim。（就是在键盘中直接输入: w q enter）。

接下来就要启动服务端的frp。

```bash
./frps -c frps.toml
```

​![](https://imgheybox.max-c.com/web/bbs/2024/12/10/3f68f0768af77489cda6b183bc8b51d2.png)​

#### 命令输出

服务端的配置就好了，你也可以进入0.0.0.0:7500进入web管理使用刚刚设置的webServer.user和webServer.password来登陆。

### 客户端配置

客户端在安装之前都是一样的内容，但是在配置上，客户端配置的是“frpc.toml”这个文件，我们一样使用一下命令。（进入解压后的目录后）

```bash
vim frpc.toml
```

输入以下内容

```toml
# frpc.toml

transport.tls.enable = true             # 从 v0.50.0版本开始，transport.tls.enable的默认值为 true

serverAddr = "服务端的公网IP地址"

serverPort = 7000                               # 公网服务端通信端口，frps.toml中的bindPort

auth.token = "token"                         # 令牌，与公网服务端保持一致

[[proxies]]

name = "frp" # 隧道的名字

type = "tcp" # 协议，支持 TCP、UDP、HTTP、HTTPS 等

localIP = "127.0.0.1"                   # 需要暴露的服务的IP

localPort = 114 # 将本地114端口的服务暴露在公网的514端口

remotePort = 514 # 暴露服务的公网入口
```

一样地退出vim，[[proxies]]可以有很多，可以直接在上一个末尾回车后按照这个格式再开一个。

接下来输入命令启动客户端：

```bash
./frpc -c frpc.toml
```

​![](https://imgheybox.max-c.com/web/bbs/2024/12/10/a2c57acdb15b9109df43afb416ca8b0d.png)​

#### 正确启动

最后，记得在服务端上开启端口转发，云服务商则是放行安全组。

## 使用frp软件

如果是使用诸如蒲公英等内网穿透服务商，在服务商处会有详细的介绍，在此不再赘述。

## 尾声

在此，我也贴上这篇内容的博客，方便使用电脑端操控时复制代码。

‍
