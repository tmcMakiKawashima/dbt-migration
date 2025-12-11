with stg_syasyu_aisac_tmc as (
    select
        syasyu::varchar(4) as syasyu, --車種ユニットコード
        sigokbn::varchar(2) as sigokbn, --試作号口区分
        unitkbn::varchar(2) as unitkbn, --車両/ﾕﾆｯﾄ区分
        tantogaisya::varchar(2) as tantogaisya, --担当会社区分
        syukan::varchar(2) as syukan, --主管会社
        haisitime::varchar(16) as haisitime --車種廃止日時
    from {{ ref('stg_syasyu') }}
    where tantogaisya = '01'
)
select * from stg_syasyu_aisac_tmc