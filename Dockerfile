FROM debian:bookworm

# Install git, supervisor, VNC, & X11 packages
RUN set -ex && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    bash \
    fluxbox \
    tightvncserver \
    net-tools \
    novnc \
    supervisor \
    x11vnc \
    xterm \
    xvfb \
    unzip \
    dbus-x11 \
    xfonts-base \
    '^libxcb.*-dev' \
    libx11-xcb-dev \
    libglu1-mesa-dev \
    libxrender-dev \
    libxi-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libnss3 iptables xclip libxtst6 \
    busybox libssl-dev iproute2 libxss1 ca-certificates \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install gost
RUN wget https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-amd64-2.11.1.gz && \
    gunzip gost-linux-amd64-2.11.1.gz && \
    mv gost-linux-amd64-2.11.1 /usr/local/bin/gost && \
    chmod +x /usr/local/bin/gost && \
    rm -f gost-linux-amd64-2.11.1.gz

# Setup demo environment variables
ENV HOME=/root \
    USER=root \
    DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes

# Download and verify UniVPN
WORKDIR /root
ARG UNIVPN_VERSION=10781.15.0.1208
ARG UNIVPN_MD5=c23ca73547c288c6769a72df57babaa6
RUN wget https://download.leagsoft.com/download/UniVPN/linux/univpn-linux-64-${UNIVPN_VERSION}.zip && \
    echo "${UNIVPN_MD5}  univpn-linux-64-${UNIVPN_VERSION}.zip" | md5sum -c || exit 1

# Extract and install
RUN unzip univpn-linux-64-${UNIVPN_VERSION}.zip && \
    cd univpn-linux-64-${UNIVPN_VERSION} && \
    chmod +x univpn-linux-64-${UNIVPN_VERSION}.run && \
    mkdir /root/Desktop && \
    touch /root/.Xauthority && \
    ./univpn-linux-64-${UNIVPN_VERSION}.run

COPY root /root

EXPOSE 8080
EXPOSE 2222
EXPOSE 10801
EXPOSE 18888

COPY app /app
CMD ["/app/entrypoint.sh"]