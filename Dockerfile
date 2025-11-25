# Java estable soportado por Railway
FROM eclipse-temurin:17-jdk

ENV APPLICATION_USER ktor
RUN useradd -ms /bin/bash $APPLICATION_USER

RUN mkdir /app && chown -R $APPLICATION_USER /app

USER $APPLICATION_USER

WORKDIR /app

# Copiar el código al contenedor
COPY . /app

# Dar permisos a gradlew
RUN chmod +x ./gradlew

# Construir el JAR (usa el task "stage" si existe)
RUN ./gradlew build -x test

# Buscar el JAR generado
RUN cp $(find ./build/libs -name "*.jar" | head -n 1) app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
