# NPS-OpenWrt

[NPS](https://github.com/djylb/nps) OpenWrt repository

[NPS](https://github.com/djylb/nps) 的 OpenWrt 仓库

---

## Usage / 用法

1. Check your system's architecture / 查看当前系统架构:
   ```bash
   uname -m
   ```

2. Download the `.ipk` file from the [Release](https://github.com/djylb/nps-openwrt/releases) / 从[发布页面](https://github.com/djylb/nps-openwrt/releases)下载 `.ipk` 文件.

3. Install with `opkg` / 使用 `opkg` 安装:
   ```bash
   opkg install *.ipk
   ```
    
   If version conflicts occur / 如果版本不兼容，可以强制安装:
   ```bash
   opkg install --force-downgrade --force-depends *.ipk
   ```

---

## Build / 编译

1. Edit `feeds.conf` and add the NPS source / 编辑 `feeds.conf` 文件，添加 NPS 源:
   ```bash
   echo "src-git nps https://github.com/djylb/nps-openwrt.git" >> feeds.conf
   ```

2. Update feeds and install the NPS package / 更新 feeds 并安装 NPS 包:
   ```bash
   ./scripts/feeds update nps
   ./scripts/feeds install -a -p nps
   ```

3. Build / 编译:
   ```bash
   make menuconfig
   make -j$(nproc)
   ```
