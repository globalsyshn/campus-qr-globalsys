#debian based
FROM eclipse-temurin:21-jdk

# --- Corrección: Instalar Git ---
# Necesario para ejecutar el siguiente comando RUN git clone
RUN apt-get update && apt-get install -y git
# --------------------------------

ENV APPLICATION_USER ktor
RUN echo $APPLICATION_USER
RUN adduser --disabled-password --gecos '' $APPLICATION_USER

RUN mkdir /app
RUN chown -R $APPLICATION_USER /app

RUN git clone https://github.com/studo-app/campus-qr.git /src-code

RUN chown -R $APPLICATION_USER /src-code

USER $APPLICATION_USER

WORKDIR /src-code
RUN ./gradlew stage # Stage command will also be used by Heroku/Scalingo file

RUN cp Server.jar /app/Server.jar
WORKDIR /app

# 💡 SOLUCIÓN CRÍTICA: Inyectar la URI de MongoDB directamente en Java.
# Esto garantiza que el cliente de MongoDB (Katerbase/Mongo Driver) lea la URI correctamente
# y deje de intentar conectarse a "localhost:27017".
# La propiedad que Ktor está buscando es 'ktor.database.url'.
CMD ["java", "-Ddeployment.environment=production", "-Dktor.database.url=mongodb+srv://globalsyshn_db_user:3x62K0nnOzBvmEtT@campusqr-db.pmnaye2.mongodb.net/?appName=CampusQR-DB", "-jar", "Server.jar"]
