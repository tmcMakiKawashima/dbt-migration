{{ config(materialized='table') }}

with stg_tbdaihl as (
    select
        -- to_char(rtrim(KYOUHAN)) as KYOUHAN,
        rtrim(KYOUHAN) as KYOUHAN,
        rtrim(HATUHINB) as HATUHINB,
        rtrim(HATUMKBN) as HATUMKBN,
        rtrim(CHUMON) as CHUMON,
        rtrim(ODERSYU) as ODERSYU,
        -- IFF(rtrim(USERCD) = '', '', LPAD(rtrim(USERCD), length(USERCD), '0')) as USERCD, -- コード／区分
        -- IFF(rtrim(USERCD) = '', rtrim(USERCD), LPAD(rtrim(USERCD), length(USERCD), '0')) as USERCD, -- コード／区分
        -- IFF(rtrim(USERCD) = '', '', LPAD(rtrim(USERCD), length(USERCD), '0'))::VARCHAR(length(USERCD)) as USERCD, -- コード／区分
        IFF(rtrim(USERCD) = '', '', LPAD(rtrim(USERCD), length(USERCD), '0'))::VARCHAR(5) as USERCD, -- コード／区分
        rtrim(KAISYA) as KAISYA,
        rtrim(TCHUMON) as TCHUMON,
        -- rtrim(HATTYUHI) as HATTYUHI, -- 日付
        IFF(rtrim(HATTYUHI) = '', '', LPAD(rtrim(HATTYUHI), length(HATTYUHI), '0')) as HATTYUHI, -- 日付
        -- to_date(IFF(rtrim(HATTYUHI) = '', '19700101', rtrim(HATTYUHI)), 'YYYYMMDD') as HATTYUHI, -- 日付
        rtrim(FRMKBN) as FRMKBN,
        rtrim(FRMNO) as FRMNO,
        rtrim(HANKATA) as HANKATA,
        rtrim(HATTYUSUS) as HATTYUSUS,
        -- to_decimal(IFF(rtrim(HATTYUSU) = '', 0, rtrim(HATTYUSU))) as HATTYUSU, -- 数量／金額／数値
        IFF(rtrim(HATTYUSU) = '', 0, rtrim(HATTYUSU))::DECIMAL(5) as HATTYUSU, -- 数量／金額／数値
        rtrim(TORITOKB) as TORITOKB,
        rtrim(HINBAN) as HINBAN,
        rtrim(MEKAKB) as MEKAKB,
        LDTS,
        RANK() over (partition by KYOUHAN, HATUHINB, HATUMKBN, CHUMON, ODERSYU, USERCD, KAISYA, TCHUMON, HATTYUHI order by LDTS desc) aggkey
    from {{ ref('substr_tbdaihl') }}
)
select * from stg_tbdaihl
where aggkey = 1
