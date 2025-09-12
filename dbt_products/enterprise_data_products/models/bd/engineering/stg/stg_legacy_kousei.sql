with stg_legacy_kousei as (
    select
        jigyoutai::varchar(2) as jigyoutai,
        syasyu32::varchar(2) as syasyu32,
        syasyu::varchar(4) as syasyu,
        siyoubui::varchar(10) as siyoubui,
        oyahin::varchar(10) as oyahin,
        rtrim(gc, ' 　')::varchar(2) as gc, -- 右ブランク
        kohin::varchar(10) as kohin,
        rtrim(kosu, ' 　')::varchar(3) as kosu, -- 右ブランク
        rtrim(sentaku, ' 　')::varchar(2) as sentaku, -- 右ブランク
        sakuseikbn::varchar(2) as sakuseikbn,
        ktkbn::varchar(2) as ktkbn,
        ktchk::varchar(1) as ktchk,
        ktkosu::varchar(2) as ktkosu,
        jikt01::varchar(6) as jikt01,
        jikt02::varchar(6) as jikt02,
        jikt03::varchar(6) as jikt03,
        jikt04::varchar(6) as jikt04,
        jikt05::varchar(6) as jikt05,
        jikt06::varchar(6) as jikt06,
        jikt07::varchar(6) as jikt07,
        jikt08::varchar(6) as jikt08,
        jikt09::varchar(6) as jikt09,
        jikt10::varchar(6) as jikt10,
        jikt11::varchar(6) as jikt11,
        jikt12::varchar(6) as jikt12,
        jikt13::varchar(6) as jikt13,
        jikt14::varchar(6) as jikt14,
        oyakt::varchar(6) as oyakt,
        comno::varchar(7) as comno,
        zyoho1::varchar(20) as zyoho1,
        zyoho2::varchar(20) as zyoho2,
        zyoho3::varchar(4) as zyoho3,
        torokujunk::varchar(9) as torokujunk,
        torokujunm::varchar(9) as torokujunm,
        zisikyuflg::varchar(1) as zisikyuflg,
        tck::varchar(8) as tck,
        tcm::varchar(8) as tcm,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts,
        row_number() over(partition by jigyoutai, syasyu32, syasyu, siyoubui, oyahin, gc, kohin, kosu,
                          sentaku, sakuseikbn, ktkbn, ktchk, ktkosu, jikt01, jikt02, jikt03, jikt04, jikt05,
                          jikt06, jikt07, jikt08, jikt09, jikt10, jikt11, jikt12, jikt13, jikt14, oyakt, comno,
                          zyoho1, zyoho2, zyoho3, torokujunk, torokujunm, zisikyuflg, tck, tcm
        order by mttime desc) aggkey
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d','raw_cyl15kousei') }}
    where _fivetran_deleted = 'false'
)
select * exclude(aggkey) from stg_legacy_kousei
where aggkey = 1