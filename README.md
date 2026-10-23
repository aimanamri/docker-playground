# docker-playground

A small collection of Docker Compose setups for practicing SQL and data work on your own machine. No installs beyond Docker, and everything can be thrown away and rebuilt in a minute.

There are three separate setups in here. They don't depend on each other, so pick the one that matches what you want to do.

| Folder | What you get | Good for |
| --- | --- | --- |
| [`/`](#1-mysql--phpmyadmin--php-demo-page) (root) | MySQL, phpMyAdmin, a small PHP page | Practicing SQL on sample databases |
| [`pyspark-de/`](#2-pyspark--postgresql--pgadmin-pyspark-de) | PostgreSQL, pgAdmin (web), Jupyter with PySpark | Trying PySpark against Postgres |
| [`data_workspace_dev/`](#3-postgresql--jupyter-data_workspace_dev) | PostgreSQL 17.1 with a persistent volume, Jupyter with PySpark | A longer-lived local dev workspace |

## Requirements

- Docker with the Compose plugin (`docker compose version` should print something)
- Git

The commands below use `docker compose`. If you're on the older standalone binary, swap in `docker-compose`.

## Getting started

```bash
git clone https://github.com/aimanamri/docker-playground.git
cd docker-playground
```

---

## 1. MySQL + phpMyAdmin + PHP demo page

This is the setup in the project root.

### What runs

| Service | Image | URL |
| --- | --- | --- |
| `www` | `php:apache` (built from `php/Dockerfile`, with `mysqli`) | http://localhost:80 |
| `db` | `mysql:latest` | internal only, port 3306 inside the network |
| `phpmyadmin` | `phpmyadmin/phpmyadmin` | http://localhost:8001 |

### Setup

Copy the example env file and fill it in:

```bash
cp .env.example .env
```

```
MYSQL_DATABASE=world
MYSQL_ROOT_PASSWORD=root
MYSQL_USER=new_user
MYSQL_PASSWORD=user_password
```

Two of those values are not really up to you if you want the demo page to work. `php/index.php` connects to the `world` database as `root` with the password `root`, so keep `MYSQL_DATABASE=world` and `MYSQL_ROOT_PASSWORD=root`. If you'd rather use other values, edit the connection details in `php/index.php` to match.

Then start everything:

```bash
docker compose up -d
```

Open http://localhost:8001 for phpMyAdmin (log in as `root` with your root password, or as the user you set) and http://localhost for the PHP page.

### The sample databases

Everything in `db/` is mounted into `/docker-entrypoint-initdb.d`, so MySQL loads each `.sql` file the first time the container starts with an empty data directory.

| File | Database | Tables |
| --- | --- | --- |
| `world.sql` | `world` | `world_cities`, `world_countries`, `world_currencies`, `world_languages` |
| `school_db.sql` | `school_db` | `Buildings`, `Classrooms`, `College`, `Course`, `Faculty`, `Interns`, `Person`, `Section`, `Student`, `Textbook` |
| `supermarket_salesDB.sql` | `supermarket_salesDB` | `Categories`, `Customers`, `Employees`, `OrderDetails`, `Orders`, `Products`, `Shippers`, `Suppliers` |
| `phpmyadmin.sql` | `phpmyadmin` | phpMyAdmin's own config tables. Loading it removes the "advanced features" warning in the UI |

Files load in alphabetical order. If you add your own dump, make sure it has `CREATE DATABASE IF NOT EXISTS` and `USE` lines near the top, like the existing ones do. `world.sql` is the exception: it only has `USE world`, which is why `MYSQL_DATABASE` needs to be `world`.

### The PHP page

`php/index.php` shows the `world_cities` table and has a text box where you can type your own SQL query and see the result. It is a toy. It runs whatever you type with no filtering, and the table rendering assumes the `world_cities` columns, so queries on other tables will return rows it can't display properly. Don't expose it beyond your own machine.

### Running SQL from the terminal

```bash
docker compose exec db mysql -u root -p
```

Or open a shell in the container:

```bash
docker compose exec db bash
```

### Resetting

The MySQL container has no named volume, so removing it wipes the data and the SQL files are loaded again on the next start:

```bash
docker compose down
docker compose up -d
```

---

## 2. PySpark + PostgreSQL + pgAdmin (`pyspark-de/`)

```bash
cd pyspark-de
docker compose -f de_env_setup.yaml up -d
```

| Service | URL / port | Notes |
| --- | --- | --- |
| pgAdmin 4 | http://localhost:80 | Login email and password are set in `de_env_setup.yaml` |
| Jupyter (PySpark) | http://localhost:8888 | Needs a token, see below |
| PostgreSQL | localhost:5432 | User and password are set in `de_env_setup.yaml` |

Port 80 is shared with the PHP page from setup 1, so don't run both at once without changing a port.

### Getting the Jupyter token

```bash
docker exec -it notebook jupyter server list
```

Copy the token from the URL it prints and paste it in at http://localhost:8888.

### Notes

- Notebooks are saved in `pyspark-de/notebook/`, which maps to `/home/jovyan/work` in the container.
- Postgres has no volume here, so the data disappears when the container is removed.
- The credentials in `de_env_setup.yaml` are placeholders. Change them before using this for anything real.

---

## 3. PostgreSQL + Jupyter (`data_workspace_dev/`)

A tidier version of the same idea, with a persistent database volume.

```bash
cd data_workspace_dev
docker compose -f local-dev-setup.yaml up -d
```

| Service | URL / port | Credentials |
| --- | --- | --- |
| PostgreSQL 17.1 | `localhost:5433` | database `db`, user `user`, password `localdevpw` |
| Jupyter (PySpark) | http://localhost:9999 | token `localdevpw` |

Postgres is mapped to 5433 on the host so it doesn't clash with a Postgres you may already have on 5432.

### Connecting from a desktop client

Point pgAdmin (desktop), DBeaver or similar at:

- Host: `localhost`
- Port: `5433`
- Database: `db`
- Username: `user`
- Password: `localdevpw`

### Connecting from a notebook

The image ships with pandas, numpy, scipy, matplotlib and requests. For Postgres you need a driver, so run this in a notebook cell first:

```python
%pip install "psycopg[binary]"
```

Then something like:

```python
import psycopg

with psycopg.connect("host=pg-database port=5432 dbname=db user=user password=localdevpw") as conn:
    print(conn.execute("select version()").fetchone())
```

From inside the Jupyter container, use the service name `pg-database` and port `5432`. From your own machine, use `localhost` and `5433`.

### Changing the credentials

The values are currently hardcoded in `local-dev-setup.yaml`. Change them there (the database name appears again in the healthcheck). `.env.example` lists the same four variables, but the compose file doesn't read a `.env` file yet.

### Resetting

Stop the containers but keep the data:

```bash
docker compose -f local-dev-setup.yaml down
```

Stop and delete the database volume too:

```bash
docker compose -f local-dev-setup.yaml down -v
```

---

## Project layout

```
.
├── docker-compose.yml        # MySQL + phpMyAdmin + PHP
├── .env.example
├── php/
│   ├── Dockerfile
│   └── index.php
├── db/                       # SQL files loaded on first start
│   ├── world.sql
│   ├── school_db.sql
│   ├── supermarket_salesDB.sql
│   └── phpmyadmin.sql
├── pyspark-de/               # Postgres + pgAdmin + Jupyter
│   └── de_env_setup.yaml
└── data_workspace_dev/       # Postgres 17.1 + Jupyter, with a volume
    ├── local-dev-setup.yaml
    └── .env.example
```

## Troubleshooting

**Port already in use.** Change the left-hand number in the `ports:` entry (for example `8080:80`) or stop whatever is using the port.

**The sample databases didn't load.** MySQL only runs the files in `db/` when its data directory is empty. Run `docker compose down` and `docker compose up -d` again. Check `docker compose logs db` for SQL errors.

**The PHP page shows a connection error.** The database is probably still starting. Give it 20 to 30 seconds on first run, then refresh. Also check that your `.env` matches what `index.php` expects (see setup 1).

**Jupyter asks for a token.** In setup 2, use the `jupyter server list` command above. In setup 3, the token is `localdevpw` unless you changed it.

## Security note

All of this is meant for local use. The passwords are simple, several are committed in the compose files, and the PHP page runs arbitrary SQL. Don't put any of it on a public server as it is.

## Feedback

Found a bug or have an idea? [Open an issue](https://github.com/aimanamri/docker-playground/issues/new).
