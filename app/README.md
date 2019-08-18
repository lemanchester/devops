# Web application

Simple java web application.

### Dependencies

 - [Docker](https://www.docker.com/)

### Docker

Build the image:
```
$ docker build --tag=webapp .
```

Running the container:
```
$ docker run -p 8080:8080 webapp
```

### Web application

The application expose the port 8080 and you check running by:

http://localhost:8080/

It also provides a health check endpoint:

http://localhost:8080/actuator/health
