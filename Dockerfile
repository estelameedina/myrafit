FROM tomcat:10.1.52-jdk21

# Eliminar app por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copiar el WAR al directorio de Tomcat
COPY target/WebApp.war /usr/local/tomcat/webapps/ROOT.war

# Exponer puerto 8080
EXPOSE 8080

# CMD por defecto para iniciar Tomcat
CMD ["catalina.sh", "run"]
