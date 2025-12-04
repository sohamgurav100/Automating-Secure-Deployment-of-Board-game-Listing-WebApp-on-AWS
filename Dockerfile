# ============================
# 1. Build Stage
# ============================
FROM maven:3.8.5-openjdk-17 AS build

WORKDIR /app

# Copy full project (because your source code is inside nested folder)
COPY . .

# Move into the inner project folder
WORKDIR /app/Automating-Secure-Deployment-of-Board-game-Listing-WebApp-on-AWS

# Make wrapper executable
RUN chmod +x mvnw

# Build the Spring Boot application
RUN ./mvnw -B clean package -DskipTests


# ============================
# 2. Runtime Stage
# ============================
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy jar from the correct location
COPY --from=build /app/Automating-Secure-Deployment-of-Board-game-Listing-WebApp-on-AWS/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
