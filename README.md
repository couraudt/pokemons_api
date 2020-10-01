# Pokemon API

## Installation

### Prerequisites

Install Docker and [Docker Compose](https://docs.docker.com/compose/install/)

### Build docker app

```bash
docker-compose build
```

### Migration

```bash
docker-compose exec app rake db:migrate
```

### Import csv into db

```bash
docker-compose exec app rake db:seed
```

## Start web server

```bash
docker-compose up
```
