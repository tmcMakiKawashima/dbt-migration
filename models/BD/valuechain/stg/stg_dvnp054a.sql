{{ config(materialized='table') }}

with stg_dvnp054a as (
  select
    rtrim(DLRCD, ' 　')::VARCHAR(7) as DLRCD,  -- 英数字
    rtrim(SMKMEIJPJH, ' 　')::VARCHAR(10) as SMKMEIJPJH, -- 全角10桁、２０バイト
    rtrim(SMKMEIJPJS, ' 　')::VARCHAR(10) as SMKMEIJPJS, -- 全角10桁、２０バイト
    rtrim(SMKMEIKJH, ' 　')::VARCHAR(20) as SMKMEIKJH,  -- 英数字
    rtrim(SMKMEIKJS, ' 　')::VARCHAR(20) as SMKMEIKJS,  -- 英数字
    rtrim(JUSYO1JP, ' 　')::VARCHAR(10) as JUSYO1JP, -- 全角10桁、２０バイト
    rtrim(JUSYO2JP, ' 　')::VARCHAR(10) as JUSYO2JP, -- 全角10桁、２０バイト
    rtrim(JUSYO3JP, ' 　')::VARCHAR(10) as JUSYO3JP, -- 全角10桁、２０バイト
    rtrim(JUSYO4JP, ' 　')::VARCHAR(10) as JUSYO4JP, -- 全角10桁、２０バイト
    rtrim(MTUSERID, ' 　')::VARCHAR(16) as MTUSERID,  -- 英数字
    rtrim(MTTIME, ' 　')::VARCHAR(26) as MTTIME,  -- 英数字
    rtrim(DUMMY, ' 　')::VARCHAR(9) as DUMMY,  -- 英数字
    LDTS -- B層のLDTS
  from {{ ref('substr_dvnp054a') }}
)
select * from stg_dvnp054a
where LDTS = (select max(LDTS) from stg_dvnp054a)
