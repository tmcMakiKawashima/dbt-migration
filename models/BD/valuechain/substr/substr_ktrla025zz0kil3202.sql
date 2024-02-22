with substr_ktrla025zz0kil3202 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as delflg,
        substr(raw_data, 2, 3)::varchar(3) as KBSYADAI,
        substr(raw_data, 5, 20)::varchar(20) as NOSYADAI,
        substr(raw_data, 25, 8)::varchar(8) as seisanymd,
        substr(raw_data, 33, 5)::varchar(5) as nyukohanbaitencd,
        substr(raw_data, 38, 8)::varchar(8) as jutyuno,
        substr(raw_data, 46, 3)::varchar(3) as uketsuketenpocd,
        substr(raw_data, 49, 3)::varchar(3) as ikansakitenpocd,
        substr(raw_data, 52, 1)::varchar(1) as nyukokbn,
        substr(raw_data, 53, 8)::varchar(8) as nyukoyoteiymd,
        substr(raw_data, 61, 8)::varchar(8) as uketsukeymd,
        substr(raw_data, 69, 6)::varchar(6) as soukoukm,
        substr(raw_data, 75, 7)::varchar(7) as daiagcd1,
        substr(raw_data, 82, 7)::varchar(7) as daiagcd2,
        substr(raw_data, 89, 7)::varchar(7) as daiagcd3,
        substr(raw_data, 96, 7)::varchar(7) as daiagcd4,
        substr(raw_data, 103, 7)::varchar(7) as daiagcd5,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3202') }}
)
select * from substr_ktrla025zz0kil3202
