# FROM httpd:latest
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive
RUN echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d

RUN apt-get update && apt-get install -y curl iputils-ping net-tools kali-linux-headless
RUN setcap -r /usr/lib/nmap/nmap
