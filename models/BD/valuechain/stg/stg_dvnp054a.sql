with stg_dvnp054a as (
  select
    rtrim(dlrcd, ' 　')::varchar(7) as dlrcd,  -- 英数字
    rtrim(smkmeijpjh, ' 　')::varchar(10) as smkmeijpjh, -- 全角10桁、２０バイト
    rtrim(smkmeijpjs, ' 　')::varchar(10) as smkmeijpjs, -- 全角10桁、２０バイト
    rtrim(smkmeikjh, ' 　')::varchar(20) as smkmeikjh,  -- 英数字
    rtrim(smkmeikjs, ' 　')::varchar(20) as smkmeikjs,  -- 英数字
    rtrim(jusyo1jp, ' 　')::varchar(10) as jusyo1jp, -- 全角10桁、２０バイト
    rtrim(jusyo2jp, ' 　')::varchar(10) as jusyo2jp, -- 全角10桁、２０バイト
    rtrim(jusyo3jp, ' 　')::varchar(10) as jusyo3jp, -- 全角10桁、２０バイト
    rtrim(jusyo4jp, ' 　')::varchar(10) as jusyo4jp, -- 全角10桁、２０バイト
    rtrim(mtuserid, ' 　')::varchar(16) as mtuserid,  -- 英数字
    try_to_timestamp_ntz(mttime, 'yyyy-mm-dd-hh24.mi.ss.ff9') as mttime, -- timestamp型
    rtrim(dummy, ' 　')::varchar(9) as dummy,  -- 英数字
    ldts -- B層のLDTS
  from {{ ref('substr_dvnp054a') }}
)
select * from stg_dvnp054a
where ldts = (select max(ldts) from stg_dvnp054a)
