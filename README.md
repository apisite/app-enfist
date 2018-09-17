# app-enfist
> Environment File Storage website with API &amp; frontend

[![GitHub Release][gr1]][gr2]
 [![GitHub code size in bytes][sz]]()
 [![GitHub license][gl1]][gl2]

[gr1]: https://img.shields.io/github/release/apisite/app-enfist/all.svg
[gr2]: https://github.com/apisite/app-enfist/releases
[sz]: https://img.shields.io/github/languages/code-size/apisite/app-enfist.svg
[gl1]: https://img.shields.io/github/license/apisite/app-enfist.svg
[gl2]: LICENSE

This application is intended to use within [dcape](https://github.com/dopos/dcape) project as storage for config files with web frontend.
It uses [apisite](https://github.com/apisite/apisite) binary and contains only sql and html/js code.

Also this project may be considered as apisite example application which demonstrates:

* template includes
* API interface & docs
* API calls from templates & javascript

## Installation

This app uses postgresql so you need one of:

* postgresql server
* running postgresql container
* [dcape](https://github.com/dopos/dcape) installed

In the first case you should create db and user by yourself, in others - use `make docker-db-create`

Also this app requires [apisite](https://github.com/apisite/apisite) binary which you can get by the following ways:

* make from sources (see install teps [here](https://github.com/apisite/apisite/blob/master/Dockerfile))
* use apisite/apisite docker image
* use apisite/enfist docker image (includes app-enfist sources and all dependensies)

All cases except last require app-enfist sources which might be fetched via git:

```
git clone --depth=1 --recursive https://github.com/apisite/app-enfist.git
cd app-enfist
```

To create default config file (named .env) use
```
make config
```

If dcape used, set `PGHOST=db` and `API_SITE=your.hostname` in this file


Create db and user when postgresql runned in docker container:
```
make docker-db-create
```

Install app-enfist from sources:
```
make poma-install
```

Install app-enfist from apisite/enfist docker image:
```
docker run enfist make poma-install
```

## Usage

### Locally

```
make deps-local
make run-local
```

### Via dcape

```
make up
```

### Via docker

See docker-compose.yml

### Prepare docker image for remote dcape server

```
make build-dist
```

## TODO

* [ ] set/get index form fields via cookies
* [ ] solve `<nil>` output in templates


## License

The MIT License (MIT), see [LICENSE](LICENSE).

Copyright (c) 2018 Aleksei Kovrizhkin <lekovr+apisite@gmail.com>

