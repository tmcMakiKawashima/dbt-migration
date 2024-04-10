from setuptools import find_packages, setup

setup(
    name="da_dxpf_edp_dagster_edp_infra_ope_sample",
    packages=find_packages(exclude=["da_dxpf_edp_dagster_edp_infra_ope_sample_tests"]),
    install_requires=[
        "dagster",
        "dagster-cloud"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
