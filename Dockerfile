# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/DevOps_Project-1.0.jar app.jar

# Specify the command to run your application
CMD ["java", "-jar", "app.jar"]