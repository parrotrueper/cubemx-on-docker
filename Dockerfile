# Docker Image for Cube MX to generate cmake project
#===================================================
#https://www.st.com/en/development-tools/stm32cubemx.html
FROM ubuntu:22.04

ARG ARG_USER_UID=1000
ARG ARG_USER_GID=${ARG_USER_UID}
# make it obvious we are inside a container, user names after cartoon characters
ARG ARG_USER_NAME=tiger

ARG VERSION="6.13"
ARG CUBEMX_VERSION="en.stm32cubemx-lin-v6-13-0.zip"

ADD ./docker-data/${CUBEMX_VERSION} /tmp/${CUBEMX_VERSION}
ADD ./docker-data/auto-install.xml /tmp/auto-install.xml
COPY ./docker-data/.bashrc /etc/bash.bashrc

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    # date and time
    tzdata  \
    locales \
    unzip \
    # cube dependencies
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libusb-1.0 \
    usbutils   \
    unzip \
    dpkg  \
    openjdk-17-jre \
    udev \
    libpython2.7 \
    libwebkit2gtk-4.0-37 \
    libncurses5 \
    dbus-x11 \
    at-spi2-core \
    chromium-browser \
    libc6-i386 && \
    # Do not use dash, make /bin/sh symlink to bash instead of dash:
    echo "dash dash/sh boolean false" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash && \
    cd /tmp && \
    unzip ${CUBEMX_VERSION} && \
    /tmp/SetupSTM32CubeMX-${VERSION}.0 auto-install.xml && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    # set the language
    /usr/sbin/locale-gen en_GB.UTF-8 && \
    # Add the group
    groupadd --gid ${ARG_USER_GID} ${ARG_USER_NAME} && \
    # Add the user
    useradd --uid ${ARG_USER_UID} --gid ${ARG_USER_GID} --shell /bin/bash ${ARG_USER_NAME} && \
    # add an .ssh directory for the keys
    mkdir -p /tmp/workspace && \
    mkdir -p /home && \
    ln -s /tmp/workspace /home/${ARG_USER_NAME} && \
    chown -R ${ARG_USER_UID}:${ARG_USER_GID} /opt

    USER ${ARG_USER_NAME}
    WORKDIR /home/${ARG_USER_NAME}
    ENV PATH="$PATH"
    ENV LANG=en_GB.UTF-8
    ENV LANGUAGE=en_GB.UTF-8
    ENV LC_ALL=en_GB.UTF-8
    SHELL ["/bin/bash", "-c"]
    RUN source /etc/bash.bashrc


