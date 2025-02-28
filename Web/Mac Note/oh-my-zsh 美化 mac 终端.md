# oh-my-zsh 美化 mac 终端 | Jack Chou's blog

## 目录

* 安装 homebrew
* 设置 terminal 配色
* 安装 oh-my-zsh
* 关于 item2
* 总结
* 参考

## 安装 homebrew

mac 采用的 ARM 架构的 M1 芯片，也记录一下安装过程，homebrew 3 之前不兼容 M1。

安装：

```bash
/bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/ineo6/homebrew-install/install.sh)"
```

配置环境变量，查看使用的 shell 类型：

上面的命令可能有两种结果：

1. ​`/bin/zsh`​

    说明使用的是 zsh，在 `.zprofile`​ 中设置环境变量，没该文件就在 home 目录新建一个。

    执行：

    ```bash
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ```
2. ​`/bin/bash`​

    使用的 bash ，在 `.bash_profile`​ 中加入环境变量：

    ```bash
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ```

> 从 macOS Catalina(10.15.x) 版开始，Mac 使用 zsh 作为默认 Shell。

> 不是 zsh 的话，执行命令修改为 zsh:

```bash
chsh -s /bin/zsh # 切换到 zsh
```

zsh 似乎更强大？和是 oh-my-zsh 的基础？ zsh 和 bash 有什么区别？ terminal.app 用户偏好里，通用的 shell 打开方式是什么意思？

这些不太清楚，先切换到 zsh。

## 设置 terminal 配色

terminal 自身具备一些主题了，但是少，也不够美观。

可以从 macos-terminal-themes 安装你想要的。

不想折腾，可先保持默认，等配置完 oh-my-zsh 再来选择内置的配色得了。

## 安装 oh-my-zsh

想要终端体验好，全靠它。

1. 安装:

```bash
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

出现这个就表示成功了：

```
       __                                     __
  ____  / /_     ____ ___  __  __   ____  _____/ /_
 / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \
/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /
\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/
                        /____/                       ....is now installed!
```

会在用户目录出现一个 `.zshrc`​ 文件 和 `.oh-my-zsh`​ 的文件夹， `.zshrc`​ 是配置 `环境变量`​、 `配置oh-my-zsh`​、 `命令别名`​ 的地方。

2. 配置主题

想要好看，还需配置一个你中意的主题，在 `.zshrc`​ 中：

```bash
ZSH_THEME="steeef" # 等号后面就是oh-my-zsh 主题
```

这是内置主题，效果可点击 `ZSH_THEME`​ 上方的 github 仓库查看。

内置主题都在 `.oh-my-zsh`​ 这个仓库中，也可配置第三方主题，在此 查看

保存 `.zshrc`​，在终端执行 `source ~/.zshrc`​ 更新配置，退出终端，再打开就有效果了。

4. 配置 oh-my-zsh 插件

插件是其强大的地方，是提高使用体验的关键， `.zshrc`​ 中

```bash
plugins=(git) # 就是配置插件的地方
```

可使用内置的，也可安装第三方的，激活插件将其加入 plugins 即可。

先配置这些：

```bash
plugins=(
  git
  extract
  autojump
  zsh-autosuggestions
  zsh-syntax-highlighting
  )
```

> git

内置插件，可缩写 git 命令， `gst`​ → `git status`​。

​`alias | grep git`​ 查看

似乎和自己写的命令别名一样，暂时看不到优势。

> extact

内置插件，还不知道如何使用。

> autojump

第三方插件，记住你 `访问过`​ 的目录，然后使用 `j`​ 快速进入一个目录，比如：

```bash
jackchou at jackdeMacBook-Pro-2 in ~
$ j vue-demos
/Users/jackchou/vue/vue-demos
```

安装

```bash
brew install autojump
```

拼错路径也能跳转。

要是报错，提示找不到，就删除 homebrew 重新安装。

> 查看安装位置 ： `which brew`​

```bash
sudo rm -rf /opt/homebrew  # M1 芯片在这里
sudo rm -rf /usr/local/Homebrew/ # 其他可能在这里
```

重新安装。

> zsh-syntax-highlighting

命令高亮的插件。

安装：

```bash
brew install zsh-syntax-highlighting
```

加入 plugin ，可能还需要在 `.zshrc`​ 中加入：

```bash
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
```

可能遇到这个错误： `Warning: plugin zsh-autosuggestions not found`​ `Warning: plugin zsh-syntax-highlighting not found`​

执行这个操作：

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

### 关于 item2

很多教程都是 `item2`​ 代替默认终端，目前只发现 `item2`​ 更好定制配色、有更多的快捷键，配置了 `oh-my-zsh`​ 之后，似乎没发现有更大的优势。

> item2 美化后

​![img](https://tva1.sinaimg.cn/large/008eGmZEgy1gpogn5vb5cj315w0u0n1q.jpg)​

> terminal 美化后

​![img](https://tva1.sinaimg.cn/large/008eGmZEgy1gpogs1fzlij31500nu40i.jpg)​

## 总结

1. 每次更新 `.zshrc`​、 `.zprofile`​ 等 shell 配置文件，都执行 `source ~/.xxx`​ 更新配置。
2. 使用系统自带的终端 + `oh-my-zsh`​ 足够了，item2 的优势慢慢发现。
3. zsh、bash、等各种 shell 不同知道区别，终端如何加载 `.zshrc`​ 的不太明白，为何执行 `source ~/.xxx`​？
4. 之前各种看教程，跟着一顿猛才操作，都没有生效啊，最后参考了下面篇文章，才弄好，本来可简化的，一顿不是关键的猛操作，害死人。

去掉很多注释后， `.zshrc`​ 长这样：

```bash
# oh-my-zsh 安装路径
export ZSH="/Users/jackchou/.oh-my-zsh"
# 主题
ZSH_THEME="steeef"
# 插件
plugins=(
  git
  extract
  autojump
  zsh-autosuggestions
  zsh-syntax-highlighting
  )
# 激活 zsh-syntax-highlighting
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH/oh-my-zsh.sh
# 默认编辑器
export EDITOR='vim'
# 设置命令别名
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
```

> 我在 `.zshrc`​ 里设置 git 命令别名，提示 `bad assignment`​，不知道为何。

### 参考

程序员的 Mac 终端(oh-my-zsh)终极美化及必备插件推荐

The Ultimate Guide to Your Terminal Makeover 2021
