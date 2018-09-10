# app-enfist
> Environment File Storage website with API &amp; frontend

[![GoCard][gc1]][gc2]
 [![GitHub Release][gr1]][gr2]
 [![GitHub code size in bytes][sz]]()
 [![GitHub license][gl1]][gl2]

[gc1]: https://goreportcard.com/badge/apisite/app-enfist
[gc2]: https://goreportcard.com/report/github.com/apisite/app-enfist
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
[edit .env, changу API_SITE]
make poma-install
make poma-create
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

