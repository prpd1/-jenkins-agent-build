FROM amazonlinux:2

ENV SONAR_TOKEN b81f6a6c2ed39b3acd92b8089c364a71483c19d9
ENV JAVA_HOME /opt/java/openjdk
ENV M2_HOME /opt/maven
ENV PATH $PATH:$JAVA_HOME/bin:$M2_HOME/bin
ENV PATH $PATH:/node-v16.18.0-linux-x64/bin
RUN yum install -y wget && \
    yum install -y curl && \
    yum install -y git && \
    yum install -y tar && \
    yum install -y gzip && \
    yum install -y xz
RUN mkdir -p /opt/java && \
    mkdir /opt/app
RUN wget https://nodejs.org/dist/v16.18.0/node-v16.18.0-linux-x64.tar.xz
RUN tar -xvf /node-v16.18.0-linux-x64.tar.xz && rm node-v16.18.0-linux-x64.tar.xz
RUN wget https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_linux-x64_bin.tar.gz && \
    tar xzf openjdk-17.0.1_linux-x64_bin.tar.gz -C /tmp && \
    mv /tmp/jdk-17.0.1 $JAVA_HOME && \
    rm openjdk-17.0.1_linux-x64_bin.tar.gz
RUN wget  https://archive.apache.org/dist/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz && \
    tar xzf apache-maven-3.8.6-bin.tar.gz -C /tmp && \
    mv /tmp/apache-maven-3.8.6 $M2_HOME && \
    rm apache-maven-3.8.6-bin.tar.gz
RUN curl -LO https://dl.k8s.io/release/v1.27.2/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/
RUN wget  https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz && \
    tar xzf helm-v3.7.0-linux-amd64.tar.gz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin/ && \
    rm helm-v3.7.0-linux-amd64.tar.gz
RUN /usr/local/bin/helm plugin install https://github.com/belitre/helm-push-artifactory-plugin --version v0.3.0
