# postgres-jupyter

PostgreSQL 17.1 with a persistent volume, plus a Jupyter notebook with PySpark.

## Run

```bash
cp .env.example .env   # optional, defaults are the same values
docker compose up -d
```

| Service | URL / port | Credentials |
| --- | --- | --- |
| PostgreSQL 17.1 | `localhost:5433` | database `db`, user `user`, password `localdevpw` |
| Jupyter (PySpark) | http://localhost:9999 | token `localdevpw` |

Postgres is on 5433 on the host so it doesn't clash with a Postgres you may already have on 5432.

## Changing the credentials

Set `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD` and `JUPYTER_TOKEN` in `.env`. Without a `.env`, the defaults above are used. Postgres only reads these when the volume is first created, so run `docker compose down -v` first if you change them on an existing setup.

## Connecting from a desktop client

Point pgAdmin (desktop), DBeaver or similar at host `localhost`, port `5433`, with the database, user and password above.

## Connecting from a notebook

The image ships with pandas, numpy, scipy, matplotlib and requests. For Postgres, install a driver in a notebook cell:

```python
%pip install "psycopg[binary]"
```

```python
import psycopg

with psycopg.connect("host=pg-database port=5432 dbname=db user=user password=localdevpw") as conn:
    print(conn.execute("select version()").fetchone())
```

Inside the Jupyter container use the service name `pg-database` and port `5432`. From your own machine use `localhost` and `5433`.

## Stopping

Keep the data:

```bash
docker compose down
```

Delete the database volume too:

```bash
docker compose down -v
```
