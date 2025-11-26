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

# 💡 CORRECCIÓN CRÍTICA: Inyectar la variable MONGO_URI en la JVM
# Esto transforma la variable de entorno de Render (${MONGO_URI}) en una propiedad
# del sistema Java (-D...) que la aplicación puede leer durante la inicialización
CMD ["java", "-Dktor.config.environment=production", "-DMONGO_URI=${MONGO_URI}", "-jar", "Server.jar"]
