# Portainer 安装与使用

---

title: Portainer 安装与使用
date: 2024-09-04
tags:

- Coding
  categories: Ubuntu

---

# Portainer 安装与使用

## 1. 安装 Portainer

1. **编写 **​**​`docker-compose`​**​ ** 文件**
   - 创建一个名为 `portainer.yml` 的文件。
   - 在文件中编写以下内容：
     ```yaml
     version: "3"
     services:
       portainer:
         image: portainer/portainer:latest
         container_name: portainer
         ports:
           - "9000:9000"
         volumes:
           - /app/portainer/data:/data
           - /var/run/docker.sock:/var/run/docker.sock
     ```
2. **上传配置文件**
   - 将 `portainer.yml` 文件上传至服务器。
3. **启动 Portainer**
   - 以前台模式启动 Portainer：
     ```bash
     docker-compose -f portainer.yml up
     ```
4. **初始化 Portainer**
   - 访问服务器的 9000 端口。
   - 设置用户名和密码。
5. **配置本地管理**
   - 登录后点击 `Local` 进行本地容器管理。
6. **后台启动 Portainer**
   - 确认无误后，以后台模式启动 Portainer：
     ```bash
     docker-compose -f portainer.yml up -d
     ```

## 2. 使用 Portainer 部署 Redis Sentinel

1. **配置主从架构**
   - 创建一个名为 `redis-cluster.yml` 的文件。
   - 编写以下内容：
     ```yaml
     version: '3'
     services:
       # 主节点
       master:
         image: redis
         container_name: redis-master
         command: redis-server --requirepass <password> --masterauth <password>
         ports:
           - "16379:6379"
       # 从节点 1
       slave1:
         image: redis
         container_name: redis-slave-1
         ports:
           - "16380:6379"
         command: redis-server --slaveof redis-master 6379 --requirepass <password> --masterauth <password>
       # 从节点 2
       slave2:
         image: redis
         container_name: redis-slave-2
         ports:
           - "16381:6379"
         command: redis-server --slaveof redis-master 6379 --requirepass <password> --masterauth <password>
     ```
2. **启动主从结构**
   - 上传 `redis-cluster.yml` 至服务器。
   - 启动主从结构：
     ```bash
     docker-compose -f redis-cluster.yml up
     ```
3. **测试主从同步**
   - 在 Portainer 中查看容器列表，确认主从结构正确启动。
   - 进入主容器，使用 `redis-cli` 设置键值对。
   - 在从容器中验证数据是否同步。
4. **配置哨兵**
   - 创建一个名为 `redis-sentinel.yml` 的文件。
   - 添加哨兵配置，并启动哨兵容器：
     ```yaml
     version: '3'
     services:
       sentinel1:
         image: redis
         container_name: redis-sentinel-1
         ports:
           - "26379:26379"
         command: redis-sentinel /usr/local/etc/redis/sentinel.conf
         volumes:
           - /app/cloud/redis/sentinel/sentinel1.conf:/usr/local/etc/redis/sentinel.conf
       sentinel2:
         image: redis
         container_name: redis-sentinel-2
         ports:
           - "26380:26379"
         command: redis-sentinel /usr/local/etc/redis/sentinel.conf
         volumes:
           - /app/cloud/redis/sentinel/sentinel2.conf:/usr/local/etc/redis/sentinel.conf
       sentinel3:
         image: redis
         container_name: redis-sentinel-3
         ports:
           - "26381:26379"
         command: redis-sentinel /usr/local/etc/redis/sentinel.conf
         volumes:
           - /app/cloud/redis/sentinel/sentinel3.conf:/usr/local/etc/redis/sentinel.conf
       # 将哨兵加入到redis-sentinel网络
       networks:
         default:
           external:
             name: redis-sentinel
     ```
5. **创建自定义网络**
   - 在 Portainer 中创建一个名为 `redis-sentinel` 的桥接网络。
   - 将主从节点和哨兵节点加入到该网络中。

# 注意事项

- **网络驱动类型**：

  - `host`: 使用docker宿主机网络。
  - `bridge`: 支持同一宿主机上的容器间通信。
  - `none`: 完全隔离的网络，需要手工配置。
  - `overlay`: 适用于宿主机集群中的容器间通信。
  - `macvlan`: 适用于容器实例需要与宿主机的MAC地址直接通信的情况。
- **端口映射**：

  - 建议不要使用默认端口 6379，以增加安全性。
- **密码保护**：

  - `<password>` 需要替换为实际的安全密码。

通过这些步骤，你可以成功地安装和使用 Portainer，并进一步利用它来部署和管理复杂的 Redis Sentinel 架构。
