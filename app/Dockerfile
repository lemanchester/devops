FROM openjdk:8-jre-alpine

RUN apk --no-cache add curl

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY . ./

EXPOSE 8080

HEALTHCHECK CMD curl --fail http://localhost:8080/actuator/health || exit 1

CMD ["java", "-jar", "helloworld.jar"]
