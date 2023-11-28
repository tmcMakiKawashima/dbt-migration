{{ config(materialized="table") }}
with
    temp10 as (
        select
            -- オーダー情報ファイル
            dlrcd, -- 仕向先CD
            yusokbn, -- 輸送CD
            odrno, -- オーダーNO
            juchuymd, -- 受注日
            jhinban, -- 受注品番
            syubetsu, -- オーダー種別
            listagg(distinct ordrkey, ',') within group (order by ordrkey) ordrkey, -- オーダーキー
            sum(juchusu) juchusu, -- 受注数
            max(rimak1) rimak1, -- リマークⅠ
            max(rimak2) rimak2, -- リマークⅡ
            max(ldts) ldts_snapshot, -- snapshot作成用
            -- 納指オーダー情報
            max(iff(hnskiboymd is null, '', hnskiboymd)) hnskiboymd, -- 出荷希望日(最新)
            max(iff(hoskiboymd is null, '', hoskiboymd)) hoskiboymd, -- 出荷希望日(前回)
            max(iff(hsskiboymd is null, '', hsskiboymd)) hsskiboymd, -- 出荷希望日(初回/オーダー受注時点)
            sum(iff(skibohenkokaisu is null, '0', skibohenkokaisu)) skibohenkokaisu, -- 出荷希望日変更回数
            max(iff(hnhonyoyakuymd is null, '', hnhonyoyakuymd)) hnhonyoyakuymd, -- 本予約日(最新)
            max(iff(hshonyoyakuymd is null, '', hshonyoyakuymd)) hshonyoyakuymd, -- 本予約日(初回)
            max(iff(hnnksyytime is null, '', hnnksyytime)) hnnksyytime, -- 納期回答出荷予定日時(最新)
            max(iff(honksyytime is null, '', honksyytime)) honksyytime, -- 納期回答出荷予定日時(前回)
            max(iff(hsnksyytime is null, '', hsnksyytime)) hsnksyytime, -- 納期回答出荷予定日時(初回)
            sum(iff(allnosicansu is null, '0', allnosicansu)) allnosicansu, -- キャンセル数量(総量)_納指キャンセル分
            sum(iff(hnnosicansu is null, '0', hnnosicansu)) hnnosicansu, -- キャンセル数量(最新)_納指キャンセル分
            max(iff(hnnosicantime is null, '', hnnosicantime)) hnnosicantime, -- キャンセル日時(最新)_納指キャンセル分
            max(iff(honosicantime is null, '', honosicantime)) honosicantime, -- キャンセル日時(前回)_納指キャンセル分
            max(iff(hsnosicantime is null, '', hsnosicantime)) hsnosicantime, -- キャンセル日時(初回)_納指キャンセル分
            sum(iff(nosicankaisu is null, '0', nosicankaisu)) nosicankaisu, -- キャンセル回数_納指キャンセル分
            max(iff(iphonyoyakuymd is null, '', iphonyoyakuymd)) iphonyoyakuymd, -- IP本予約日
            max(iff(kariyoyakuymd is null, '', kariyoyakuymd)) kariyoyakuymd, -- 仮予約日
            max(iff(hnnosikbn is null, '', hnnosikbn)) hnnosikbn, -- 納指状態区分(最新)
            max(iff(hsnosikbn is null, '', hsnosikbn)) hsnosikbn, -- 納指状態区分(初回)
            max(iff(honosikbn is null, '', honosikbn)) honosikbn, -- 納指状態区分(前回)
            -- BO納期回答
            max(iff(hnnoytime is null, '', hnnoytime)) hnnoytime, -- 最新納入予定日時
            max(iff(hnsyytime is null, '', hnsyytime)) hnsyytime, -- 最新出荷予定日時
            max(iff(hntoytime is null, '', hntoytime)) hntoytime, -- 最新到着予定日時
            max(iff(hsnoytime is null, '', hsnoytime)) hsnoytime, -- 初回納入予定日時
            max(iff(hssyytime is null, '', hssyytime)) hssyytime, -- 初回出荷予定日時
            max(iff(ptopflg is null, '', ptopflg)) ptopflg, -- PTOPFLG
            max(iff(hskkbn is null, '', hskkbn)) hskkbn, -- 初回回答区分
            max(iff(hstaytime is null, '', hstaytime)) hstaytime, -- 初回棚入予定日時
            max(iff(hstoytime is null, '', hstoytime)) hstoytime, -- 初回到着予定日時
            max(iff(hokkbn is null, '', hokkbn)) hokkbn, -- 前回回答区分
            max(iff(honoytime is null, '', honoytime)) honoytime, -- 前回納入予定日時
            max(iff(hotaytime is null, '', hotaytime)) hotaytime, -- 前回棚入予定日時
            max(iff(hosyytime is null, '', hosyytime)) hosyytime, -- 前回出荷予定日時
            max(iff(hotoytime is null, '', hotoytime)) hotoytime, -- 前回到着予定日時
            max(iff(mkaitocd is null, '', mkaitocd)) mkaitocd, -- 未回答ＣＤ
            max(iff(hnkkbn is null, '', hnkkbn)) hnkkbn, -- 最新回答区分
            max(iff(hntaytime is null, '', hntaytime)) hntaytime, -- 最新棚入予定日時
            max(iff(ipsyytmie is null, '', ipsyytmie)) ipsyytmie, -- インプット出荷予定日時
            -- BO納期管理資料
            max(iff(martflg is null, '', martflg)) martflg -- マル超FLG
        from {{ ref("tmp10_dm_tmc_ippan_jutyunokikaito") }}
        group by all
        order by ordrkey, juchuymd
    ),
    odr_shiji_status as (
        select
            ordrkey, -- オーダーキー
            juchuymd, -- 受注日
            caseno, -- ケースNo
            odrno, -- オーダーNo
            jhinban, -- 受注品番
            dlrcd, -- 仕向先CD
            --
            shinban, -- 出荷品番
            bosu, -- B_O数
            boskstime, -- B_O作成日時
            kaknoukbn, -- 格納拠点区分
            pendid, -- ペンディングID
            iff(pensu = '', '0', pensu) pensu, -- ペンディング数
            pentime, -- ペンディング日時
            skzflg, -- 出荷済FLG
            canzmflg, -- キャンセル済FLG
            tanskkey, -- 短縮キー
            skzumsu, -- 出荷済数
            case
                when
                    (pendid = '31' and iff(pensu = '', '0', pensu) > 0)
                    or skzumsu > 0
                then substr(pentime, 1, 8)
                else ''
            end m_nokishiteiyoyakuymd, -- 納指予約日
            ordrkey as check1_ordrkey -- オーダーキー nullチェック用
        -- オーダー指示ステータスファイル（オーダーNo付与したもの）
        from {{ ref("stg_dvnp0700_odrno") }}
        order by ordrkey, juchuymd, tanskkey, caseno, shinban
    ),
    odr_shiji as (
        select
            ordrkey, -- オーダーキー
            juchuymd,  -- 受注日
            tanskkey, -- 短縮キー
            ldts, -- tmp20_tehaiで取込日時(降順)にソートした先頭レコードを取得するため
            --
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
            daitityp, -- 代替関係タイプ
            ordrkey as check2_ordrkey -- オーダーキー nullチェック用
        from {{ ref("stg_cvn06dodrshiji") }} -- オーダー指示ファイル
        order by ordrkey, juchuymd, tanskkey
    ),
    syukkajissekiruikei as (
        select
            od_key, -- オーダーKey
            ab_key, -- 短縮キー
            casno, -- ケースNO
            tkod_dt, -- 受注日
            shp_pno, -- 出荷品番
            max(pik_cp_dttm) pik_cp_dttm, -- 出庫完日時
            max(pak_dttm) pak_dttm -- 梱完日時
        from {{ ref("stg_shkjissekiruikei") }} -- 新入出荷＿出荷実績累積
        group by all
        order by od_key, tkod_dt, ab_key, casno, shp_pno
    )
