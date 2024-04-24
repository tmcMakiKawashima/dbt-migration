import base64
import json
import os
from io import BytesIO
from pathlib import Path

#import matplotlib.pyplot as plt
#import pandas as pd
#import requests
from dagster import MaterializeResult, MetadataValue, asset

@asset(group_name="asset_sample01", description="dagster独自アセット及びマテリアライズ結果をリネージュとして反映するサンプル")
def asset01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )