with
    temp40 as (select * from {{ ref('tmp40_dm_hosyuhin_tmp_juhattyuuriage') }}),
    atopjuchu as (select * from {{ ref('stg_o_cvs11jyuchuu') }}),
    hinban as (select * from {{ ref('stg_dm_pno') }}),
    tasshimuke as (select * from {{ ref('stg_tbsmksk') }}),
    -- 納期仕向
    tasshimuke_noki as (
        select * from {{ ref("scd_tbsmksk_noki") }} where deletedate = '00000000'
    ),
    --
    atopshimuke as (select * from {{ ref('stg_dvnp054a') }}),
    tbuserm as (select * from {{ ref('stg_tbuserm') }})
select
    temp40.* exclude (check1_kyouhan, check2_kyouhan, check3_kyouhan, check4_kyouhan),
    tbuserm.hanbaiten,
    tbuserm.kjusrnm,
    atopjuchu.tkskbn,
    atopshimuke.smkmeijpjh,
    atopshimuke.smkmeijpjs,
    hinban.pname,
    -- 納期仕向
    case
        when
            (
                (   -- 注文No上１桁が’P'または’Q'
                    substr(temp40.chumon, 1, 1) in ('P', 'Q') 
                    -- かつ納期仕向先テーブルが結合されている
                    and noki.kyouhan is not null
                    -- かつオーダー種別が’11’
                    and temp40.odrsbetu = '11' 
                    -- かつ納期仕向先テーブルの引当・在補区分が’1’または’3’
                    and noki.hikizaikbn in ('1','3')
                )
                or 
                (   -- 注文No上１桁が’P'または’Q'
                    substr(temp40.chumon, 1, 1) in ('P', 'Q')
                    -- かつ納期仕向先テーブルが結合されている
                    and noki.kyouhan is not null
                    -- オーダー種別が’12’
                    and temp40.odrsbetu = '12' 
                    -- かつ納期仕向先テーブルの引当・在補区分が’2’または’3’
                    and noki.hikizaikbn in ('2', '3')
                )
            )
        then iff(noki.nokismkskcd is null, '', noki.nokismkskcd) -- 納期仕向先テーブル.納期仕向先コード
        else iff(tasshimuke.sishacd is null, '', tasshimuke.sishacd) -- 仕向先テーブル.支社コード
    end as sishacd,
    atopjuchu.jhinban as check_jhinban, -- 受注品番 nullチェック用
    hinban.pno as check_pno, -- 品番 nullチェック用
    tasshimuke.kyouhan as check1_kyouhan, -- 共販店コード１ nullチェック用
    atopshimuke.dlrcd as check_dlrcd, -- 仕向先CD nullチェック用
    tbuserm.kyouhan as check2_kyouhan -- 共販店コード２ nullチェック用
    --
from temp40
    left outer join atopjuchu
        on temp40.hinban = atopjuchu.jhinban
    left outer join hinban
        on temp40.hinban = hinban.pno
    left outer join tasshimuke
        on temp40.kyouhan = tasshimuke.kyouhan
        and temp40.nyukkten = tasshimuke.kyoten
    left outer join atopshimuke
        on concat(
            tasshimuke.kyouhan, tasshimuke.sishacd
        ) = atopshimuke.dlrcd
    left outer join tbuserm
        on temp40.kyouhan = tbuserm.kyouhan
        and temp40.usercd = tbuserm.usrcod
    -- 納期仕向
    left outer join
        tasshimuke_noki noki
        on temp40.kyouhan = noki.kyouhan
        and temp40.nyukkten = noki.nyukkten
        and temp40.makercd = noki.makercd
        and iff(temp40.makercd = '70000', temp40.ktenkbn, '') 
            = noki.ktenkbn -- 拠点区分
        -- dbt_valid_from <= 発注日 < dbt_valid_to
        and try_to_date(temp40.chuzan_hachuymd, 'yyyyMMdd') >= to_date(noki.dbt_valid_from)
        and try_to_date(temp40.chuzan_hachuymd, 'yyyyMMdd') < 
            iff(noki.dbt_valid_to is null, '9999-12-31', to_date(noki.dbt_valid_to))
    --
