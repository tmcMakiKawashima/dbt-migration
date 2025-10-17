with
    array_hinban as (
        -- JSON element names are case-sensitive.
        select
            array_agg(
                object_construct(
                    'hinban', hinban
                )
            ) as hinbanList
        from
            {{ ref('tmp_sms_api_parts_info_tartget_hinban') }}
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