
# PySpark Notebook with PosgreSQL + PGAdmin
A simple project on how to set up PySpark with Jupyter notebook. Also, we will be using PosgreSQL server as database and PGAdmin for the interface.

<p align="center">
  <a href="https://github.com/aimanamri/docker-playground">
    <img alt="GitHub Language Count" src="https://img.shields.io/github/languages/count/aimanamri/docker-playground">
  </a>

  <a href="https://github.com/aimanamri/docker-playground">
    <img alt="GitHub Top Language" src="https://img.shields.io/github/languages/top/aimanamri/docker-playground">
  </a>
  
  <a href="https://github.com/aimanamri/docker-playground/stargazers">
    <img alt="GitHub Stars" src="https://img.shields.io/github/stars/aimanamri/docker-playground?style=social">
  </a>

  <a href="https://github.com/aimanamri/docker-playground/commits/main">
    <img alt="GitHub Last Commit" src="https://img.shields.io/github/last-commit/aimanamri/docker-playground">
  </a>

  <a href="https://github.com/aimanamri/docker-playground">
    <img alt="Repository Size" src="https://img.shields.io/github/repo-size/aimanamri/docker-playground">
  </a>
</p>




## Run Locally

Clone the project

```bash
  git clone https://github.com/aimanamri/docker-playground.git
```

Go to the project directory

```bash
  cd docker-playground/pyspark-de
```
Start the server using Docker

```bash
  docker-compose -f de_env_setup.yaml up -d
```
This project will run on `localhost:80` for PGAdmin and `localhost:8888` for Jupyter notebook.

## Getting token to login into Jupyter notebook
```bash
   docker exec -it notebook sh
```
Then, run following to get token for Jupyter and copy the token into http://localhost:8888.
```bash
jupyter server list
```

## Tech Stack

**Client::** pgadmin

**Coding:** Jupyter notebook with PySpark installed

**Server:** posgresql


## Feedback

If you have any feedback, please open new issue [here](https://github.com/aimanamri/docker-playground/issues/new).

