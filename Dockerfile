# Use the Maven image to build and run the application
FROM maven:3.8.4-openjdk-8-slim AS build

# Set the working directory inside the docker container
WORKDIR /app

# Copy the pom.xml and download the dependencies
COPY pom.xml .

# Download the project dependencies without building the application yet
RUN mvn dependency:resolve

# Now copy the rest of the project
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Run the application
EXPOSE 8080
CMD ["java", "-jar", "target/spring-boot-docker.jar"]
