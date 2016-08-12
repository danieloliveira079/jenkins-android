FROM jenkins:2.0

USER root

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git curl wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
ENV PATH ${PATH}:/opt/tools

RUN echo y | android update sdk --all --force --no-ui --filter 2,6,7,28,102,137,136,138,144,145

RUN apt-get install -y curl build-essential
RUN curl -o- https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get -y install nodejs

# Cleaning
RUN apt-get clean
