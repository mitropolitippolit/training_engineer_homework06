FROM ubuntu:22.04
WORKDIR /opt
RUN apt update
RUN apt install -y git maven openjdk-11-jdk-headless wget
RUN git clone https://github.com/daticahealth/java-tomcat-maven-example
RUN cd ./java-tomcat-maven-example && mvn package
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.63/bin/apache-tomcat-9.0.63.tar.gz
RUN tar -xzf apache-tomcat-9.0.63.tar.gz
RUN rm -rf /opt/apache-tomcat-9.0.63/webapps/*
RUN cp ./java-tomcat-maven-example/target/java-tomcat-maven-example.war /opt/apache-tomcat-9.0.63/webapps/ROOT.war
EXPOSE 8080
CMD /opt/apache-tomcat-9.0.63/bin/catalina.sh run
