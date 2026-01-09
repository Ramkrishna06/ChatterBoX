# Use Eclipse Temurin JDK 17 as base image
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./

# Install Maven dependencies
RUN chmod +x ./mvnw && ./mvnw dependency:go-offline -B

# Copy the project source
COPY src ./src

# Package the application
RUN ./mvnw clean package -DskipTests

# Expose port (change if needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "target/app-0.0.1-SNAPSHOT.jar"]
