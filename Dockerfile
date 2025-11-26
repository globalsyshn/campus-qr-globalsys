# debian based
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
# *** CAMBIO APLICADO AQUÍ ***
# Se agregó 'clean' antes de 'stage' para resolver el error de Webpack/Kotlin/JS.
RUN ./gradlew clean stage

RUN cp Server.jar /app/Server.jar
WORKDIR /app

# 🚀 LÍNEA CRÍTICA FINAL: La URI de MongoDB debe ser visible y completa aquí.
CMD ["java", "-Ddeployment.environment=production", "-Dktor.database.url=mongodb+srv://globalsyshn_db_user:3x62K0nnOzvmEtT@campusqr-db.pmnaye2.mongodb.net/?appName=CampusQR-DB", "-jar", "Server.jar"]
