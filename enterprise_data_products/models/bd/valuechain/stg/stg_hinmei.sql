{{
    config (
        post_hook=
            'create or replace hybrid table valuechain_db.public.stg_hinmei (
                 langkbn varchar(3) not null,
                 pnc varchar(6) not null,
                 hinmei varchar(240),
                 ldts timestamp_ntz(9),
                 constraint stg_hinmei_langkbn_pnc_uk primary key (langkbn, pnc) rely 
            ) as select * from {{this}}'
    )
}}
-- ハイブリッドテーブルに変更

with stg_hinmei as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(langkbn,' 　')::varchar(3) as langkbn, -- 右blank
        rtrim(pnc,' 　')::varchar(6) as pnc, -- 右blank
        rtrim(hinmei,' 　')::varchar(240) as hinmei, -- 右blank 全角文字を含む
        ldts, --B層取込日時
        line_number,
        rank() over (partition by langkbn, pnc order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_dv2a4703') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_hinmei
where aggkey = 1 and mntkbn in ('C', 'U')