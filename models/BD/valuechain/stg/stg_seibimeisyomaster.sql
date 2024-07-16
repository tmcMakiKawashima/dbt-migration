with stg_seibimeisyomaster as (
    select
        rtrim(seibi_cd, ' 　')::varchar(8) as seibi_cd, -- 右blank
        mgr_kbn::varchar(1) as mgr_kbn,
        rtrim(seibi_name, ' 　')::varchar(164) as seibi_name, -- 右blank
        bpseq_no::varchar(7) as bpseq_no,
        hosho_ex_kbn::varchar(1) as hosho_ex_kbn,
        current_timestamp(3)::timestamp_ntz as ldts
    from {{ source('customerservice_db_public', 'raw_seibimeisyomaster') }} -- 整備名称情報マスタ
)
select * from stg_seibimeisyomaster
where ldts = (select max(ldts) from stg_seibimeisyomaster)