# 查看gcc、g++版本以及对应默认的C++标准

## 简介

GCC（GNU Compiler Collection，GNU 编译器套装）是一个多种语言（C, C++, Java）的编译器集合。其中的 `g++`​ 和 `gcc`​ 命令分别对应C++和C语言的编译器。不同版本的 `g++`​ 默认的C++标准不同。本文介绍如何查看自己的 `g++`​ 编译器默认的C++版本。

## 查看 `g++`​ 默认C++版本

可以通过以下命令查看 `g++`​ 编译器默认的C++版本：

‍`bash g++ -dM -E -x c++ /dev/null | grep -F __cplusplus ‍`​

执行该命令后会打印出 `_cplusplus`​ 版本。例如，7.5.0版本的 `g++`​ 编译器默认的C++标准如下：

‍`plaintext #define __cplusplus 201402L ‍`​

## C++标准与 `_cplusplus`​ 值对照表

|C++标准|​`_cplusplus`​值|
| ---------| -----------|
|C++03|199711L<br />|
|C++11|201103L|
|C++14|201402L|
|C++17|201703L|

## 指定C++标准编译

在使用 `g++`​ 命令编译 `.cpp`​ 文件时，可以指定C++标准，例如指定C++17标准：

‍`bash g++ -std=c++17 test.cpp -o test.o ‍`​

相比于正常命令，只是多了一个命令行参数 `-std=c++17`​。

## 创建别名简化命令

如果觉得每次指定标准麻烦，可以编辑用户配置文件，为该命令创建别名：

1. 打开 `.bashrc`​ 文件：

‍`bash vim ~/.bashrc ‍`​

2. 在文件末尾添加别名：

‍`bash echo alias g17='g++ -std=c++17' >> ~/.bashrc ‍`​

3. 保存并激活配置：

‍`bash source ~/.bashrc ‍`​

之后可以使用 `g17 test.cpp -o test.o`​ 代替 `g++ -std=c++17 test.cpp -o test.o`​。
