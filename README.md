# appBackDitechPolitec

Este proyecto esta hecho con Spring Boot y es de tipo Maven. Para correrlo se recomienda descargar Spring Tools 4 for Eclipse (https://spring.io/tools) y abrir el proyecto desde allí.

en la clase AppPruebaAlianzaApplication (contiene el método main) click derecho -> Run As -> Spring Boot App para ejecutarlo


# pasos previos:

para configurar la base de datos, basta ubicarse en la raiz del proyecto y ejecutar el comando: 

docker-compose up 

allí en la raiz hay un archivo llamado docker-compose.yml que contiene lo necesario para tener la DB que es Oracle 18

después ejecutar los scripts de la carpeta scripts de la raiz para crear tablas y paquetes necesarios. 
