FROM ubuntu:15.04

MAINTAINER didika914@gmail.com

RUN dpkg --add-architecture i386
RUN apt-get update -qq

RUN apt-get install -y --no-install-recommends \
    openjdk-8-jdk \
    curl \
    libncurses5:i386 \
    libstdc++6:i386 \
    zlib1g:i386 \
    maven

RUN cd /opt && \
    curl -O http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    tar xzf android-sdk_r24.4.1-linux.tgz && \
    rm -f android-sdk_r24.4.1-linux.tgz

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

COPY tools /opt/sdk-tools
ENV PATH ${PATH}:/opt/sdk-tools

# Add your android modules here
RUN /opt/sdk-tools/install-module-with-accept.sh \
    tools \
    platform-tools \
    build-tools-24.0.1 \
    extra-android-support \
    android-24 \
    extra-android-m2repository \
    extra-google-m2repository

RUN apt-get clean

VOLUME /root/.m2
VOLUME /workspace
WORKDIR /workspace
