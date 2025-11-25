# Imagen base con Java 17
FROM eclipse-temurin:17-jdk-jammy

# Usuario de la app (igual que antes)
ENV APPLICATION_USER ktor

RUN useradd --create-home --shell /bin/bash $APPLICATION_USER
USER $APPLICATION_USER

WORKDIR /app

# Copiar el código del repo al contenedor
COPY . .

# Dar permisos al gradlew y construir el proyecto (genera Server.jar)
RUN chmod +x ./gradlew && ./gradlew stage --no-daemon -x test

# Ktor suele usar el puerto 8080
EXPOSE 8080

# Levantar la app (ajusta la ruta al jar si tu Dockerfile original copiaba el Server.jar a otra carpeta)
CMD ["java", "-jar", "Server.jar"]
