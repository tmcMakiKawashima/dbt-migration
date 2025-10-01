FROM python:3.11-slim


WORKDIR /opt/dagster/app

COPY . /opt/dagster/app

RUN pip install -e .

RUN dagster-dbt project prepare-and-package --file /opt/dagster/app/project.py

EXPOSE 4000
