# app-enfist
> Environment File Storage website with API &amp; frontend

[![GitHub Release][gr1]][gr2]
 [![GitHub code size in bytes][sz]]()
 [![GitHub license][gl1]][gl2]

[gr1]: https://img.shields.io/github/release/apisite/app-enfist.svg
[gr2]: https://github.com/apisite/app-enfist/releases
[sz]: https://img.shields.io/github/languages/code-size/apisite/app-enfist.svg
[gl1]: https://img.shields.io/github/license/apisite/app-enfist.svg
[gl2]: LICENSE

## Install

```
git clone --depth=1 --recursive https://github.com/apisite/app-enfist.git
cd app-enfist
make config
# [edit .env: set PGHOST=db and API_SITE]
make docker-db-create
make build-docker
make docker-install-poma
make -s dc CMD="run cmd make poma-create"
make up
```

## Update from pgrpc version

```
insert into pers.enfist_tag select * from env.tag;
```

## TODO

* [ ] set/get index form fields via cookies
* [ ] solve `<nil>` output in templates


## License

The MIT License (MIT), see [LICENSE](LICENSE).

Copyright (c) 2018 Aleksei Kovrizhkin <lekovr+apisite@gmail.com>

