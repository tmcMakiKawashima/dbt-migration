""" dbt """
from .enterprise_data_products_assets.assets import dbt_products_assets
""" api """
from .api_assets.assets_sms import sms_api_parts_info_asset


assets = []

""" dbt """
assets.append(dbt_products_assets)
""" api """
# SMS API（品番情報）アセット
assets.append(sms_api_parts_info_asset)
