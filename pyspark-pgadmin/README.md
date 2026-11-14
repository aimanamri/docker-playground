# pyspark-pgadmin

PostgreSQL, pgAdmin (web) and a Jupyter notebook with PySpark.

## Run

```bash
docker compose up -d
```

| Service | URL / port | Notes |
| --- | --- | --- |
| pgAdmin 4 | http://localhost:80 | Login email and password are set in `docker-compose.yml` |
| Jupyter (PySpark) | http://localhost:8888 | Needs a token, see below |
| PostgreSQL | localhost:5432 | User and password are set in `docker-compose.yml` |

Port 80 is also used by `mysql-phpmyadmin`, so don't run both at once without changing a port.

## Jupyter token

```bash
docker exec -it notebook jupyter server list
```

Copy the token from the URL it prints and paste it in at http://localhost:8888.

## Notes

- Notebooks are saved in `notebook/`, which maps to `/home/jovyan/work` in the container.
- pgAdmin's settings are kept in `pgadmin-data/`.
- Postgres has no volume, so its data is lost when the container is removed.
- The credentials in `docker-compose.yml` are placeholders. Change them before using this for anything real.
