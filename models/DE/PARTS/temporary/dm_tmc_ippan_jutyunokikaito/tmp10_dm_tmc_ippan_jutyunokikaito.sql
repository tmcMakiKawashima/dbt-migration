with
    order_joho as (
        select
            ordrkey, -- オーダーキー
            dlrcd, -- 仕向先CD
            yusokbn, -- 輸送CD
            odrno, -- オーダーNO
            juchuymd, -- 受注日
            jhinban, -- 受注品番
            syubetsu, -- オーダー種別
            juchusu, -- 受注数
            rimak1, -- リマークⅠ
            rimak2, -- リマークⅡ
            ldts -- snapshot作成用
        from {{ ref("stg_dvnp0680") }}  -- オーダー情報ファイル
        where kokagkbn = '1'
    ),
    noshi_latest as (
        select
            ordrkey, -- オーダーキー
            juchuymd, -- 受注日
            hnskiboymd, -- 出荷希望日(最新)
            hoskiboymd, -- 出荷希望日(前回)
            hsskiboymd, -- 出荷希望日(初回/オーダー受注時点)
            skibohenkokaisu, -- 出荷希望日変更回数
            hnhonyoyakuymd, -- 本予約日(最新)
            hshonyoyakuymd, -- 本予約日(初回)
            hnnksyytime, -- 納期回答出荷予定日時(最新)
            honksyytime, -- 納期回答出荷予定日時(前回)
            hsnksyytime, -- 納期回答出荷予定日時(初回)
            allnosicansu, -- キャンセル数量(総量)_納指キャンセル分
            hnnosicansu, -- キャンセル数量(最新)_納指キャンセル分
            hnnosicantime, -- キャンセル日時(最新)_納指キャンセル分
            honosicantime, -- キャンセル日時(前回)_納指キャンセル分
            hsnosicantime, -- キャンセル日時(初回)_納指キャンセル分
            nosicankaisu, -- キャンセル回数_納指キャンセル分
            iphonyoyakuymd, -- IP本予約日
            case
                when (hnhonyoyakuymd <> juchuymd) then juchuymd else ''
            end kariyoyakuymd, -- 仮予約日
            nosikbn hnnosikbn, -- 納指状態区分(最新)
            ordrkey as check1_ordrkey -- オーダーキー nullチェック用
        from {{ ref("stg_cvn18nosiodrjyoho_latest") }} -- 納指オーダー情報ファイル（最新）
    ),
    noshi_initial as (
        select ordrkey, -- オーダーキー
               juchuymd, -- 受注日
               nosikbn as hsnosikbn -- 納指状態区分(初回)
        from {{ ref("stg_cvn18nosiodrjyoho_initial") }} -- 納指オーダー情報ファイル（初回）
    ),
    noshi_previous as (
        select ordrkey, -- オーダーキー
               juchuymd, -- 受注日
               nosikbn as honosikbn -- 納指状態区分(前回)
        from {{ ref("stg_cvn18nosiodrjyoho_previous") }} -- 納指オーダー情報ファイル（前回）
    ),
    bo_kaito as (
        select
            ordrkey, -- オーダーキー
            juchuymd, -- 受注日
            hnnoytime, -- 最新納入予定日時
            hnsyytime, -- 最新出荷予定日時
            hntoytime, -- 最新到着予定日時
            hsnoytime, -- 初回納入予定日時
            hssyytime, -- 初回出荷予定日時
            ptopflg, -- PTOPFLG
            hskkbn, -- 初回回答区分
            hstaytime, -- 初回棚入予定日時
            hstoytime, -- 初回到着予定日時
            hokkbn, -- 前回回答区分
            honoytime, -- 前回納入予定日時
            hotaytime, -- 前回棚入予定日時
            hosyytime, -- 前回出荷予定日時
            hotoytime, -- 前回到着予定日時
            mkaitocd, -- 未回答ＣＤ
            hnkkbn, -- 最新回答区分
            hntaytime, -- 最新棚入予定日時
            ipsyytmie, -- インプット出荷予定日時
            ordrkey as check2_ordrkey -- オーダーキー nullチェック用
        from {{ ref("stg_dvnp0710") }} -- BO納期回答ファイル
        where kokagkbn = '1'
    ),
    bo_kanri as (
        select ordrkey, -- オーダーキー
               juchuymd, -- 受注日
               martflg, -- マル超FLG
               ordrkey as check3_ordrkey -- オーダーキー nullチェック用
        from {{ ref("stg_dvnp6490") }} -- BO納期管理資料累積ファイル
        where kokagkbn = '1'
    )
select
    jh.*,
    nl.* exclude (ordrkey, juchuymd),
    ni.* exclude (ordrkey, juchuymd),
    np.* exclude (ordrkey, juchuymd),
    bkai.* exclude (ordrkey, juchuymd),
    bkan.* exclude (ordrkey, juchuymd)
from order_joho jh
left outer join noshi_latest nl on jh.ordrkey = nl.ordrkey and jh.juchuymd = nl.juchuymd
left outer join
    noshi_initial ni on jh.ordrkey = ni.ordrkey and jh.juchuymd = ni.juchuymd
left outer join
    noshi_previous np on jh.ordrkey = np.ordrkey and jh.juchuymd = np.juchuymd
left outer join
    bo_kaito bkai on jh.ordrkey = bkai.ordrkey and jh.juchuymd = bkai.juchuymd
left outer join
    bo_kanri bkan on jh.ordrkey = bkan.ordrkey and jh.juchuymd = bkan.juchuymd
