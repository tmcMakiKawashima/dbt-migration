-- データ結合１
with
    kokunai as (
        select
            frmkbn, -- フレーム区分
            shamei, -- 社名コード
            sno, -- 仕様書No
            syadai_kt, -- 車台型式
            frmno, -- フレームNo
            syasyu_cd, -- 車種コード
            haisya_kt, -- 配車型式
            lok_y, -- ラインオフ計画日
            lok_m -- ラインオフ計画日
        from {{ ref("stg_kokunaiseisan") }}  -- 国内新生産実績
        where odrtype = '7' -- オーダータイプ7:国内販売のみ
    ),
    haisya as (
        select
            frmno, -- フレームNo
            frmkbn, -- フレーム区分
            shamei, -- 社名コード
            sno, -- 仕様書No
            hkata as hanbai_kt -- 販売型式
        from {{ ref("stg_haisyagenshi") }} -- 配車原始
        where sketai in ('20', '30') -- 処理形態20:在庫配車、30:通常配車のみ
    )
select
    kokunai.* exclude (frmkbn, shamei, sno),
    haisya.* exclude (frmno, frmkbn, shamei, sno)
from kokunai
left outer join haisya
  on kokunai.frmno = haisya.frmno
 and kokunai.frmkbn = haisya.frmkbn
 and kokunai.shamei = haisya.shamei
 and kokunai.sno = haisya.sno