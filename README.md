# docker-playground

Docker Compose setups for practicing SQL and data work on your own machine. Nothing to install except Docker, and each setup can be thrown away and rebuilt in a minute.

The three setups are independent. Pick the one you need and run it from its own folder.

| Folder | What you get | Good for |
| --- | --- | --- |
| [`mysql-phpmyadmin/`](mysql-phpmyadmin) | MySQL, phpMyAdmin, a small PHP page, sample databases | Practicing SQL |
| [`pyspark-pgadmin/`](pyspark-pgadmin) | PostgreSQL, pgAdmin (web), Jupyter with PySpark | Trying PySpark against Postgres |
| [`postgres-jupyter/`](postgres-jupyter) | PostgreSQL 17.1 with a persistent volume, Jupyter with PySpark | A longer-lived local dev workspace |

## Requirements

- Docker with the Compose plugin (`docker compose version` should print a version)
- Git

## Quick start

```bash
git clone https://github.com/aimanamri/docker-playground.git
cd docker-playground/mysql-phpmyadmin
cp .env.example .env
docker compose up -d
```

Swap `mysql-phpmyadmin` for another folder to run a different setup. Each folder has a `docker-compose.yml`, so the command is always `docker compose up -d`. Details, URLs and credentials are in each folder's README.

## Ports

| Port | Used by |
| --- | --- |
| 80 | PHP page (`mysql-phpmyadmin`), pgAdmin (`pyspark-pgadmin`) |
| 8001 | phpMyAdmin |
| 5432 | PostgreSQL (`pyspark-pgadmin`) |
| 5433 | PostgreSQL (`postgres-jupyter`) |
| 8888 | Jupyter (`pyspark-pgadmin`) |
| 9999 | Jupyter (`postgres-jupyter`) |

Port 80 is used by two setups, so don't run those two together unless you change one of the ports.

## Project layout

```
.
├── mysql-phpmyadmin/         # MySQL + phpMyAdmin + PHP demo page
│   ├── docker-compose.yml
│   ├── .env.example
│   ├── php/                  # Dockerfile and index.php
│   └── db/                   # SQL files loaded on first start
├── pyspark-pgadmin/          # Postgres + pgAdmin + Jupyter (PySpark)
│   └── docker-compose.yml
└── postgres-jupyter/         # Postgres 17.1 + Jupyter (PySpark), with a volume
    ├── docker-compose.yml
    └── .env.example
```

## Troubleshooting

**Port already in use.** Change the left-hand number in the `ports:` entry (for example `8080:80`) or stop whatever is using the port.

**Sample databases didn't load.** MySQL only runs the files in `db/` when its data directory is empty. Run `docker compose down` then `docker compose up -d`, and check `docker compose logs db` for SQL errors.

**Jupyter asks for a token.** See the folder's README: it is printed by a command in `pyspark-pgadmin` and is `localdevpw` by default in `postgres-jupyter`.

## Security note

This is for local use only. The passwords are simple, some are committed in the compose files, and the PHP page runs whatever SQL you type. Don't put any of it on a public server as it is.

## Feedback

Found a bug or have an idea? [Open an issue](https://github.com/aimanamri/docker-playground/issues/new).
