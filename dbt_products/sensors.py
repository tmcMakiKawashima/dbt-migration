"""
To add a sensors that materializes your dbt assets, uncomment the following lines.
"""

""" D """
""" api """
from .sensors_items.dd.sensors_sms_api import dd_sms_api_parts_info_sensor



sensors = []

""" D層作成ジョブ """
""" api """
sensors.append(dd_sms_api_parts_info_sensor)