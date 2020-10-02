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

## API Documentation

You can find a postman collection here:
https://www.getpostman.com/collections/fd01b18fb8edeea962d0

Params with a `(*)` are mandatory

### Get all pokemons

```
Method: GET
Url: /api/pokemons
Params:
Returns: Array of pokemons with indetation (see pagination)
```

### Get a pokemon

Replace the `:id` with the pokemon id

```
Method: GET
Url: /api/pokemons/:id
Params:
- id : the pokemon id, type: numeric (*)
Returns: Detail of the pokemon
```

### Create a pokemon

```
Method: POST
Url: /api/pokemons
Params:
- name : name of the pokemon, type: string (*)
- type_1 : first type, type: string (*)
- type_2 : second type, type: string
- total : total points, type: numeric (*)
- hp : total health, type: numeric (*)
- attack : attack points, type: numeric (*)
- defense : defense points, type: numeric (*)
- sp_atk : special attack points, type: numeric (*)
- sp_def : special defense points, type: numeric (*)
- speed : speed points, type: numeric (*)
- generation : generatio number, type: numeric (*)
- legendary : is legendary or not, type: boolean (*)
Returns: Detail of the new created pokemon
```

### Update a pokemon

```
Method: PUT
Url: /api/pokemons/:id
Params:
- id : the pokemon id, type: numeric (*)
- name : name of the pokemon, type: string
- type_1 : first type, type: string
- type_2 : second type, type: string
- total : total points, type: numeric
- hp : total health, type: numeric
- attack : attack points, type: numeric
- defense : defense points, type: numeric
- sp_atk : special attack points, type: numeric
- sp_def : special defense points, type: numeric
- speed : speed points, type: numeric
- generation : generatio number, type: numeric
- legendary : is legendary or not, type: boolean
Returns: Detail of the updated pokemon
```

### Delete a pokemon

```
Method: DELETE
Url: /api/pokemons/:id
Params:
- id : the pokemon id, type: numeric (*)
Returns: HTTP code 200
```

### Pagination

The list of the pokemons are paginated using the param `page`. The response contains an header to navigate through the list:
```
Link: <http://localhost:3000/api/pokemons?page=32>; rel="last", <http://localhost:3000/api/pokemons?page=2>; rel="next"
Per-Page: 25
Total: 800
```

## Tests

You can launch the test suite using rspec:
```
docker-compose run -e "RAILS_ENV=test" --rm app rspec
```
