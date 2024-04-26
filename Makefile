locally: manifest
    clear
    dagster dev

clean:
    rm -rf ~/.dagster_home; mkdir ~/.dagster_home; cp dagster.yaml ~/.dagster_home/dagster.yaml

manifest:
    dbt parse --project-dir=dagster_dbt --target BRANCH

deps:
    dbt deps --project-dir=dagster_dbt

stateful_dev: clean manifest
    export DAGSTER_HOME="~/.dagster_home"; dagster dev

stateful_dev_prod: clean manifest
    export DAGSTER_HOME="~/.dagster_home"; export DAGSTER_CLOUD_DEPLOYMENT_NAME="data-eng-prod"; dagster dev

dependencies:
    uv pip install -e ".[dev]"