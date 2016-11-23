FROM ubuntu:15.04

MAINTAINER didika914@gmail.com

RUN dpkg --add-architecture i386
RUN apt-get update -qq

RUN apt-get install -y --no-install-recommends \
    python \
    openjdk-8-jdk \
    wget \
    curl \
    git \
    libncurses5:i386 \
    libstdc++6:i386 \
    zlib1g:i386 \
    maven

# Install android sdk
RUN cd /opt && \
    curl -O http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    tar xzf android-sdk_r24.4.1-linux.tgz && \
    rm -f android-sdk_r24.4.1-linux.tgz

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

COPY tools /opt/sdk-tools
ENV PATH ${PATH}:/opt/sdk-tools

# Install google cloud sdk
RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz -P /tmp/ \
    && tar -C /usr/local/ -xzf /tmp/google-cloud-sdk.tar.gz \
    && CLOUDSDK_CORE_DISABLE_PROMPTS=1 /usr/local/google-cloud-sdk/install.sh \
       --usage-reporting=true \
       --path-update=true \
       --bash-completion=true \
       --rc-path=/.bashrc \
    && rm /tmp/google-cloud-sdk.tar.gz

ENV PATH /google-cloud-sdk/bin:$PATH

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
