# Pokemon API

## Installation

### Prerequisites

Install Docker and [Docker Compose](https://docs.docker.com/compose/install/)

### Build docker app

```bash
docker-compose build
```

### Start web server

```bash
docker-compose up -d
```

### Migration

```bash
docker-compose exec app bundle exec rake db:migrate
```

### Import csv into db

```bash
docker-compose exec app bundle exec rake db:seed
```

