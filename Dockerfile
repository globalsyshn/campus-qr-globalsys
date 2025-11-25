# Debian based
FROM eclipse-temurin:11-jdk

ENV APPLICATION_USER ktor
RUN adduser --disabled-password --gecos '' $APPLICATION_USER

# Crear carpeta de app
RUN mkdir /app && chown -R $APPLICATION_USER /app

USER $APPLICATION_USER

# El código YA está en la imagen (Render monta el repo),
# solo lo copiamos a /src-code para construir
WORKDIR /src-code
COPY . /src-code

# Dar permisos al gradlew y construir
RUN chmod +x ./gradlew && ./gradlew stage

# Copiar el jar generado a /app
RUN cp Server.jar /app/Server.jar

WORKDIR /app

# Ejecutar el servidor
CMD ["java", "-jar", "Server.jar"]
