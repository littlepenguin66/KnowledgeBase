# yt-dlp 使用技巧与常用命令

[熟肉]第一集：我在这个新的Minecraft Create Mod世界里有了一个史诗般的开始！FoxyNoTail-FXNT-Create-2

转载自：

转载自：https://www.youtube.com/watch?v\=1kzkovMA\_z8

转载自FoxyNoTail

FoxyNoTail - YouTube

https://www.youtube.com/watch?v=BhIK16WGRiI

# 视频下载工具 yt-dlp 的一些使用总结

## 下载相关命令

下面是我搬运视频时常用的一些命令：

```bash
# 下载最佳质量视频+音频
yt-dlp -f &quot;bestvideo+bestaudio&quot; https://www.youtube.com/watch?v={视频Id}

# 仅下载最佳质量的音频
yt-dlp -f &quot;bestaudio&quot; https://www.youtube.com/watch?v={视频Id}

# 下载最佳质量视频+音频整个播放列表
yt-dlp -f &quot;bestvideo+bestaudio&quot; https://www.youtube.com/playlist?list={播放列表Id}

# 指定条件下载,音频视频都可以加条件
# 下面 height&lt;= 1080表示下载最佳质量的1080p视频
yt-dlp -f &quot;bestvideo[height&lt;=1080]+bestaudio&quot; https://www.youtube.com/watch?v={视频Id}

# 下载字幕并且转为srt（默认下载下来是vtt格式，但是哔哩哔哩只能传srt）
yt-dlp --write-auto-sub --sub-lang zh-Hans --convert-subs=srt --skip-download https://www.youtube.com/watch?v={视频Id}

# 下载封面并且转为png（默认下载下来是webp格式，但是哔哩哔哩没法传webp格式图片）
yt-dlp --skip-download --write-thumbnail --convert-thumbnail png https://www.youtube.com/watch?v={视频Id}
```

实际搬运使用时，我发现下面一句命令就够了，可以下载视频、视频封面和字幕（如果有字幕）：

```bash
# 将{视频Id}替换为要下载的视频的Id,然后执行这句命令就可以一键下载了
# 下载完成后直接去投稿即可
yt-dlp -f bestvideo+bestaudio --write-auto-sub --convert-subs=srt --sub-lang "zh-Hans,en" --write-thumbnail --convert-thumbnail png https://www.youtube.com/watch?v={视频Id}
```

一句命令下载最高质量视频+字幕+封面图。

## 视频信息

这个命令可以获取视频信息。如果需要下载指定编码+分辨率的视频，可以通过这个命令预先查询，然后将需要的格式组合使用下载。

以下两张图片演示了如何获取某个视频可下载的格式信息。通过 **ID** 那一列下面的绿色数组组合，可以下载特定格式。

```bash
yt-dlp -F https://www.youtube.com/watch?v={视频Id}
# 这是一个下载示例
# 下载4K vp9编码的视频+m4a格式的音频（如果ffmpeg可用下载完成后会自动合并）
yt-dlp -f 313+140 https://www.youtube.com/watch?v=ebu2cxRXU-I
```

### 下载单个视频

* **下载视频：**

  ```bash
  yt-dlp https://www.youtube.com/watch?v=BaW_jenozKc
  ```

### 下载播放列表

* **下载整个播放列表：**

  ```bash
  yt-dlp https://www.youtube.com/playlist?list=PLwiyx1dc3P2JR9N8gQaQN_BCvlSlap7re
  ```

### 格式选择

* **下载最佳视频质量：**

  ```bash
  yt-dlp -f bestvideo+bestaudio https://www.youtube.com/watch?v=BaW_jenozKc
  ```
* **下载特定格式：**

  ```bash
  yt-dlp -f 22 https://www.youtube.com/watch?v=BaW_jenozKc
  ```

### 音频下载

* **提取音频：**

  ```bash
  yt-dlp -x --audio-format mp3 https://www.youtube.com/watch?v=BaW_jenozKc
  ```

### 模拟下载

* **模拟下载过程，不实际下载文件：**

  ```bash
  yt-dlp --simulate https://www.youtube.com/watch?v=BaW_jenozKc
  ```

### 列出所有可下载格式

* **列出视频的所有可下载格式：**

  ```bash
  yt-dlp --list-formats https://www.youtube.com/watch?v=BaW_jenozKc
  ```

### 配置文件

* **忽略所有配置文件：**

  ```bash
  yt-dlp --ignore-config https://www.youtube.com/watch?v=BaW_jenozKc
  ```

### 输出模板

* **自定义输出文件名：**

  ```bash
  yt-dlp -o "%(title)s.%(ext)s" https://www.youtube.com/watch?v=BaW_jenozKc
  ```

### 身份验证

* **使用用户名和密码进行身份验证：**

  ```bash
  yt-dlp -u username -p password https://www.example.com/video
  ```

这些是 yt-dlp 的一些基本使用技巧和常用命令，可以帮助你更有效地下载和管理视频内容。
