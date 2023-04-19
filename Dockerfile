# Stage 1 - Build Spring Boot app
FROM maven:3.6.3-jdk-8 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src /app/src
RUN mvn clean package -DskipTests

# Stage 2 - Run Spring Boot app
FROM adoptopenjdk/openjdk8:alpine-jre
WORKDIR /app
COPY --from=build /app/target/myapp-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]