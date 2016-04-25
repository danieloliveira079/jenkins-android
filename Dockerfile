FROM jenkins:2.0

USER root

RUN apt-get update && apt-get install -y lib32stdc++6 lib32z1
RUN apt-get install -y libc6-i386 lib32gcc1 lib32ncurses5

WORKDIR /opt

RUN wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz

RUN tar zxvf android-sdk_r24.4.1-linux.tgz

RUN rm android-sdk_r24.4.1-linux.tgz

RUN chmod -R 755 /opt/android-sdk-linux

COPY android.sh /etc/profile.d/android.sh

ENV ANDROID_HOME="/opt/android-sdk-linux"
ENV PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

RUN echo y | android update sdk -u --all --filter 6,7,29,102,137,138,144,145 --force
