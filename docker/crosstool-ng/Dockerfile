FROM ubuntu:24.04

# Non-interactive configuration of tzdata
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
RUN { echo 'tzdata tzdata/Areas select Etc'; echo 'tzdata tzdata/Zones/Etc select UTC'; } | debconf-set-selections

RUN apt-get update
RUN apt-get install -y gcc g++ gperf bison flex texinfo help2man make libncurses5-dev \
    python3-dev autoconf automake libtool libtool-bin gawk wget bzip2 xz-utils unzip \
    patch libstdc++6 rsync git meson ninja-build sudo
RUN wget -O /sbin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod a+x /sbin/dumb-init
RUN echo 'export PATH=/opt/ctng/bin:$PATH' >> /etc/profile

RUN apt-get install -y fd-find ripgrep lsof iproute2 neovim

ARG CTNG_UID=2000
ARG CTNG_GID=2000
RUN groupadd -g $CTNG_GID ctng
RUN useradd -d /home/ctng -m -g $CTNG_GID -u $CTNG_UID -s /bin/bash ctng
RUN echo "ctng ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ctng

USER ctng
WORKDIR /home/ctng
RUN git clone https://github.com/crosstool-ng/crosstool-ng
WORKDIR /home/ctng/crosstool-ng/
RUN ./bootstrap
RUN ./configure --prefix=/opt/ctng && make

USER root
RUN make install
RUN cp bash-completion/ct-ng /etc/bash_completion.d/

ENTRYPOINT [ "/sbin/dumb-init", "--" ]

