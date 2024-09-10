with
    tmp10 as (
        select * from {{ ref('tmp10_dm_vinhis_goyomei') }}
    ),
    goyoumeihosyo as (
        select
            nyukono, -- 入庫番号
            meisaino, -- 明細行番号
            sainyukoymd, -- 再入庫予定日
            tyoushiukagaikekkacd, -- 調子伺い結果コード
            genincd, -- 原因コード
            hosyokbn, -- 保証区分
            hosyoseikyusyono, -- 保証請求書No
            huguaisaigenumu, -- 不具合再現有無
            geninmeisyo -- 原因名称
        from {{ ref('stg_goyoumeihosyo') }} -- ご用命保証
        where delflg = '0'
    )
select
    tmp10.*,
    goyoumeihosyo.* exclude (nyukono,meisaino)
from tmp10
left outer join goyoumeihosyo
on tmp10.nyuko_no = goyoumeihosyo.nyukono
and tmp10.meisaino = goyoumeihosyo.meisaino