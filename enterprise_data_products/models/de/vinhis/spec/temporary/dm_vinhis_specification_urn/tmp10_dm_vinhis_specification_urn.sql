with mss as (   -- 抽出結果_最大MT日時車種
    select
        sno,                    -- 仕様書NO
        syasyu,                 -- 車種コード
        row_number() over(
            partition by sno
            order by mtdate desc
        ) as rnk                -- ランク
    from {{source('supplydemand_db_public','raw_stg_syasyu_siyousho')}}
{% raw %}
    --from {{ref('stg_syasyu_siyousho')}}
{% endraw %}
), ssua as (    -- 車両仕様UNION_ALL結果
    select
        urn,                    -- URN
        dfsc,                   -- DFSC/EDNO
        sno,                    -- 仕様書NO
        ctlkata,                -- コントロール型式
        carname,                -- 車名
        figure,                 -- 荷姿
        unittype,               -- ユニット区分
        equipmentline,          -- 架装ライン
        scndasmvtp,             -- 架装車両区分
        lodate,                 -- ラインオフ計画日
        offopttype,             -- オフOPT区分
        importduty,             -- 再輸出区分
        discsign,               -- 識別記号
        ordcycl,                -- オーダーサイクル
        odrtype,                -- オーダータイプ
        vehcategorycode,        -- 車両識別コード
        carfamily,              -- 車種コード
        spec,                   -- SPEC200桁組合せ
        intcode,                -- 内張コード
        extcode,                -- 外鈑色コード
        destcode,               -- 仕向地コード
        pscexlk,                -- PSC
        plantcode,              -- 工場コード
        idline                  -- アイデントライン
    from {{source('supplydemand_db_public','raw_stg_union_all_vehicle_specification_alc')}}
{% raw %}
    --from {{ref('stg_union_all_vehicle_specification_alc')}}
{% endraw %}
)
select
    coalesce(nullif(ssua.carfamily , ''), mss.syasyu) as syasyu,    -- 車種コード
    ssua.* exclude(carfamily)                                       -- 車種を除いたssuaの項目
from ssua       -- 車両仕様UNION_ALL結果
left join mss   -- 抽出結果_最大MT日時車種
on (
    ssua.sno = mss.sno
    and mss.rnk = 1
)