FROM gradle:jdk14 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM openjdk:14.0-slim

EXPOSE 4567

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/application.jar

ENTRYPOINT ["java", "-jar","/app/application.jar"]
