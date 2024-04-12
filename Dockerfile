FROM python:3.10-slim

#RUN mkdir -p /opt/dagster/dagster_home /opt/dagster/app

#RUN pip install dagster-webserver dagster-postgres dagster-aws

#COPY repo.py workspace.yaml /opt/dagster/app/

#ENV DAGSTER_HOME=/opt/dagster/dagster_home/

#COPY dagster.yaml /opt/dagster/dagster_home/

#WORKDIR /opt/dagster/app

#EXPOSE 3000

#ENTRYPOINT ["dagster-webserver", "-h", "0.0.0.0", "-p", "3000"]

WORKDIR /opt/dagster/app

COPY . /opt/dagster/app

RUN pip install dagster-cloud=1.7.0

#RUN pip install --upgrade pip