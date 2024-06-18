{{
    config(
        materialized = 'incremental',
        unique_key = ['seibi_cd','mgr_kbn'],
        incremental_strategy = 'merge'
    )
}}

with stg_seibimeisyomaster as (
    select
        rtrim(seibi_cd, ' 　')::varchar(8) as seibi_cd, -- 右blank
        mgr_kbn::varchar(1) as mgr_kbn,
        rtrim(seibi_name, ' 　')::varchar(164) as seibi_name, -- 右blank
        bpseq_no::varchar(7) as bpseq_no,
        hosho_ex_kbn::varchar(1) as hosho_ex_kbn,
        ldts,
        rank() over (partition by seibi_cd, mgr_kbn order by ldts desc) aggkey
    from {{ source('customerservice_db_public', 'stg_seibimeisyomaster') }} -- 整備名称情報マスタ

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}
)

select * from stg_seibimeisyomaster where aggkey = 1