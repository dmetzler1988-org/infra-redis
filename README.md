# Redis

Redis for local Infrastructure to cache various things.

## Installation

### Development only (using docker)

#### Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop) running on Mac, Windows or Linux
- Docker Know-How (recommended)
    - [Official Docker Cheatsheet](https://docs.docker.com/get-started/docker_cheatsheet.pdf)

#### Step-by-step

1. Check out the repository

    ```bash
    git clone git@github.com:dmetzler1988-org/infra-redis.git /path/to/project
    ```

2. Copy the files - Adjust these according to your requirements

    ```bash
    cd /path/to/project
    cp .env.dist .env
    ```

3. Build & run the container

    ```bash
    docker-compose up --build -d --force-recreate
    ```

6. Finish
   
    Open [http://localhost:6379](http://localhost:6379) in your browser. You should see the RabbitMQ login screen.

## Usage

### CLI

Switch into the docker container to interagate with the cli

```
docker exec infra-redis-cache-1 sh
# or
docker exec infra-redis-cache-1 ash
# or directly into redis-cli
docker exec infra-redis-cache-1 redis-cli
```

#### Enter Redis CLI

```bash
redis-cli
```

#### Authentication

**Hints**:
- The default user can be disabled via `redis.conf`.
- ACL users need to be created/edited in `redis.conf`.

##### with default user
```bash
AUTH <password>
AUTH baredfoo
```

##### with ACL
```bash
AUTH <username> <password>
AUTH alice somepassword
```

#### List all available keys

```bash
KEYS *
```

#### Create key with data

```bash
SET <key> <value>
SET MS:CISCO-SMARTLICENSE:ACCESS_TOKEN "abscel41563adsf456as6df165646"
```

#### Get data of a key

```bash
GET <key>
GET MS:CISCO-SMARTLICENSE:ACCESS_TOKEN
```

#### Delete key with data

```bash
DEL <key>
DEL MS:CISCO-SMARTLICENSE:ACCESS_TOKEN
```

## Configurations

A custom configuration can be added into redis.conf, which will be mapped to the redis server.

An example redis configuration file can be found on [redis.io](https://redis.io/docs/management/config-file/).

An example for PROD environments can be found on [linuxhint.com](https://linuxhint.com/modify-redis-configuration-file/).

### Update latest version

Simple check the version on Dockerfile: `rabbitmq:3-management` contains each 3.x.x version of RabbitMQ.

Then create a new release version on GitHub - this will trigger the CD-Pipline which will build the latest image (given from Dockerfile) and push it to DockerHub automatically.

After that, simple restart your Pod.
