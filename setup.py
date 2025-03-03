from setuptools import find_packages, setup

setup(
    name="dbt_products",
    packages=find_packages(exclude=["dbt_products_tests"]),
    install_requires=[
        "dagster==1.9.11",
        "dagster-cloud==1.9.11",
        "dagster-dbt==0.25.11",
        "dagster-snowflake==0.25.11",
        "pandas==2.2.3",
        "pyarrow==19.0.0",
        "dbt-core==1.9.2",
        "dagster-fivetran==0.25.11",
        "dbt-snowflake==1.9.0"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
