from setuptools import find_packages, setup

setup(
    name="da_dxpf_edp_dagster_edp_infra_ope_sample",
    packages=find_packages(exclude=["da_dxpf_edp_dagster_edp_infra_ope_sample_tests"]),
    install_requires=[
        "dagster==1.7.0",
        "dagster-cloud==1.7.0",
        "dagster-webserver==1.7.0"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
