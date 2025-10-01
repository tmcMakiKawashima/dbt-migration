with stg_tokuchokigojoho as (
    select
        mntkbn::varchar(1) as mntkbn,
        langkbn::varchar(3) as langkbn,
        ctlgcd::varchar(6) as ctlgcd,
        tokukbn::varchar(2) as tokukbn,
        tokukg::varchar(10) as tokukg,
        tokukgmei::varchar(280) as tokukgmei,
        tokukbnmei::varchar(80) as tokukbnmei,
        ldts,
        line_number,
        rank() over(partition by langkbn, ctlgcd, tokukbn, tokukg order by ldts desc, line_number desc) aggkey
    from {{source('snowpipe_db_valuechain', 'raw_k9jfv221')}}
)
select * exclude(mntkbn, line_number, aggkey) from stg_tokuchokigojoho where aggkey = 1 and mntkbn in ('C', 'U')