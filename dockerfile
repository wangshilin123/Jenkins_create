FROM centos:v1
MAINTAINER shilinw

# 创建安装路径
RUN mkdir /usr/local/java
# 将安装包拷贝到镜像中
COPY jdk-8u271-linux-x64.tar.gz /usr/local/java
# 解压镜像和安装
RUN cd /usr/local/java && tar -zxvf jdk-8u271-linux-x64.tar.gz && rm -rf jdk-8u271-linux-x64.tar.gz

#配置环境变量
ENV JAVA_HOME /usr/local/java/jdk1.8.0_271
ENV PATH $JAVA_HOME/bin:$PATH

#是写入环境变量
RUN echo "export JAVA_HOME=$JAVA_HOME" >>/etc/profile 
RUN echo "export PATH=$JAVA_HOME/bin:\$PATH" >> /etc/profile


