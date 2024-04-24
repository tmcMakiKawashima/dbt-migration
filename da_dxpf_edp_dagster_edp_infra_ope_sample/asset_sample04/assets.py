import base64
import json
import os
from io import BytesIO
from pathlib import Path

#import matplotlib.pyplot as plt
#import pandas as pd
#import requests
from dagster import MaterializeResult, MetadataValue, asset

# アセット定義
@asset(group_name="asset_sample04", description="センサー実行サンプル用1")
def asset04_01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(group_name="asset_sample04", deps=[asset04_01], description="センサー実行サンプル用2")
def asset04_02() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )
