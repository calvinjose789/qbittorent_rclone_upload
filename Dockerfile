FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG QBITTORRENT_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs, thelamer"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config" \
XDG_CONFIG_HOME="/config" \
XDG_DATA_HOME="/config"

# add repo and install qbitorrent
RUN \
 echo "***** add qbitorrent repositories ****" && \
 apt-get update && \
 apt-get install -y \
	gnupg \
	python3 && \
 curl -s https://bintray.com/user/downloadSubjectPublicKey?username=fedarovich | apt-key add - && \
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:11371 --recv-keys 7CA69FC4 && \
 echo "deb http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu bionic main" >> /etc/apt/sources.list.d/qbitorrent.list && \
 echo "deb-src http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu bionic main" >> /etc/apt/sources.list.d/qbitorrent.list && \
 echo "deb https://dl.bintray.com/fedarovich/qbittorrent-cli-debian bionic main" >> /etc/apt/sources.list.d/qbitorrent.list && \
 echo "**** install packages ****" && \
 if [ -z ${QBITTORRENT_VERSION+x} ]; then \
	QBITTORRENT_VERSION=$(curl -sX GET http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu/dists/bionic/main/binary-amd64/Packages.gz | gunzip -c \
	|grep -A 7 -m 1 "Package: qbittorrent-nox" | awk -F ": " '/Version/{print $2;exit}');\
 fi && \
 apt-get update && \
 apt-get install -y \
	p7zip-full \
	qbittorrent-cli \
	qbittorrent-nox=${QBITTORRENT_VERSION} \
	unrar \
	geoip-bin \
	unzip && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

RUN apt-get update
RUN apt-get install sudo
RUN sudo apt-get update
RUN apt-get install yum -y

RUN apt-get install wget -y

RUN wget https://github.com/666wcy/qbittorent_rclone_upload/raw/main/rclone-current-linux-amd64.zip
RUN unzip rclone-current-linux-amd64.zip
RUN chmod 0777 ./rclone-*/rclone
RUN cp ./rclone-*/rclone /usr/bin/
RUN rm -rf ./rclone-*

# ports and volumes
EXPOSE 6881 6881/udp 8080
VOLUME /config /downloads /upload
CMD 	 wget -N  https://github.com/666wcy/qbittorent_rclone_upload/raw/main/check.sh && chmod +x check.sh &&./check.sh	

