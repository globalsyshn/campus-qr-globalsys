# Java 17, soportado por Railway
FROM eclipse-temurin:17-jdk

ENV APPLICATION_USER=ktor

# Crear usuario
RUN useradd -ms /bin/bash ${APPLICATION_USER}

# Carpeta de trabajo
WORKDIR /app

# Copiar el código y cambiar propietario a ktor
COPY --chown=${APPLICATION_USER}:${APPLICATION_USER} . /app

# A partir de aquí, todo corre como ktor
USER ${APPLICATION_USER}

# Dar permisos a gradlew y compilar
RUN chmod +x ./gradlew \
  && ./gradlew build -x test --no-daemon

# Copiar el JAR generado a un nombre fijo
RUN cp $(find ./build/libs -name "*.jar" | head -n 1) app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
