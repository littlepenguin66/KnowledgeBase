目前，Python 同时更新与维护 Python2 和 Python3。选择 Python2 还是 Python3，取决于当前要使用的库或框架支持哪个版本，因此经常会遇到需要切换版本的情况。那么，应该如何有效地更改呢？许多小伙伴可能会想到通过修改环境变量来指定 Python 的默认路径，这样做当然可以，但不够优雅。那么，什么方法才算优雅呢？当然是使用一条命令了👻。这里通过 Homebrew 安装 pyenv，再用 pyenv 来安装和管理 Python。

## 安装步骤

### 安装 Homebrew

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew -v
Homebrew 1.6.9
Homebrew/homebrew-core (git revision 5707e; last commit 2018-07-09)
```

### 安装 Pyenv

```bash
$ brew update
$ brew install pyenv
 negeru $ pyenv -v
pyenv 1.2.5
```

### 安装管理多个 Python 版本

```bash
 negeru $ pyenv install 2.7.15
 negeru $ pyenv install 3.7.0
 negeru $ pyenv versions
system
2.7.15
* 3.7.0 (set by /Users/john/.pyenv/version)
```

### 切换版本

```bash
 negeru $ pyenv global 2.7.15
 negeru $ pyenv versions
system
* 2.7.15 (set by /Users/john/.pyenv/version)
3.7.0
 negeru $ python --version
Python 2.7.15
```

## Pyenv 常用的命令说明

使用方式: `pyenv <命令> [<参数>]`​

### 命令

* ​`commands`​: 查看所有命令
* ​`local`​: 设置或显示本地的 Python 版本
* ​`global`​: 设置或显示全局的 Python 版本
* ​`shell`​: 设置或显示 shell 指定的 Python 版本
* ​`install`​: 安装指定的 Python 版本
* ​`uninstall`​: 卸载指定的 Python 版本
* ​`version`​: 显示当前的 Python 版本及其本地路径
* ​`versions`​: 查看所有已安装的版本
* ​`which`​: 显示安装路径

注：使用 `local`​、`global`​、`shell`​ 设置 Python 版本时需要跟上参数（版本号），而在查看设置的版本时则不需要。
