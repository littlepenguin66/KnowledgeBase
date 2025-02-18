# 备份与恢复 | Halo 文档

从 Halo 2.8 开始，Halo 内置了备份和恢复的功能，可以在 Console 中一键备份和恢复完整的数据。

## 备份

在 Console 中，点击左侧菜单的 `备份`​，进入备份页面。

点击右上角的 `创建备份`​ 按钮，即可创建一个新的备份请求，需要注意的是，创建备份请求并不会立即开始备份，而是会在后台异步执行，因此需要等待一段时间才能看到备份的结果。

​![创建备份](https://docs.halo.run/assets/images/create-backup-db50894574d398bffbf20b77d8ce5ff1.png)​

备份中：

​![备份进行中](https://docs.halo.run/assets/images/backup-running-ff2057b8605f43a3491c72014352d8ea.png)​

备份完成：

​![备份完成](https://docs.halo.run/assets/images/backup-complete-df9772ba86887cd0818fd8af7bbb3b88.png)​

## 恢复

在恢复前，需要了解以下几点：

1. 恢复不限制部署方式，也不限制数据库，也就是说新站点的部署方式和数据库类型可以和备份的站点不同。
2. 恢复过程可能会持续较长时间，期间请勿刷新页面。
3. 在恢复的过程中，虽然已有的数据不会被清理掉，但如果有冲突的数据将被覆盖。
4. 恢复完成之后会提示停止运行 Halo，停止之后可能需要手动运行。

在 Console 中，点击左侧菜单的 `备份`​，进入备份页面，然后点击 `恢复`​ 选项卡即可进入恢复界面，阅读完注意事项之后点击 `开始恢复`​ 按钮即可显示备份文件上传界面。

​![恢复前](https://docs.halo.run/assets/images/before-restore-34297f9709b97d1b56193efed7d75b6d.png)  
​![开始恢复](https://docs.halo.run/assets/images/restore-c583fc43abb416cfc56cf23c8941a0ee.png)​

Halo 支持三种恢复方式：

1. 上传备份文件：上传已有的备份文件进行恢复。
2. 远程恢复：从远程 URL 下载备份文件进行恢复。
3. 从备份文件恢复：支持从工作目录的 backups 目录扫描备份文件，并选择文件进行恢复。

提示：如果你的备份文件较大，推荐提前将备份文件上传到服务器，然后选择 `从备份文件恢复`​ 方式进行恢复，避免因为网络原因导致上传失败。

使用 `上传备份文件`​ 方式进行恢复的操作示例：

选择备份文件后，点击 `上传`​ 按钮即可开始上传备份文件，上传完成后会自动开始恢复。

​![上传备份文件](https://docs.halo.run/assets/images/restore-upload-30ae750f5e3c450bcada69954e7decee.png)​

恢复完成，会提示重启 Halo，点击 `确定`​ 按钮即可重启 Halo。

最后，建议去服务器检查 Halo 的运行状态，如果没有设置自动重启，需要手动重启。
