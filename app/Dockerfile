FROM openjdk:8-jre-alpine

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY . ./

EXPOSE 8080

CMD ["java", "-jar", "helloworld.jar"]
