![image](https://cdn.jsdelivr.net/gh/littlepenguin66/webImage/python2exe.png)

# python打包成.exe

# 在 Python 开发中将脚本打包成可执行文件（.exe）

在 Python 开发中，将 Python 脚本打包成可执行文件（.exe）是一种常见需求。这样做可以使程序在没有安装 Python 解释器的环境下运行，同时也方便了程序的发布和分发。本文将介绍几种常见的方法来将 Python 代码打包成可执行文件。

## 一、使用 pyinstaller 打包

`pyinstaller` 是一个流行的 Python 打包工具，它能够将 Python 脚本打包成各种平台的可执行文件，包括 Windows、Linux 和 macOS。使用 `pyinstaller` 可以非常简单地将 Python 代码打包成独立的可执行文件。

### 安装 `pyinstaller`

首先，您需要安装 `pyinstaller`。可以通过以下命令进行安装：

```bash
pip install pyinstaller
```

### 使用 `pyinstaller` 打包

接下来，您可以使用 `pyinstaller` 来打包您的 Python 脚本。以下是一些常用的打包命令：

```python
# 打包单个文件
pyinstaller your_script.py
# 打包多个 py 文件
pyinstaller [主文件] -p [其他文件1] -p [其他文件2]
# 打包时去除 cmd 框
pyinstaller -F XXX.py --noconsole
# 打包加入 exe 图标
pyinstaller -F -i picturename.ico -w XXX.py
# 打包去除控制台
pyinstaller -w xxx.py
# 打包方便查看报错，可看到控制台
pyinstaller -c xxx.py
```

如果遇到错误 `AttributeError: module 'enum' has no attribute 'IntFlag'`，请检查是否安装了 `enum34` 包，并卸载它以解决问题。
执行以上命令后，`pyinstaller` 将在当前目录下生成一个 `dist` 文件夹，其中包含了打包好的可执行文件。

### 处理 `gradio` 库依赖

如果您在程序中使用了 `gradio` 库，您可能需要在打包时特别注意。如果在打包后双击程序时出现闪退，您可以在命令行中运行程序以查看具体的报错原因。
如果遇到错误 `FileNotFoundError: [Errno 2] No such file or directory`，这通常是因为 `pyinstaller` 没有正确识别 `gradio` 相关的依赖项。您可以通过以下命令来修正这个问题：

```bash
pyinstaller -F python_file_name --collect-data=gradio_client --collect-data=gradio
```

如果出现 `FileNotFoundError: [Errno 2] No such file or directory: gradio\blocks_events.pyc`，则需要修改 `spec` 文件来指定对 `gradio` 库下的代码进行编译。具体操作如下：

1. 生成 `spec` 文件：`pyi-makespec --collect-data=gradio_client --collect-data=gradio python_file_name`
2. 打开与要打包的 `py` 代码同名的 `spec` 文件，在 `A = Analysis{}` 添加对 `gradio` 的编译：`module_collection_mode={ 'gradio': 'py',}`
3. 删除目录下的 `build` 文件夹，再次执行 `pyinstaller python_file_name.spec`
   然后，您可以进入 `dist` 目录，找到生成的 `exe` 文件。

### 使用 `spec` 文件生成单个 `exe` 文件

您可以使用以下 `spec` 文件来生成单个 `exe` 文件：

```spec
# -*- mode: python ; coding: utf-8 -*-
from PyInstaller.utils.hooks import collect_data_files

datas = []
datas += collect_data_files('gradio_client')
datas += collect_data_files('gradio')


a = Analysis(
    ['08.onnxgradio.py'],
    pathex=[],
    binaries=[],
    datas=datas,
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
	module_collection_mode={ 'gradio': 'py',}
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='08.onnxgradio',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
coll = COLLECT(
    exe,
    a.binaries,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='08.onnxgradio',
)
```

## 二、cx_Freeze

`cx_Freeze` 是另一个常用的 Python 打包工具，可以将 `Python` 脚本打包成可执行文件，并且支持跨平台。使用 `cx_Freeze` 也可以将 Python 代码打包成独立的可执行文件。

安装 `cx_Freeze`

```bash
pip install cx-Freeze
```

使用 `cx_Freeze 打包`

```bash
cxfreeze your_script.py --target-dir dist
```

执行以上命令后，`cx_Freeze` 将会在指定的目录下生成可执行文件。
