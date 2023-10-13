{{ config(materialized="table") }}
with
    temp10 as (
        select
            -- オーダー情報ファイル
            dlrcd,
            yusokbn,
            odrno,
            juchuymd,
            jhinban,
            syubetsu,
            listagg(ordrkey) ordrkeys,
            sum(juchusu) juchusu,
            max(rimak1) rimak1,
            max(rimak2) rimak2,
            -- 納指オーダー情報
            max(iff(hnskiboymd is null, '', hnskiboymd)) hnskiboymd,
            max(iff(hoskiboymd is null, '', hoskiboymd)) hoskiboymd,
            max(iff(hsskiboymd is null, '', hsskiboymd)) hsskiboymd,
            sum(iff(skibohenkokaisu is null, '0', skibohenkokaisu)) skibohenkokaisu,
            max(iff(hnhonyoyakuymd is null, '', hnhonyoyakuymd)) hnhonyoyakuymd,
            max(iff(hshonyoyakuymd is null, '', hshonyoyakuymd)) hshonyoyakuymd,
            max(iff(hnnksyytime is null, '', hnnksyytime)) hnnksyytime,
            max(iff(honksyytime is null, '', honksyytime)) honksyytime,
            max(iff(hsnksyytime is null, '', hsnksyytime)) hsnksyytime,
            sum(iff(allnosicansu is null, '0', allnosicansu)) allnosicansu,
            sum(iff(hnnosicansu is null, '0', hnnosicansu)) hnnosicansu,
            max(iff(hnnosicantime is null, '', hnnosicantime)) hnnosicantime,
            max(iff(honosicantime is null, '', honosicantime)) honosicantime,
            max(iff(hsnosicantime is null, '', hsnosicantime)) hsnosicantime,
            sum(iff(nosicankaisu is null, '0', nosicankaisu)) nosicankaisu,
            max(iff(iphonyoyakuymd is null, '', iphonyoyakuymd)) iphonyoyakuymd,
            max(iff(kariyoyakuymd is null, '', kariyoyakuymd)) kariyoyakuymd,
            max(iff(hnnosikbn is null, '', hnnosikbn)) hnnosikbn,
            max(iff(hsnosikbn is null, '', hsnosikbn)) hsnosikbn,
            max(iff(honosikbn is null, '', honosikbn)) honosikbn,
            -- BO納期回答
            max(iff(hnnoytime is null, '', hnnoytime)) hnnoytime,
            max(iff(hnsyytime is null, '', hnsyytime)) hnsyytime,
            max(iff(hntoytime is null, '', hntoytime)) hntoytime,
            max(iff(hsnoytime is null, '', hsnoytime)) hsnoytime,
            max(iff(hssyytime is null, '', hssyytime)) hssyytime,
            max(iff(ptopflg is null, '', ptopflg)) ptopflg,
            max(iff(hskkbn is null, '', hskkbn)) hskkbn,
            max(iff(hstaytime is null, '', hstaytime)) hstaytime,
            max(iff(hstoytime is null, '', hstoytime)) hstoytime,
            max(iff(hokkbn is null, '', hokkbn)) hokkbn,
            max(iff(honoytime is null, '', honoytime)) honoytime,
            max(iff(hotaytime is null, '', hotaytime)) hotaytime,
            max(iff(hosyytime is null, '', hosyytime)) hosyytime,
            max(iff(hotoytime is null, '', hotoytime)) hotoytime,
            max(iff(mkaitocd is null, '', mkaitocd)) mkaitocd,
            max(iff(hnkkbn is null, '', hnkkbn)) hnkkbn,
            max(iff(hntaytime is null, '', hntaytime)) hntaytime,
            max(iff(ipsyytmie is null, '', ipsyytmie)) ipsyytmie,
            -- BO納期管理資料
            max(iff(martflg is null, '', martflg)) martflg
        from {{ ref("tmp10_DM_TMC_IPPAN_JUTYUNOKIKAITO") }}
        group by all
    ),
    odr_shiji_status as (
        select
            ordrkey,
            juchuymd,
            --
            shinban,
            iff(bosu = '', '0', bosu) bosu,
            boskstime,
            kaknoukbn,
            pendid,
            iff(pensu = '', '0', pensu) pensu,
            pentime,
            skzflg,
            canzmflg,
            tanskkey,
            iff(skzumsu = '', '0', skzumsu) skzumsu,
            caseno,
            case
                when
                    (pendid = '31' and iff(pensu = '', '0', pensu) > 0)
                    or iff(skzumsu = '', '0', skzumsu) > 0
                then substr(pentime, 1, 8)
            end m_nokishiteiyoyakuymd,
            odrno
        from {{ ref("stg_DVNP0700_odrno") }}
    -- from {{ ref("stg_DVNP0700") }}
    ),
    odr_shiji as (
        select
            ordrkey,
            tanskkey,
            jurrsymd juchuymd,  -- todo: 受注日が追加されたら置き換え
            --
            jurrsymd,
            srsirskcd,
            kozyocd,
            brsirskcd,
            nonukyokbn,
            ukeirecd,
            nonyutni,
            picloke,
            sykikicd,
            sksijbsy,
            daitityp,
            shinban,
            ldts
        from {{ ref("stg_CVN06DODRSHIJI") }}
    ),
    syukkajissekiruikei as (
        select
            ordrkey,
            tanskkey,
            caseno,
            juchuymd,
            shinban,
            max(syukkokan) syukkokan,
            max(konkan) konkan
        from {{ ref("stg_QLQXN190") }}
        group by all
    )  -- 参照カラムしかstgに置いていないため＊検索（仮開発用）
select
    temp10.*,
    oss.* exclude (ordrkey, juchuymd, odrno, caseno),
    os.* exclude (ordrkey, juchuymd, tanskkey, shinban),
    sj.konkan,
    sj.syukkokan
from temp10
left outer join
    odr_shiji_status oss
    on temp10.ordrkeys like '%' || oss.ordrkey || '%'
    -- on temp10.ordrkey = oss.ordrkey
    and temp10.odrno = oss.odrno
-- and temp10.juchuymd = oss.juchuymd テストデータには受注日が追加されないためコメントアウト
left outer join
    odr_shiji os
    on oss.ordrkey = os.ordrkey
    -- and oss.juchuymd = os.juchuymd テストデータには受注日が追加されないためコメントアウト
    and oss.tanskkey = os.tanskkey
left outer join
    syukkajissekiruikei sj
    on oss.ordrkey = sj.ordrkey
    -- and oss.juchuymd = sj.juchuymd テストデータには受注日が追加されないためコメントアウト
    and oss.tanskkey = sj.tanskkey
    and oss.caseno = sj.caseno
    and oss.shinban = sj.shinban
order by dlrcd, yusokbn, odrno, juchuymd, jhinban, syubetsu
