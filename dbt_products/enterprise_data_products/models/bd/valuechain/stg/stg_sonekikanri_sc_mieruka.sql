with stg_sonekikanri_sc_mieruka as (
    select
        mntkbn::varchar(1) as mntkbn,
        thyono::varchar(4) as thyono,
        jissekiym::varchar(6) as jissekiym,
        hinban::varchar(20) as hinban,
        distfd::varchar(7) as distfd,
        renban::varchar(4) as renban,
        daihyoudist::varchar(5) as daihyoudist,
        pricls::varchar(3) as pricls,
        hinmkcd::varchar(4) as hinmkcd,
        tukacd::varchar(1) as tukacd,
        syokokukbn::varchar(1) as syokokukbn,
        tokuteikokukbn::varchar(1) as tokuteikokukbn,
        kodankokukbn::varchar(1) as kodankokukbn,
        to_decimal(to_decimal(hnknhrtitiritu)/10,3,1)::decimal(3,1) as hnknhrtitiritu,
        to_decimal(to_decimal(hankanrhinhan)/10,3,1)::decimal(3,1) as hankanrhinhan,
        to_decimal(to_decimal(jisseiwsratehx)/100,5,2)::decimal(5,2) as jisseiwsratehx,
        to_decimal(to_decimal(zenteiwsratehx)/100,5,2)::decimal(5,2) as zenteiwsratehx,
        to_decimal(to_decimal(skutisenhannka)/100,5,2)::decimal(5,2) as skutisenhannka,
        to_decimal(to_decimal(jssiurgknh15)/100,15,2)::decimal(15,2) as jssiurgknh15,
        to_decimal(to_decimal(zeurikinhanka)/100,15,2)::decimal(15,2) as zeurikinhanka,
        to_decimal(uriagekosuhanka,11,0)::decimal(11,0) as uriagekosuhanka,
        to_decimal(kijungenka9hanx,9,0)::decimal(9,0) as kijungenka9hanx,
        to_decimal(tankahanka,9,0)::decimal(9,0) as tankahanka,
        to_decimal(to_decimal(sogenka1itirihn)/100,15,2)::decimal(15,2) as sogenka1itirihn,
        to_decimal(to_decimal(sogenka2hinmohn)/100,15,2)::decimal(15,2) as sogenka2hinmohn,
        to_decimal(to_decimal(jisseisnek1hn)/100,15,2)::decimal(15,2) as jisseisnek1hn,
        to_decimal(to_decimal(jisseisnek2hn)/100,15,2)::decimal(15,2) as jisseisnek2hn,
        to_decimal(to_decimal(zentsonekig1han)/100,15,2)::decimal(15,2) as zentsonekig1han,
        to_decimal(to_decimal(zentsonekig2han)/100,15,2)::decimal(15,2) as zentsonekig2han,
        dairitenmei::varchar(12) as dairitenmei,
        tiikicd3::varchar(3) as tiikicd3,
        rgncd3::varchar(3) as rgncd3,
        setteidistfd::varchar(7) as setteidistfd,
        to_decimal(to_decimal(ararigaku1han)/100,15,2)::decimal(15,2) as ararigaku1han,
        to_decimal(to_decimal(ararigaku2han)/100,15,2)::decimal(15,2) as ararigaku2han,
        to_decimal(hankanhihanx,15,0)::decimal(15,0) as hankanhihanx,
        to_decimal(genkagakuhanka,15,0)::decimal(15,0) as genkagakuhanka,
        kyokuflg::varchar(2) as kyokuflg,
        filler::varchar(43) as filler,
        mtuserid::varchar(16) as mtuserid,
        try_to_timestamp_ntz(mttime,'YYYYMMDDHH24MISSFF') as mttime,
        ldts,
        row_number() over (
            partition by 
                thyono,jissekiym,hinban,distfd,renban
            order by line_number desc
        ) aggkey
        from {{ ref('substr_ktrla01vzz0kvq00m8') }}
        where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvq00m8') }})
)
select * exclude(aggkey)
from stg_sonekikanri_sc_mieruka
where aggkey = 1