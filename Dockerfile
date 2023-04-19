# Stage 1 - Build Spring Boot app
FROM maven:3.6.3-jdk-8 AS build
WORKDIR /java-docker
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src /java-docker/src
RUN mvn clean package -DskipTests

# Stage 2 - Run Spring Boot app
FROM adoptopenjdk/openjdk8:alpine-jre
WORKDIR /java-docker
COPY --from=build /java-docker/target/spring-boot-2-hello-world-0.0.0-SNAPSHOT.jar /java-docker/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/java-docker/app.jar"]
