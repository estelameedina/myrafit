===============================================
          MANUAL DE INSTALACIÓN
          MYRAFIT v1.0
===============================================

REQUISITOS:
- Java JDK 11 o superior
- Apache Tomcat 10.1.x
- MySQL 8.0 o superior
- MySQL Workbench (opcional, para importar la BBDD)

PASO 1: IMPORTAR LA BASE DE DATOS
=================================
1. Abre MySQL Workbench o terminal MySQL
2. Ejecuta el archivo "base_datos.sql"
3. Se creará la base de datos "myrafit" con todas las tablas


PASO 2: CONFIGURAR LA CONEXIÓN (si es necesario)
==================================================
El archivo de conexión está en:
src/main/java/utils/ConexionDB.java

Por defecto está configurado para:
- Host: localhost
- Puerto: 3306
- Base de datos: myrafit
- Usuario: root
- Contraseña: (vacía)


PASO 3: GENERAR EL WAR (desde IntelliJ)
========================================
1. Abre el proyecto en IntelliJ IDEA
2. Menú: Build → Build Artifacts → WebApp:war → Build
3. Se generará el archivo "WebApp.war" en la carpeta "out/artifacts/"
4. Copia el WAR a Tomcat: copia el archivo en:
   [tu_tomcat]/webapps/ROOT.war


PASO 4: INICIAR TOMCAT
======================
1. Ejecuta [tu_tomcat]/bin/startup.bat (Windows)
   o [tu_tomcat]/bin/startup.sh (Linux/Mac)

2. Espera a que se despliegue (puede tardar 1-2 minutos)


PASO 5: ACCEDER A LA APLICACIÓN
================================
Abre tu navegador y accede a:
http://localhost:8080/

CREDENCIALES DE ACCESO
======================
Usuario administrador:
- Email: admin@myrafit.com
- Contraseña: admin123

(NOTA: Esta contraseña es temporal. En producción debería cambiarla)


ESTRUCTURA DE ARCHIVOS
=======================
Entrega_Proyecto/
├── WebApp.war         -> Aplicación web
├── base_datos.sql     -> Script SQL de la base de datos
└── README.txt         -> Este archivo


SOLUCIÓN DE PROBLEMAS
=====================
- Si no conecta a la BBDD, verifica que MySQL está ejecutándose
- Si el WAR no se despliega, borra la carpeta "ROOT" en webapps y vuelve a intentarlo
- Comprueba que el puerto 8080 no esté siendo usado por otra aplicación


CONTACTO
========
Desarrollado por: Estela Ameedina
Proyecto Final DAW

===============================================
