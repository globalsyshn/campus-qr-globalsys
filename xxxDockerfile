# Imagen base con JDK 11
FROM eclipse-temurin:17-jdk

# Directorio de trabajo donde se copiará el código
WORKDIR /src-code

# Copiar todo el repo al contenedor
COPY . /src-code

# Dar permisos al gradlew y construir el proyecto
RUN chmod +x ./gradlew && ./gradlew stage

# Crear carpeta para la app y copiar el jar generado
RUN mkdir -p /app && cp Server.jar /app/Server.jar

# Cambiar al directorio de la app
WORKDIR /app

# Ejecutar el servidor
CMD ["java", "-jar", "Server.jar"]
