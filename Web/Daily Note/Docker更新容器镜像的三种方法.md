# Docker更新容器镜像的三种方法

# Docker更新容器镜像的三种方法

## 方法一：更新使用`docker`命令部署的应用

1. **确定容器名称**

   ```bash
   docker ps
   ```

   - 查看运行中的容器列表。
   - 找到需要更新的容器名称。
2. **备份数据并停止容器**

   - 使用`docker inspect`找到容器中挂载的数据卷位置。
     ```bash
     docker inspect <容器名称>
     ```
   - 备份数据卷中的数据。
     ```bash
     cp -r <数据卷路径> <备份路径>
     ```

     例如:
     ```bash
     cp -r ~/.halo ~/.halo.1.4.15
     ```
3. **拉取最新镜像**

   - 使用`docker pull`下载最新的镜像。
     ```bash
     docker pull <镜像名称>:<版本号>
     ```

     例如:
     ```bash
     docker pull halohub/halo:1.4.16
     ```
4. **重新创建容器**

   - 使用`docker run`命令启动新的容器。
     ```bash
     docker run -it -d --name <容器名称> -p <主机端口>:<容器端口> -v <主机路径>:<容器路径> --restart=<策略> <镜像名称>:<版本号>
     ```

     例如:
     ```bash
     docker run -it -d --name halo -p 8090:8090 -v ~/.halo:/root/.halo --restart=unless-stopped halohub/halo:1.4.16
     ```

## 方法二：更新使用`docker-compose`部署的应用

1. **拉取最新镜像**

   - 在`docker-compose.yml`文件所在目录执行:
     ```bash
     docker-compose pull
     ```
2. **重启容器**

   - 使用`docker-compose up`命令来重启容器。
     ```bash
     docker-compose up -d --remove-orphans
     ```
3. **清理不再使用的镜像**（可选）

   - 使用`docker image prune`命令删除未被任何容器使用的镜像。
     ```bash
     docker image prune
     ```

## 方法三：使用Portainer更新容器

1. **登录Portainer**

   - 登录Portainer控制面板。
2. **更新容器**

   - 选择需要更新的容器。
   - 点击“Recreate”按钮。
   - 点击“Pull latest images”按钮。
   - 再次点击“Recreate”按钮。
   - 等待更新过程完成。

以上步骤可以确保您安全地更新Docker容器镜像，同时保持数据的完整性。注意，在实际操作前，最好确保对现有系统进行了充分的备份，以防万一更新过程中出现问题。
