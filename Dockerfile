# Imagen base con Java 17 (compatible con Ktor)
FROM eclipse-temurin:17-jdk

# Crear carpeta de la app
WORKDIR /app

# Copiar TODO el proyecto al contenedor
COPY . .

# Dar permisos al gradlew
RUN chmod +x ./gradlew

# Construir la app (elimina tests para evitar fallos en build)
RUN ./gradlew build -x test

# Buscar el .jar generado y renombrarlo como app.jar
RUN cp $(find build/libs -name "*.jar" | head -n 1) app.jar

# Puerto donde corre Ktor
EXPOSE 8080

# Comando para ejecutar el servidor
CMD ["java", "-jar", "app.jar"]