select
    temp10.*,
    oss.* exclude (ordrkey, juchuymd, caseno, odrno, jhinban, dlrcd),
    os.* exclude (ordrkey, juchuymd, tanskkey),
    sj.pik_cp_dttm,
    sj.pak_dttm,
    sj.od_key as check3_ordrkey -- オーダーキー nullチェック用
from temp10
left outer join
    odr_shiji_status oss -- オーダー指示ステータスファイル
    -- オーダー指示ステータスファイル.オーダーキーがデータ結合1.オーダーキーリストの中に含まれる場合
    on array_contains(oss.ordrkey::variant,split(temp10.ordrkey,','))
    and temp10.odrno = oss.odrno -- オーダーNo
    and temp10.juchuymd = oss.juchuymd -- 受注日
    and temp10.jhinban = oss.jhinban -- 受注品番
    and temp10.dlrcd = oss.dlrcd -- 仕向先CD
left outer join
    odr_shiji os -- オーダー指示ファイル
    on oss.ordrkey = os.ordrkey -- オーダーキー
    and oss.juchuymd = os.juchuymd -- 受注日
    and oss.tanskkey = os.tanskkey -- 短縮キー
left outer join
    syukkajissekiruikei sj -- 新入出荷＿出荷実績累積
    on oss.ordrkey = sj.od_key -- オーダーキー
    and oss.juchuymd = sj.tkod_dt -- 受注日
    and oss.tanskkey = sj.ab_key -- 短縮キー
    and oss.caseno = sj.casno -- ケースNo
    and oss.shinban = sj.shp_pno -- 出荷品番
order by dlrcd, yusokbn, odrno, juchuymd, jhinban, syubetsu