FROM eclipse-temurin:22.0.2_9-jre-alpine

LABEL authors="Stephan Zerhusen"

# Install needed packages
RUN apk add bash curl tar gzip inotify-tools --no-cache

#Download and extract the API Simulator distribution
RUN cd /
RUN curl -O https://apisimulator.io/downloads/apisimulator-http-1.12-distro.tar.gz
RUN tar -xzf apisimulator-http-1.12-distro.tar.gz
RUN mv /apisimulator/apisimulator-http-1.12 /apisimulator-http
RUN mkdir /simulations
RUN cp /apisimulator-http/examples/hello-world-sim/apisim.yaml /simulations/apisim.yaml
RUN rm -rf /apisimulator
RUN rm -rf /apisimulator-http/examples
RUN rm apisimulator-http-1.12-distro.tar.gz

# Remove unnecessary packages
RUN apk del curl tar gzip

# Copy the start script for the entrypoint
COPY ./startAndWatchSimulation.sh /startAndWatchSimulation.sh
RUN chmod +x /startAndWatchSimulation.sh

# Configure logging
ENV APISIMULATOR_LOG=file
ENV APISIMULATOR_LOG_FILENAME=/apisimulator-http/logs/apisimulator.log

EXPOSE 6090

ENTRYPOINT ["/bin/sh", "-c", "/startAndWatchSimulation.sh"]
