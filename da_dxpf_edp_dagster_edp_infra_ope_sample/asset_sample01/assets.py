import base64
import json
import os
from io import BytesIO

#import matplotlib.pyplot as plt
#import pandas as pd
#import requests
from dagster import AssetExecutionContext, MaterializeResult, MetadataValue, asset

@asset(group_name="asset_sample01")
def asset01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )