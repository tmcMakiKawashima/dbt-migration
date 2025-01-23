with
    kousei as (
        select
            ks.kohin
        from
            {{ ref("stg_kousei") }} as ks
        where
            trim(ks.jigyoutai) = ''
            and substr(ks.kohin,8,1) != '-'
    ),
    target_hinban as (
        select
            distinct ks.kohin as hinban
        from
            kousei as ks
            left outer join {{ ref("stg_hinban") }} as hb
                on ks.kohin = hb.hinban
        where
            hb.hinban is null
    ),
    array_hinban as (
        -- JSON element names are case-sensitive.
        select
            array_agg(
                object_construct(
                    'hinban', hinban
                )
            ) as hinbanList
        from
            target_hinban
    ),
    tmp_sms_api_parts_info_req_json as (
        -- JSON element names are case-sensitive.
        select
            parse_json(
                object_construct(
                    'reqData', hinbanList
                )::varchar
            ) as request_json
        from
            array_hinban
    )

select * from tmp_sms_api_parts_info_req_json