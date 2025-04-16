# Use a Java 21 JRE base image
FROM openjdk:21-jdk-slim
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the target directory into the container at /app/app.jar
COPY target/demo-*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# The command to run when the container starts
ENTRYPOINT ["java", "-jar", "/app/app.jar"]