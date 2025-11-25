# Usar Java 17 (obligatorio para Campus QR)
FROM eclipse-temurin:17-jdk

# Usuario de la app (igual que el original)
ENV APPLICATION_USER=ktor

RUN useradd -ms /bin/bash ${APPLICATION_USER}

# Carpeta de trabajo
WORKDIR /app

# Copiar el código del repo al contenedor
COPY . /app

# Dar permisos al gradlew y compilar la app (genera Server.jar)
RUN chmod +x ./gradlew && ./gradlew stage

# Ktor suele escuchar en 8080
ENV PORT=8080
EXPOSE 8080

# Ejecutar la app
CMD ["java", "-jar", "Server.jar"]
