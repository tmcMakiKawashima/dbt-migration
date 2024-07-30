locally: manifest
    clear
    dagster dev -m dbt_products.definitions

clean:
    rm -rf ~/.dagster_home; mkdir ~/.dagster_home; cp dagster.yaml ~/.dagster_home/dagster.yaml

manifest:
    dbt parse --project-dir=enterprise_data_products --target dev

deps:
    dbt deps --project-dir=enterprise_data_products

stateful_dev: clean manifest
    export DAGSTER_HOME="~/.dagster_home"; dagster dev -m dbt_products.definitions

stateful_dev_prod: clean manifest
    export DAGSTER_HOME="~/.dagster_home"; export DAGSTER_CLOUD_DEPLOYMENT_NAME="data-eng-prod"; dagster dev -m dbt_products.definitions

dependencies:
    uv pip install -e ".[dev]"