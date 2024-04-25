import base64
import json
import os
from io import BytesIO
from pathlib import Path

#import matplotlib.pyplot as plt
#import pandas as pd
#import requests
from dagster import AssetExecutionContext
from dagster_dbt import DbtCliResource, dbt_assets

from .constants import dbt_manifest_path

@dbt_assets(manifest=dbt_manifest_path)
def dbt_model_exeute(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()