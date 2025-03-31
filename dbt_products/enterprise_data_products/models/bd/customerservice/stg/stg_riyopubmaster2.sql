{{
    config (
        post_hook=
            'create or replace hybrid table customerservice_db.public.stg_riyopubmaster2 (
                no_ofr_alt_pub varchar(16) not null,
                cd_pubbnd varchar(6) not null,
                no_pub varchar(10),
                no_pub_termfrid varchar(3),
                kb_lang varchar(1),
                dd_pub_trmfrym varchar(6),
                kb_pub_type varchar(1),
                kb_cont_type varchar(2),
                cd_trgt varchar(1),
                cd_brand varchar(2),
                dt_server_opn varchar(12),
                kb_pub_form varchar(1),
                ldts timestamp_ntz(9),
                constraint stg_riyopubmaster2_no_ofr_alt_pub_cd_pubbnd_uk primary key (no_ofr_alt_pub, cd_pubbnd) rely
            ) as select * from {{this}}'
    )
}}
--ハイブリッドテーブルに変更

with
    stg_riyopubmaster2 as (
        select
            rtrim(no_ofr_alt_pub,' 　')::varchar(16) as no_ofr_alt_pub, -- 右blank
            rtrim(cd_pubbnd,' 　')::varchar(6) as cd_pubbnd, -- 右blank
            no_pub::varchar(10) as no_pub, 
            no_pub_termfrid::varchar(3) as no_pub_termfrid, 
            kb_lang::varchar(1) as kb_lang, 
            rtrim(dd_pub_trmfrym,' 　')::varchar(6) as dd_pub_trmfrym, -- 右blank
            kb_pub_type::varchar(1) as kb_pub_type, 
            kb_cont_type::varchar(2) as kb_cont_type, 
            cd_trgt::varchar(1) as cd_trgt, 
            cd_brand::varchar(2) as cd_brand, 
            dt_server_opn::varchar(12) as dt_server_opn, 
            kb_pub_form::varchar(1) as kb_pub_form, 
            ldts, -- b層のldts
            line_number,
            rank() over (partition by no_ofr_alt_pub, cd_pubbnd order by ldts desc, line_number desc) aggkey
        from {{ref('substr_ktrla05azz0kvw0001')}}
    ),
    stg_syasyusedaisakujo as (
        select
            cd_pubbnd
        from {{ ref('stg_syasyusedaisakujo') }} -- 車種世代削除情報
    )
select stg_riyopubmaster2.* exclude(aggkey, line_number) from stg_riyopubmaster2
left outer join stg_syasyusedaisakujo on stg_riyopubmaster2.cd_pubbnd = stg_syasyusedaisakujo.cd_pubbnd
where stg_syasyusedaisakujo.cd_pubbnd is null and aggkey = 1