FROM ubuntu:22.04
WORKDIR /opt
RUN apt update
RUN apt install -y git maven openjdk-11-jdk-headless wget htop nload
RUN git clone https://github.com/daticahealth/java-tomcat-maven-example
RUN cd ./java-tomcat-maven-example && mvn package
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.64/bin/apache-tomcat-9.0.64.tar.gz
RUN tar -xzf apache-tomcat-9.0.64.tar.gz
RUN rm -rf /opt/apache-tomcat-9.0.64/webapps/*
RUN cp ./java-tomcat-maven-example/target/java-tomcat-maven-example.war /opt/apache-tomcat-9.0.64/webapps/ROOT.war
EXPOSE 8080
CMD /opt/apache-tomcat-9.0.64/bin/catalina.sh run
