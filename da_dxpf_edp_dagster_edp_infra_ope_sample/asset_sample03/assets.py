import base64
import json
import os
from io import BytesIO
from pathlib import Path

#import matplotlib.pyplot as plt
#import pandas as pd
#import requests
from dagster import AssetExecutionContext, MaterializeResult, MetadataValue, asset, resource
from dagster_dbt import DbtCliResource, dbt_assets, get_asset_key_for_model

@dbt_assets(manifest=dbt_manifest_path)
def dbt_model_exeute(context: AssetExecutionContext):
    dbt = DbtCliResource(project_dir=os.fspath(dbt_project_dir))
    yield from dbt.cli(["build"], context=context).stream()