# mysql-phpmyadmin

MySQL, phpMyAdmin and a small PHP page, preloaded with sample databases.

## What runs

| Service | Image | URL |
| --- | --- | --- |
| `www` | `php:apache` (built from `php/Dockerfile`, with `mysqli`) | http://localhost:80 |
| `db` | `mysql:latest` | internal only, port 3306 inside the network |
| `phpmyadmin` | `phpmyadmin/phpmyadmin` | http://localhost:8001 |

## Setup

```bash
cp .env.example .env
docker compose up -d
```

`php/index.php` connects to the `world` database as `root` with the password `root`, so keep `MYSQL_DATABASE=world` and `MYSQL_ROOT_PASSWORD=root` in `.env` (the example file already does). If you use other values, edit the connection details in `php/index.php` to match.

Open http://localhost:8001 for phpMyAdmin (log in as `root`, or as `MYSQL_USER`) and http://localhost for the PHP page.

## Sample databases

Everything in `db/` is mounted into `/docker-entrypoint-initdb.d`, so MySQL loads each `.sql` file the first time it starts with an empty data directory.

| File | Database | Tables |
| --- | --- | --- |
| `world.sql` | `world` | `world_cities`, `world_countries`, `world_currencies`, `world_languages` |
| `school_db.sql` | `school_db` | `Buildings`, `Classrooms`, `College`, `Course`, `Faculty`, `Interns`, `Person`, `Section`, `Student`, `Textbook` |
| `supermarket_salesDB.sql` | `supermarket_salesDB` | `Categories`, `Customers`, `Employees`, `OrderDetails`, `Orders`, `Products`, `Shippers`, `Suppliers` |
| `phpmyadmin.sql` | `phpmyadmin` | phpMyAdmin's own config tables; removes the "advanced features" warning |

Files load in alphabetical order. To add your own dump, give it `CREATE DATABASE IF NOT EXISTS` and `USE` lines near the top. `world.sql` is the exception: it only has `USE world`, which is why `MYSQL_DATABASE` must be `world`.

## The PHP page

`php/index.php` shows the `world_cities` table and has a box where you can type a SQL query. It is a toy: it runs whatever you type with no filtering, and the table rendering assumes the `world_cities` columns. Keep it on your own machine.

## Running SQL from the terminal

```bash
docker compose exec db mysql -u root -p
```

## Resetting

There is no named volume, so removing the containers wipes the data and the SQL files load again on the next start:

```bash
docker compose down
docker compose up -d
```
