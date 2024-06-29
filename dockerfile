FROM centos:v1
MAINTAINER shilinw

# 创建安装路径
RUN mkdir /usr/local/java
# 将安装包拷贝到镜像中
COPY jdk-17_linux-x64_bin.tar.gz /usr/local/java
# 解压镜像和安装
RUN cd /usr/local/java && tar -zxvf jdk-17_linux-x64_bin.tar.gz && rm -rf jdk-17_linux-x64_bin.tar.gz

#配置环境变量
ENV JAVA_HOME /usr/local/java/jdk-17.0.11
ENV PATH $JAVA_HOME/bin:$PATH

#是写入环境变量
RUN echo "export JAVA_HOME=$JAVA_HOME" >>/etc/profile 
RUN echo "export PATH=$JAVA_HOME/bin:\$PATH" >> /etc/profile

# 设置jenkins环境变量
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_VERSION 2.452.2
ENV JENKINS_WAR jenkins.war

RUN yum install git -y
RUN yum install fontconfig -y

RUN mkdir -p $JENKINS_HOME && chown -R root:root $JENKINS_HOME

COPY jenkins.war /usr/share

EXPOSE 8080
EXPOSE 5000

USER root

CMD ["java","-Djava.awt.headless=true","-jar","/usr/share/jenkins.war"]
