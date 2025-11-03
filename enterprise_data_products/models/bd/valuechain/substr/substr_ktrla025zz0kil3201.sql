with substr_ktrla025zz0kil3201 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as kbn, --C,U,Dのメンテ区分
        substr(raw_data, 2, 3)::varchar(3) as kbsyadai, -- 車台区分
        substr(raw_data, 5, 20)::varchar(20) as nosyadai, -- 車台番号
        substr(raw_data, 25, 8)::varchar(8) as ddtorituke, -- 取付日
        substr(raw_data, 33, 15)::varchar(15) as cdyouhinban, -- 用品品番コード
        substr(raw_data, 48, 5)::varchar(5) as cdtorihan, -- 取付販売店コード
        substr(raw_data, 53, 3)::varchar(3) as cdtoritenpo, -- 取付店舗コード
        substr(raw_data, 56, 2)::varchar(2) as suuryou, -- 数量
        substr(raw_data, 58, 3)::varchar(3) as kmtrtsok, -- 取付走行千Ｋｍ
        substr(raw_data, 61, 1)::varchar(1) as kbsinsa, -- 新サ区分
        ldts, -- B層のldtsを取得
        line_number
    from {{ source('snowpipe_db_marketing', 'raw_ktrla025zz0kil3201') }}
)
select * from substr_ktrla025zz0kil3201