# Speedtest

1. **完全模式**：

    * 这个模式会执行所有的测试项目，包括speedtest国内外测速、Geekbench v5性能测试以及流媒体解锁测试等。
    * 使用方法：

      ```
      bash <(wget -qO- https://down.vpsaff.net/linux/speedtest/superbench.sh)
      或
      wget -qO- https://down.vpsaff.net/linux/speedtest/superbench.sh | sudo bash
      ```
2. **精简模式**：

    * 这个模式会跳过Geekbench v5和国际speedtest网络测试，只执行部分测试项目。
    * 使用方法：

      ```
      bash <(wget -qO- https://down.vpsaff.net/linux/speedtest/superbench.sh) -f
      ```
3. **Speedtest模式**：

    * 这个模式仅进行speedtest的国内网络测试，不包括其他测试项目。
    * 使用方法：

      ```
      bash <(wget -qO- https://down.vpsaff.net/linux/speedtest/superbench.sh) -s
      ```
