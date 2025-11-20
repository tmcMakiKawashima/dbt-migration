{{ config(
    materialized='table',
    transient='true'
) }}
-- 1. 装備情報取得
-- 装備(VIN×MOP)情報から、全レコードを取得。仕様桁・仕様記号が入っていないレコードは対象外
with tmp_get_union as (
    select
        trim(syadai_kt) as syadai_kt,
        trim(frm_no) as frm_no,
        trim(wmi) as wmi,
        trim(vds) as vds,
        trim(mdlyr) as mdlyr,
        trim(vin_vds_cd) as vin_vds_cd,
        trim(syasyu_cd) as syasyu,
        trim(haisya_kt) as haisya_kt,
        sketa_cd,
        skigo_cd
    from {{ source('vinhis_db_spec','raw_dm_vinhis_specification_union') }}
    where
        coalesce( trim(sketa_cd), '' ) <> '' and
        coalesce( trim(skigo_cd), '' ) <> ''
),

-- 2-1. 仕様変更テーブルから必要項目データのみを取得
tmp_get_siyouhenkan as (
    select
        syasyu,
        s1keta,
        s1kigo,
        siyoudai4,
        siyousai4,
        row_number() over (
            partition by
                syasyu,
                s1keta,
                s1kigo
            order by
                tekikara desc
        ) as latest_rank
    from {{ source('supplydemand_db_public','raw_stg_siyouhenkan') }}
),

-- 2-2. 仕様変換テーブルの最も適用日が最新のレコードのみを取得
tmp_get_siyouhenkan_latest as
(
    select * from tmp_get_siyouhenkan where latest_rank = 1
),

-- 3. 装備情報に、仕様コード大分類・細目を結合
tmp_join_siyo4 as (
    select
        a.*,
        coalesce(b.siyoudai4, '') as siyoudai4,
        coalesce(b.siyousai4, '') as siyousai4
    from tmp_get_union a
    left join tmp_get_siyouhenkan_latest b
        on trim(a.syasyu) = trim(b.syasyu) and
        trim(a.sketa_cd) = trim(b.s1keta) and
        trim(a.skigo_cd) = trim(b.s1kigo)
),

-- 4. 装備情報の、大分類コードの並び順を統一(昇順)
tmp_get_siyo_tate as (
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
    from tmp_join_siyo4
)

-- 5. 装備情報の、縦→横変換処理(大分類細目の集約と、仕様記号コードの集約)
select
    syadai_kt,
    frm_no,
    wmi,
    vds,
    mdlyr,
    vin_vds_cd,
    -- spec200
    (
        max( case when sketa_cd = '1' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '2' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '3' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '4' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '5' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '6' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '7' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '8' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '9' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '10' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '11' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '12' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '13' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '14' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '15' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '16' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '17' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '18' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '19' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '20' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '21' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '22' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '23' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '24' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '25' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '26' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '27' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '28' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '29' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '30' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '31' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '32' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '33' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '34' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '35' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '36' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '37' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '38' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '39' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '40' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '41' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '42' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '43' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '44' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '45' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '46' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '47' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '48' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '49' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '50' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '51' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '52' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '53' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '54' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '55' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '56' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '57' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '58' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '59' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '60' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '61' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '62' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '63' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '64' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '65' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '66' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '67' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '68' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '69' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '70' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '71' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '72' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '73' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '74' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '75' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '76' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '77' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '78' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '79' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '80' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '81' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '82' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '83' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '84' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '85' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '86' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '87' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '88' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '89' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '90' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '91' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '92' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '93' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '94' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '95' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '96' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '97' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '98' then skigo_cd else ' ' end ) ||
        max( case when sketa_cd = '99' then skigo_cd else ' ' end ) ||
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
    
    -- 仕様コード200
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
from tmp_get_siyo_tate
group by
    syadai_kt,
    frm_no,
    wmi,
    vds,
    mdlyr,
    vin_vds_cd

