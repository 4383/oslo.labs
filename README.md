# oslo.cache labs
Samples for the oslo.cache Backend

## Usage

### `memcache_pool` backend lab

```sh
$ git clone git@github.com:4383/oslo.cache-labs.git
$ cd oslo.cache-labs
$ cd labs/memcache_pool_backend
$ # docker compose is adapted to my laptop env
$ # if you want to run it on your env you need to mount the
$ # right volumes first
$ docker-compose -f docker-compose-dev.yml build
$ docker-compose -f docker-compose-dev.yml up -d
$ docker exec -it oslo-cache /bin/zsh
lab $ python lab/app.py
lab $ ls ~/debug # here are all the libs you may want to modify for your tests
```
