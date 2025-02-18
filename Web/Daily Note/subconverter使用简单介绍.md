# subconverter使用简单介绍

> 官方文档
>
> [subconverter官方中文文档](subconverter官方中文文档.md)

‍

## 原始 SS 链接

ss://YWVzLTEyOC1nY206dGVzdA==@192.168.100.1:8888#Example1

## 步骤 1: URLEncode 转换

首先，将原始 SS 链接通过 URLEncode 转换：

ss%3A%2F%2FYWVzLTEyOC1nY206dGVzdA%3D%3D%40192%2E168%2E100%2E1%3A8888%23Example1

## 步骤 2: 构造 Clash 订阅调用地址

将转换后的 URL（%URL%）和目标（%TARGET%，即 Clash）填入以下地址：

http://127.0.0.1:25500/sub?target=clash&url=ss%3A%2F%2FYWVzLTEyOC1nY206dGVzdA%3D%3D%40192%2E168%2E100%2E1%3A8888%23Example1

## 步骤 3: 完成订阅

将上述链接填写至 Clash 的订阅处，完成转换。

## 工具推荐

* [URL Encode and Decode - Online](https://www.urlencoder.org/)

## 订阅服务器地址示例

https://subco.ltpg66.top:25500/sub?target=clash&url=

```
```
