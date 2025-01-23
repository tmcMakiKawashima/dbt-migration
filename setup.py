from setuptools import find_packages, setup

setup(
    name="dbt_products",
    packages=find_packages(exclude=["dbt_products_tests"]),
    install_requires=[
        "dagster==1.8.7",
        "dagster-cloud==1.8.7",
        "dagster-dbt==0.24.7",
        "dagster-snowflake==0.24.7",
        "pandas==2.2.3",
        # "snowflake-connector-python[pandas]",
        "pyarrow==18.1.0",
        "dbt-core==1.8.6",
        "dagster-fivetran==0.24.7",
        "dbt-snowflake==1.8.3"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
