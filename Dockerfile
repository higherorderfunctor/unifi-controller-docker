FROM ubuntu:bionic

RUN apt-get update

RUN apt-get install --no-install-recommends -y jsvc wget

RUN mkdir /opt/jdk
RUN wget --no-check-certificate https://download.oracle.com/java/17/latest/jdk-17_linux-aarch64_bin.tar.gz
RUN tar -zxf jdk-17_linux-aarch64_bin.tar.gz -C /opt/jdk --strip-components 1
RUN update-alternatives --install /usr/bin/java java /opt/jdk/bin/java 0
RUN update-alternatives --install /usr/bin/javac javac /opt/jdk/bin/javac 0
RUn rm jdk-17_linux-aarch64_bin.tar.gz


# install base dependence
ARG TZ
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update && apt-get install -y -q --no-install-recommends \
        tzdata libcurl4 logrotate curl libcap2 binutils libssl1.0.0

# sync timezone
RUN echo '$TZ' > /etc/timezone \
    && ln -fsn /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN wget --no-check-certificate https://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/3.6/multiverse/binary-arm64/mongodb-org-server_3.6.23_arm64.deb

# RUN dkph -i mongodb-org-server_3.6.23_arm64.deb

RUN wget http://dl.ubnt.com/unifi/6.4.54/unifi_sysvinit_all.deb


#RUN dpkg -i mongodb-org-server_3.6.23_arm64.deb

#RUN dpkg --force-all -i unifi_sysvinit_all.deb

# java ${JVM_OPTS} -jar /usr/lib/unifi/lib/ace.jar start

#RUN rm mongodb-org-server_3.6.23_arm64.deb
#RUN rm unifi_sysvinit_all.deb

# https://stackoverflow.com/a/69179997
# JVM_OPTS="-Xmx1024M -Djava.awt.headless=true -Dfile.encoding=UTF-8 --add-exports=java.base/sun.nio.ch=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-exports=jdk.unsupported/sun.misc=ALL-UNNAMED"

  #software-properties-common \
# docker build -t unifi .
# docker build --build-arg TZ=$(cat /etc/timezone) -t unifi .
# docker run -it --rm --hostname unifi-controller --name unifi-controller unifi /bin/bash

# ARG ARG_TIMEZONE=Asia/Shanghai
# ENV ENV_TIMEZONE                ${ARG_TIMEZONE}

# # install base dependence
# RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
#     && apt-get update && apt-get install -y -q \
#         dialog apt-utils \
#         locales systemd cron \
#         vim wget curl exuberant-ctags tree \
#         tzdata ntp ntpstat ntpdate \
#     && apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* \
#     && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
#
# # sync timezone
# RUN echo '$ENV_TIMEZONE' > /etc/timezone \
#     && ln -fsn /usr/share/zoneinfo/$ENV_TIMEZONE /etc/localtime \
#     && dpkg-reconfigure --frontend noninteractive tzdata
#
