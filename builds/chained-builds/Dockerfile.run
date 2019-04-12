FROM java:openjdk-8-alpine

COPY --from=builder ./app/target/openshift-hello-world-thorntail.jar ./app.jar

CMD ["/usr/bin/java", "-jar", "app.jar", "-Djava.net.preferIPv4Stack=true", "-Djava.net.preferIPv4Addresses=true"]

