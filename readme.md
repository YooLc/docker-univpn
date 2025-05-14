# Docker wrapper for UniVPN

## Usage 使用方法

If you have docker-compose installed, you can run change the `REMOTE_HOST` variable in `docker-compose.yml`, then use the following command to start the container:

如果已经安装了 docker-compose,可以设置 `docker-compose.yml` 里面的 `REMOTE_HOST` 为远程主机的地址和端口，然后运行下面这一条就好:

```bash
docker compose start
```

Othewise, build the image and run the container with the following commands:

如果没有安装，就需要手动构建容器或拉取镜像，可以参考下面:

### Docker build 构建镜像

```bash
docker build -t docker-novnc-univpn .
```

### Docker pull 拉取镜像

```bash
docker pull ghcr.io/yoolc/docker-univpn:latest # timeout error 国内拉取失败可以执行：docker pull ghcr.nju.edu.cn/yooLc/docker-univpn:latest
docker tag ghcr.io/yoolc/docker-univpn:latest docker-novnc-univpn:latest # retag image name 重命名镜像名
```

### Run Container 运行容器

```bash
docker run -d \
  --name univpn \
  -p 8080:8080 \
  -p 2222:2222 \
  -p 10801:10801 \
  -p 18888:18888 \
  -e REMOTE_HOST=<Your Remote Host> \
  -v /app/univpn:/root/UniVPN \
  --device /dev/net/tun \
  --cap-add NET_ADMIN \
  docker-novnc-univpn
```
http proxy port：`18888`
socks5 proxy port：`10801`

## Setup for direct login 配置自动登录

Goto `http://localhost:8080/vnc.html` and login noVNC.

在 `http://localhost:8080/vnc.html` 可以看到容器的 noVNC 界面，进入后可以在图形界面中进行配置.

Start UniVPN, and login with your credentials, remember to tick the "Auto Login" checkbox.

Then, extract /root/UniVPN from the container and put it in the same directory as the Dockerfile.

After that, you can rebuild this image and run again.

在 UniVPN 登陆之后（记得点击自动登录），然后把容器 /root/UniVPN 这个目录下的文件提取出来，放到和 Dockerfile 同级的目录下。然后重新构建镜像并运行，就可以不用再登陆 noVNC 配置了。

## Credits

Adapted from [docker-novnc](https://github.com/theasp/docker-novnc) project by [theasp](https://github.com/theasp), [Youhei Sakurai](https://github.com/sakurai-youhei) and [Mettbrot](https://github.com/Mettbrot).
