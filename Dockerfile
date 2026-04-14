# Etapa 1: Compilar con Maven
FROM maven:3.9-openjdk-21 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Desplegar en Tomcat
FROM tomcat:10.1.52-jdk21
COPY --from=builder /app/target/WebApp.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
