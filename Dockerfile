FROM python:3.8-slim


WORKDIR /opt/dagster/app

COPY . /opt/dagster/app

RUN pip install -e .

EXPOSE 4000
