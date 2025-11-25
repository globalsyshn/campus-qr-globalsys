# Debian based
FROM eclipse-temurin:11-jdk

ENV APPLICATION_USER ktor
RUN echo $APPLICATION_USER
RUN adduser --disabled-password --gecos '' $APPLICATION_USER

RUN mkdir /app
RUN chown -R $APPLICATION_USER /app

# Clonar el repositorio original dentro del contenedor
RUN git clone https://github.com/studo-app/campus-qr.git /src-code
RUN chown -R $APPLICATION_USER /src-code

USER $APPLICATION_USER

WORKDIR /src-code

# Construir con Gradle
RUN ./gradlew stage

# Copiar el jar generado a /app
RUN cp Server.jar /app/Server.jar

WORKDIR /app

# Ejecutar el servidor
CMD ["java", "-jar", "Server.jar"]
