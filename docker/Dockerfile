FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]


FROM openjdk:8-jre-alpine

WORKDIR /


RUN apk add --no-cache libstdc++

COPY target/paga-partner-portal.jar paga-partner-portal.jar
COPY entrypoint.sh entrypoint.sh

#for rootless
RUN addgroup -g 1000 pagapartnerportal
RUN adduser -u 1000 -G pagapartnerportal -D pagapartnerportal
RUN chown -R pagapartnerportal /usr/share/pagapartnerportal
USER 1000:1000

EXPOSE 9090

CMD ["sh", "-c", "/usr/share/pagapartnerportal/entrypoint.sh"]
