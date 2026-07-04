FROM openjdk:17-slim
WORKDIR /app
COPY build/libs/tactical-*-all.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
