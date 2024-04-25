from dagster_fivetran import FivetranResource, load_assets_from_fivetran_instance

#FivetranResourceを取得する
#api_keyとapi_secretは一時的に直書き
fivetran_instance = FivetranResource(
    api_key="IDbTFbyXa880Q2L0",
    api_secret="Q59BbLofnpyTd4CdLJDhBPhRAabroypP",
)

#Fivetanのコネクタをロードする
fivetran_assets = load_assets_from_fivetran_instance(fivetran_instance)
