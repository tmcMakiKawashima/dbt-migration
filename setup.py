from setuptools import find_packages, setup

setup(
    name="dagster_project1",
    packages=find_packages(exclude=["dagster_project1_tests"]),
    install_requires=[
        "dagster==1.7.0",
        "dagster-cloud==1.7.0"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
