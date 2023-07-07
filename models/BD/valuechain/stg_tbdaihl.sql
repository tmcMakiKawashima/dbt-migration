{{ config(materialized='table') }}

with stg_tbdaihl as (
    select
        rtrim(KYOUHAN, ' 　')::VARCHAR(5) as KYOUHAN, -- 英数字
        rtrim(HATUHINB, ' 　')::VARCHAR(20) as HATUHINB, -- 英数字
        rtrim(HATUMKBN, ' 　')::VARCHAR(1) as HATUMKBN, -- 英数字
        rtrim(CHUMON, ' 　')::VARCHAR(5) as CHUMON, -- 英数字
        rtrim(ODERSYU, ' 　')::VARCHAR(2) as ODERSYU, -- 英数字
        IFF(rtrim(USERCD) = '', '', LPAD(rtrim(USERCD), length(USERCD), '0'))::VARCHAR(5) as USERCD, -- コード／区分
        rtrim(KAISYA, ' 　')::VARCHAR(2) as KAISYA, -- 英数字
        rtrim(TCHUMON, ' 　')::VARCHAR(14) as TCHUMON, -- 英数字
        IFF(rtrim(HATTYUHI) = '', '', LPAD(rtrim(HATTYUHI), length(HATTYUHI), '0'))::VARCHAR(8) as HATTYUHI, -- 日付
        rtrim(FRMKBN, ' 　')::VARCHAR(3) as FRMKBN, -- 英数字
        rtrim(FRMNO, ' 　')::VARCHAR(7) as FRMNO, -- 英数字
        rtrim(HANKATA, ' 　')::VARCHAR(20) as HANKATA, -- 英数字
        rtrim(HATTYUSUS, ' 　')::VARCHAR(1) as HATTYUSUS, -- 英数字
        to_decimal(IFF(rtrim(HATTYUSU) = '', 0, rtrim(HATTYUSU)))::DECIMAL(5) as HATTYUSU, -- 数量／金額／数値
        rtrim(TORITOKB, ' 　')::VARCHAR(1) as TORITOKB, -- 英数字
        rtrim(HINBAN, ' 　')::VARCHAR(20) as HINBAN, -- 英数字
        rtrim(MEKAKB, ' 　')::VARCHAR(1) as MEKAKB, -- 英数字
        LDTS as LDTSB, -- B層のLDTS
        current_timestamp as LDTSD, -- D層のLDTS
        RANK() over (partition by KYOUHAN, HATUHINB, HATUMKBN, CHUMON, ODERSYU, USERCD, KAISYA, TCHUMON, HATTYUHI order by LDTS desc) aggkey
    from {{ ref('substr_tbdaihl') }}
)
select * from stg_tbdaihl
where aggkey = 1
