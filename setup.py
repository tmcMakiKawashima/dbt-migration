from setuptools import find_packages, setup

setup(
    name="edp_dagster_sample",
    packages=find_packages(exclude=["edp_dagster_sample_tests"]),
    install_requires=[
        "dagster==1.7.0",
        "dagster-cloud==1.7.0",
        "dagster-dbt==0.23.0",
        "dbt-core==1.7.13",
        "dagster-fivetran==0.23.0",
        "dbt-snowflake==1.7.3"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
