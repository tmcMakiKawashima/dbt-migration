from setuptools import find_packages, setup

setup(
    name="da_dxpf_edp_dagster_edp_infra_ope_sample",
    packages=find_packages(exclude=["da_dxpf_edp_dagster_edp_infra_ope_sample_tests"]),
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
