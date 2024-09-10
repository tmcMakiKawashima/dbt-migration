{{ config(snowflake_warehouse='DBT_WH') }}

with stg_tbsmksk as (
    select
        rtrim(ID, ' 　')::VARCHAR(3) as ID, -- 英数字
        rtrim(KYOUHAN, ' 　')::VARCHAR(5) as KYOUHAN, -- 英数字
        IFF(rtrim(KYOTEN) = '', '', LPAD(rtrim(KYOTEN), length(KYOTEN), '0'))::VARCHAR(2) as KYOTEN, -- コード／区分
        rtrim(YOBI, ' 　')::VARCHAR(15) as YOBI, -- 英数字
        rtrim(SISHACD, ' 　')::VARCHAR(2) as SISHACD, -- 英数字
        rtrim(TSIWAKECD1, ' 　')::VARCHAR(2) as TSIWAKECD1, -- 英数字
        rtrim(TSIWAKECD2, ' 　')::VARCHAR(2) as TSIWAKECD2, -- 英数字
        rtrim(FILLER, ' 　')::VARCHAR(369) as FILLER, -- 英数字
        LDTS -- B層のLDTS
    from {{ ref('substr_tbsmksk') }}
)
select * from stg_tbsmksk
where LDTS = (select max(LDTS) from stg_tbsmksk)
