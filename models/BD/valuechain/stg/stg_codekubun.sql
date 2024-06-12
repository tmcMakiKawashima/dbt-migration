with stg_codekubun as (
    select
        rtrim(codekbnid, ' 　')::varchar(3) as codekbnid,
        rtrim(key, ' 　')::varchar(2) as key,
        rtrim(value, ' 　')::varchar(20) as value,
        rtrim(timestamp, ' 　')::varchar(26) as timestamp,
        ldts,
        rank() over (partition by codekbnid, key order by ldts desc) aggkey
    from {{ ref('substr_ktrla025zz0kil3209') }}
)
select * from stg_codekubun
where aggkey = 1
