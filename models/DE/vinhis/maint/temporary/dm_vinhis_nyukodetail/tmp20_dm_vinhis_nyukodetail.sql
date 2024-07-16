with
    tmp10 as (
        select * from {{ ref('tmp10_dm_vinhis_nyukodetail') }}
    ),
    codekubun as (
        select
            key, -- 入庫区分
            value -- 入庫区分名
        from {{ ref('stg_codekubun') }} -- コード区分マスタ
        where codekbnid = '028'
    )
select
    tmp10.*,
    codekubun.* exclude (key)
from tmp10
left outer join codekubun
  on tmp10.nyukokbn = codekubun.key
