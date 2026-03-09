with extract_vinhisfile as (
    select
        ltrim(split_part(raw_data, '^,^', 1), '^')::varchar(1) as updatekbn,
        split_part(raw_data, '^,^', 2)::varchar(9) as syadai_kt,
        split_part(raw_data, '^,^', 3)::varchar(7) as frm_no,
        split_part(raw_data, '^,^', 4)::varchar(3) as daibun_4,
        split_part(raw_data, '^,^', 5)::varchar(1) as saimoku_4,
        split_part(raw_data, '^,^', 6)::varchar(800) as sai_kana_name,
        split_part(raw_data, '^,^', 7)::varchar(10) as parts_cd,
        split_part(raw_data, '^,^', 8)::varchar(2) as ruibetsu,
        split_part(raw_data, '^,^', 9)::varchar(60) as parts_name,
        split_part(raw_data, '^,^', 10)::varchar(3) as kosu,
        split_part(raw_data, '^,^', 11)::varchar(8) as ug_date,
        split_part(raw_data, '^,^', 12)::varchar(400) as nyuko_dealer_cd,
        rtrim(split_part(raw_data, '^,^', 13), '^')::varchar(7) as odo,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_vinhisfile') }}
)
select * from extract_vinhisfile
