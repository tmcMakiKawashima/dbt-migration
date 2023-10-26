{{ config(materialized="table") }}
with
    temp20_tehai as (
        select
            dlrcd, -- 仕向先CD
            yusokbn, -- 輸送CD
            odrno, -- オーダーNO
            juchuymd, -- 受注日
            jhinban, -- 受注品番
            syubetsu, -- オーダー種別
            shinban tehai_shinban, -- 出荷品番(手配情報対象品番)
            kaknoukbn, -- 格納拠点区分
            jurrsymd, -- 受注リリース日
            srsirskcd, -- 商流仕入先CD
            kozyocd, -- 工場CD
            brsirskcd, -- 物流仕入先CD
            nonukyokbn, -- 納入拠点区分
            ukeirecd, -- 受入CD
            nonyutni, -- 納入単位
            picloke, -- 出庫ロケ
            sykikicd, -- 職域CD
            sksijbsy, -- 出庫指示場所（ラベル出力場所）
            row_number() over (
                partition by dlrcd, yusokbn, odrno, juchuymd, jhinban, syubetsu
                order by daitityp desc, shinban asc, ldts desc
            ) rownum
        from {{ ref("tmp20_dm_tmc_ippan_jutyunokikaito") }}
    )
select *
from temp20_tehai
where rownum = 1
order by dlrcd, yusokbn, odrno, juchuymd, jhinban, syubetsu
