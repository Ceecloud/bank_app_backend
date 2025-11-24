# Stage 1: Build with Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy pom and source code
COPY pom.xml .
COPY src ./src

# Build the application and skip tests completely
RUN mvn clean package -Dmaven.test.skip=true

# Stage 2: Run JAR with JRE
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose default port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

