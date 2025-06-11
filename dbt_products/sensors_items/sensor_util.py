import os


tags_base = {"ecs/cpu": "256", "ecs/memory": "1024"}
# sensorのポーリングインターバル
mini_interval_sec = int(os.getenv('SENSOR_MINI_INTERVAL_SEC'))
# code location name
loc_name = "dbt_products.definitions"