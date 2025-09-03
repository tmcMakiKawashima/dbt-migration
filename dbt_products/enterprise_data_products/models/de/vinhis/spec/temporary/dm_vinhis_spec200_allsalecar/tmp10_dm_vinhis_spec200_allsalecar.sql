-- 1. VIN×SPEC200に存在しないレコードのみを対象とする。
with tmp_yoko as (
    select
        a.syadai_kt,              -- 車台型式
        a.frm_no,                 -- フレームNo
        a.wmi,                    -- WMI
        a.vds,                    -- チェックディジット
        a.mdlyr,                  -- モデル年
        a.vin_vds_cd,             -- VINチェックディジット
        a.syasyu_cd as syasyu,    -- 車種コード
        a.haisya_kt,              -- 配車型式
        a.sketa_cd,               -- 仕様桁コード
        a.skigo_cd                -- 仕様記号コード
      from {{ source('vinhis_db_spec','raw_dm_vinhis_specification_union') }} as a
    left join {{ source('vinhis_db_spec','raw_dm_vinhis_spec200_allsalecar') }} as b
        on trim(a.syadai_kt) = trim(b.syadai_kt) and
        trim(a.frm_no) = trim(b.frm_no) and
        trim(a.wmi) = trim(b.wmi) and
        trim(a.vds) = trim(b.vds) and
        trim(a.mdlyr) = trim(b.mdlyr) and
        trim(a.vin_vds_cd) = trim(b.vin_vds_cd)
    where
        b.syadai_kt is null
),

-- 2. 仕様コード付与
tmp_target as (
    select
        a.*,
        b.siyoudai4,                  -- 仕様コード・4桁（大分類）
        b.siyousai4                   -- 仕様コード・4桁（細目）
    from tmp_yoko as a
    left join {{ source('supplydemand_db_public','raw_stg_siyouhenkan') }} as b
        on trim(a.syasyu) = trim(b.syasyu) and
        trim(a.sketa_cd) = trim(b.s1keta) and
        trim(a.skigo_cd) = trim(b.s1kigo)
),

-- 3. 装備仕様コード作成のための順序設定（大分類を昇順に並び替えで統一）
tmp_target_tate as (
    select
        *,
        row_number() over (
            partition by
                syadai_kt,
                frm_no,
                wmi,
                vds,
                mdlyr,
                vin_vds_cd
            order by
                siyoudai4 asc
        ) as daibun_seq
    from tmp_target
),

-- 4. 仕様コード縦持ち→横持ち変換
tmp_siyo_yoko as (
    select
        syadai_kt,
        frm_no,
        wmi,
        vds,
        mdlyr,
        vin_vds_cd,
        -- SPECコード200桁作成処理（仕様記号を200桁分結合）
        (
            max( case when sketa_cd = '001' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '002' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '003' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '004' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '005' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '006' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '007' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '008' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '009' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '010' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '011' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '012' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '013' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '014' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '015' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '016' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '017' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '018' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '019' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '020' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '021' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '022' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '023' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '024' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '025' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '026' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '027' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '028' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '029' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '030' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '031' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '032' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '033' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '034' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '035' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '036' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '037' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '038' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '039' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '040' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '041' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '042' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '043' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '044' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '045' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '046' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '047' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '048' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '049' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '050' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '051' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '052' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '053' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '054' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '055' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '056' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '057' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '058' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '059' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '060' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '061' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '062' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '063' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '064' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '065' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '066' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '067' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '068' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '069' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '070' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '071' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '072' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '073' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '074' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '075' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '076' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '077' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '078' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '079' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '080' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '081' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '082' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '083' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '084' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '085' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '086' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '087' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '088' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '089' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '090' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '091' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '092' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '093' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '094' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '095' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '096' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '097' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '098' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '099' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '100' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '101' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '102' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '103' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '104' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '105' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '106' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '107' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '108' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '109' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '110' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '111' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '112' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '113' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '114' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '115' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '116' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '117' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '118' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '119' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '120' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '121' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '122' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '123' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '124' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '125' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '126' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '127' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '128' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '129' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '130' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '131' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '132' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '133' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '134' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '135' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '136' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '137' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '138' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '139' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '140' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '141' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '142' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '143' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '144' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '145' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '146' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '147' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '148' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '149' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '150' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '151' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '152' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '153' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '154' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '155' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '156' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '157' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '158' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '159' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '160' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '161' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '162' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '163' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '164' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '165' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '166' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '167' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '168' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '169' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '170' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '171' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '172' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '173' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '174' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '175' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '176' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '177' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '178' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '179' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '180' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '181' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '182' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '183' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '184' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '185' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '186' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '187' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '188' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '189' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '190' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '191' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '192' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '193' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '194' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '195' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '196' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '197' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '198' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '199' then skigo_cd else ' ' end ) ||
            max( case when sketa_cd = '200' then skigo_cd else ' ' end )
        ) as spec200,
        -- 仕様コード200桁作成処理（昇順で仕様コードを結合）
        (
            max( case when daibun_seq = 2 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 3 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 4 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 5 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 6 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 7 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 8 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 9 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 10 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 11 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 12 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 13 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 14 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 15 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 16 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 17 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 18 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 19 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 20 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 21 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 22 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 23 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 24 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 25 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 26 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 27 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 28 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 29 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 30 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 31 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 32 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 33 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 34 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 35 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 36 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 37 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 38 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 39 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 40 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 41 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 42 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 43 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 44 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 45 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 46 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 47 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 48 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 49 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 50 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 51 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 52 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 53 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 54 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 55 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 56 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 57 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 58 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 59 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 60 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 61 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 62 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 63 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 64 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 65 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 66 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 67 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 68 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 69 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 70 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 71 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 72 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 73 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 74 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 75 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 76 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 77 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 78 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 79 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 80 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 81 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 82 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 83 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 84 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 85 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 86 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 87 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 88 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 89 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 90 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 91 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 92 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 93 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 94 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 95 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 96 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 97 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 98 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 99 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 100 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 101 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 102 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 103 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 104 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 105 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 106 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 107 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 108 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 109 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 110 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 111 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 112 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 113 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 114 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 115 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 116 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 117 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 118 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 119 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 120 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 121 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 122 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 123 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 124 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 125 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 126 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 127 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 128 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 129 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 130 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 131 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 132 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 133 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 134 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 135 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 136 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 137 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 138 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 139 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 140 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 141 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 142 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 143 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 144 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 145 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 146 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 147 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 148 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 149 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 150 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 151 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 152 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 153 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 154 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 155 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 156 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 157 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 158 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 159 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 160 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 161 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 162 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 163 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 164 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 165 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 166 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 167 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 168 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 169 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 170 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 171 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 172 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 173 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 174 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 175 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 176 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 177 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 178 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 179 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 180 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 181 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 182 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 183 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 184 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 185 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 186 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 187 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 188 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 189 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 190 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 191 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 192 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 193 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 194 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 195 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 196 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 197 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 198 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 199 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 200 then siyoudai4 || siyousai4 else '' end ) ||
            max( case when daibun_seq = 201 then siyoudai4 || siyousai4 else '' end )
        ) as daisai200
    from tmp_target_tate
    group by
        syadai_kt,
        frm_no,
        wmi,
        vds,
        mdlyr,
        vin_vds_cd
),

