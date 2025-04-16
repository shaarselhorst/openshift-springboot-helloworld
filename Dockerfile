# Stage 1: Build the application using Maven and JDK
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /app

# Prepare dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the entire project
COPY src ./src

# Build the project using Maven
RUN mvn package -DskipTests

# Stage 2: Create the final runtime image
FROM openjdk:21-jdk-slim

WORKDIR /app

# Copy only the built JAR file from the 'builder' stage (Stage 1)
COPY --from=builder /app/target/demo-*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]