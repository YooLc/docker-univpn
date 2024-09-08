# Docker wrapper for UniVPN

## Usage

If you have docker-compose installed, you can run change the `REMOTE_HOST` variable in `docker-compose.yml`, then use the following command to start the container:

```bash
docker compose start
```

Othewise, build the image and run the container with the following commands:

```bash
docker build -t docker-novnc-univpn .

docker run -d \
  --name univpn \
  -p 8080:8080 \
  -p 2222:2222 \
  -e REMOTE_HOST=<Your Remote Host> \
  --device /dev/net/tun \
  --cap-add NET_ADMIN \
  docker-novnc-univpn
```

## Setup for direct login

Goto `http://localhost:8080` and login noVNC.

Start UniVPN, and login with your credentials, remember to tick the "Auto Login" checkbox.

Then, extract /root/UniVPN from the container and put it in the same directory as the Dockerfile.

After that, you can rebuild this image and run again.

## Credits

Adapted from [docker-novnc](https://github.com/theasp/docker-novnc) project by [theasp](https://github.com/theasp), [Youhei Sakurai](https://github.com/sakurai-youhei) and [Mettbrot](https://github.com/Mettbrot).
