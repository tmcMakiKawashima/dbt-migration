{{
    config (
        post_hook=
            'create or replace hybrid table valuechain_db.public.stg_trimcodejoho (
                ctlgcd varchar(6) not null,
                syasyu_cd varchar(4) not null,
                hinban varchar(12) not null,
                trmcd varchar(2) not null,
                figno varchar(4) not null,
                ldts timestamp_ntz(9),
                constraint stg_trimcodejoho_ctlgcd_syasyu_cd_hinban_trmcd_figno_uk primary key (ctlgcd, syasyu_cd, hinban, trmcd, figno) rely
            ) as select * from {{this}}'
    )
}}
-- ハイブリッドテーブルに変更

with stg_trimcodejoho as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(ctlgcd, ' 　')::varchar(6) as ctlgcd, -- 右blank
        rtrim(syasyu_cd, ' 　')::varchar(4) as syasyu_cd, -- 右blank
        rtrim(hinban, ' 　')::varchar(12) as hinban, -- 右blank
        rtrim(trmcd, ' 　')::varchar(2) as trmcd, -- 右blank
        rtrim(figno, ' 　')::varchar(4) as figno, -- 右blank
        ldts, -- b層のldts
        rank() over (
                partition by
                    ctlgcd,
                    syasyu_cd,
                    hinban,
                    trmcd,
                    figno
                order by ldts desc
            ) aggkey
        from {{ref('substr_dv2a38b4')}})
select * exclude(aggkey, mntkbn) from stg_trimcodejoho where aggkey = 1 and mntkbn in ('C', 'U')