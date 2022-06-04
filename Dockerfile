FROM ubuntu:22.04
WORKDIR /opt
RUN apt update
RUN apt install -y git openjdk-11-jdk-headless wget
RUN wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz
RUN tar -xzf apache-maven-3.8.5-bin.tar.gz
ENV PATH=/opt/apache-maven-3.8.5/bin:$PATH
RUN git clone https://github.com/jenkinsci/jenkins.git
RUN cd ./jenkins && mvn -am -pl war,bom -DskipTests -Dspotbugs.skip -Dspotless.check.skip clean install
EXPOSE 8080
CMD java -jar /opt/jenkins/war/target/jenkins.war
