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
            lok_m, -- ラインオフ計画日
            int_cd, -- 内張コード
            ext_cd -- 外販コード
        from {{ ref('stg_kokunaiseisan') }}  -- 国内新生産実績
        where odrtype = '7' -- オーダータイプ7:国内販売のみ
    ),
    haisya as (
        select * from (
            select
                frmno, -- フレームNo
                frmkbn, -- フレーム区分
                shamei, -- 社名コード
                sno, -- 仕様書No
                hkata, -- 販売型式
                row_number() over(
                    partition by frmno, frmkbn, shamei, sno, hkata
                    order by ldts) as aggkey
            from {{ ref('stg_haisyagenshi_valid') }} -- 配車原始（処理形態絞り込み）
        )
        -- 先頭１レコード抽出条件
        where aggkey = 1
    )
select
    kokunai.* exclude (frmkbn, shamei, sno),
    haisya.* exclude (frmno, frmkbn, shamei, sno, aggkey)
from kokunai
left outer join haisya
  on kokunai.frmno = haisya.frmno
 and kokunai.frmkbn = haisya.frmkbn
 and kokunai.shamei = haisya.shamei
 and kokunai.sno = haisya.sno