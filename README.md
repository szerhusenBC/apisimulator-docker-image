# apisimulator-docker-image

Custom docker image for API Simulator that is a configuration-driven tool for creating and running API simulations. The image is based on the
[API Simulator for Easy and Realistic API Simulations](https://apisimulator.io/). There is also an
[official Docker image](https://hub.docker.com/r/apimastery/apisimulator) available, but
[this image](https://hub.docker.com/repository/docker/szerhusenbc/apisimulator/general) is much smaller and supports real time reloading when API configuration
files are changed.

## Usage

You can run the docker image with the following command

```bash
docker run -d -p 6090:6090 --name apisimulator szerhusenbc/apisimulator:latest
```

or using Docker compose

```yaml
version: '3.8'
services:
  apisimulator:
    image: szerhusenbc/apisimulator:latest
    container_name: apisimulator
    ports:
      - "6090:6090"
```

The API Simulator is now available and contains example simulations:

* Hello World: http://localhost:6090
* Greeting with path parameter: http://localhost:6090/greetings/John
* Greeting with query parameter: http://localhost:6090/hi or http://localhost:6090/hi?name=John
* Greeting with random phrase: http://localhost:6090/hey

### Custom simulations

It is possible to mount a directory with custom simulations to the docker container:

```bash
docker run -d -p 6090:6090 -v /path/to/my/simulations:/simulations --name apisimulator szerhusenbc/apisimulator:latest
```

or using Docker compose

```yaml
version: '3.8'
services:
  apisimulator:
    image: szerhusenbc/apisimulator:latest
    container_name: apisimulator
    ports:
      - "6090:6090"
    volumes:
      - type: bind
        source: /path/to/my/simulations
        target: /simulations
```

Now the API Simulator is available with the custom simulations. **Everytime a file in the simulations directory is changed, the API Simulator will restart
internally with the new configurations.**

You can also mount out the logs directory to get access to the logs. You have to mount the path `/apisimulator-http/logs/` to a directory on your host system.

### Documentation

The official API Simulator documentation is available at https://apisimulator.io/docs/index.html.

## Makefile

The Makefile provides different targets for building and running the docker image. By running `make` or `make help`, the available targets are shown.