-- 5. 生産実績のある装備情報のみに集約+必要情報の付与
tmp_pick as (
    select
        a.syadai_kt,              -- 車台型式
        a.frm_no,                 -- フレームNo
        a.wmi,                    -- WMI
        a.vds,                    -- チェックディジット
        a.mdlyr,                  -- モデル年
        a.vin_vds_cd,             -- VINチェックディジット
        c.syasyu,                 -- 車種コード
        c.haisya_kt,              -- 配車型式
        a.spec200,                -- SPEC200桁
        a.daisai200,              -- 大分類細目200桁
        b.int_cd,                 -- 内張コード
        b.ext_cd,                 -- 外張コード
        b.dest_cd,                -- 仕向地コード
        b.dest,                   -- 仕向国
        b.psc,                    -- PSC
        b.koujyou_cd,             -- 工場コード
        b.eng_kt,                 -- エンジン型式
        b.veh_plnt_code,          -- 車両工場コード
        b.prodkuni_cd,            -- 生産国コード
        b.o_idline,               -- アイデントライン
        b.loj_y,                  -- ラインオフ実績日年
        b.loj_m,                  -- ラインオフ実績日月
        b.sk_y,                   -- 終検日年
        b.sk_m                    -- 終検日月
    from tmp_siyo_yoko as a
      inner join {{ source('vinhis_db_public','raw_dm_allsalecar_seisanjisseki') }} as b
        on trim(a.syadai_kt) = trim(b.syadai_kt) and
        trim(a.frm_no) = trim(b.frmno) and
        trim(a.wmi) = trim(b.wmi) and
        trim(a.vds) = trim(b.vds) and
        trim(a.mdlyr) = trim(b.mdlyr) and
        trim(a.vin_vds_cd) = trim(b.vin_vds_cd)
    left join tmp_yoko c
        on trim(a.syadai_kt) = trim(c.syadai_kt) and
        trim(a.frm_no) = trim(c.frm_no) and
        trim(a.wmi) = trim(c.wmi) and
        trim(a.vds) = trim(c.vds) and
        trim(a.mdlyr) = trim(c.mdlyr) and
        trim(a.vin_vds_cd) = trim(c.vin_vds_cd)
)
select
    a.syadai_kt,                    -- 車台型式
    a.frm_no,                       -- フレームNo
    a.wmi,                          -- WMI
    a.vds,                          -- チェックディジット
    a.mdlyr,                        -- モデル年
    a.vin_vds_cd,                   -- VINチェックディジット
    a.syasyu,                       -- 車種コード
    a.haisya_kt,                    -- 配車型式
    a.spec200,                      -- SPECコード200桁
    a.daisai200 as spec200_siyo,    -- 仕様コード200桁
    a.int_cd,                       -- 内張コード
    b.iromei as int_cd_iromei,      -- 内張コード(色名)
    a.ext_cd,                       -- 外張コード
    c.iromei as ext_cd_iromei,      -- 外張コード(色名)
    a.dest_cd,                      -- 仕向地コード
    a.dest,                         -- 仕向国
    a.psc,                          -- PSC
    a.koujyou_cd,                   -- 工場コード
    a.eng_kt,                       -- エンジン型式
    a.veh_plnt_code,                -- 車両工場コード
    a.prodkuni_cd,                  -- 生産国コード
    a.o_idline,                     -- アイデントライン
    a.loj_y,                        -- ラインオフ実績日年
    a.loj_m,                        -- ラインオフ実績日月
    a.sk_y,                         -- 終検日年
    a.sk_m                          -- 終検日月
from tmp_pick as a
left join {{ ref('stg_color_no') }} as b      -- 内張用
    on trim(a.int_cd) = trim(b.gclrno)
left join {{ ref('stg_color_no') }} as c      -- 外張用
    on trim(a.ext_cd) = trim(c.gclrno)
