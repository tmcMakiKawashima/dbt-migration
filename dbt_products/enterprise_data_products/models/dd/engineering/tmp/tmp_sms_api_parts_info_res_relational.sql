with
    varchar_to_json as (
        select
            parse_json(response_json) as response_json
        from
            {{ source('engineering_db_public', 'raw_tmp_sms_api_parts_info_res_json') }}
    ),
    tmp_sms_api_parts_info_res_relational as (
        -- JSON element names are case-sensitive.
        select
            flattened_resData.value:hinban::varchar(10) as hinban
            , flattened_resData.value:kekka::varchar(1) as kekka
            , flattened_resData.value:minor::varchar(2) as minor
            , flattened_resData.value:hinmei::varchar(120) as hinmei
            , flattened_resData.value:syasyu::varchar(4) as syasyu
            , flattened_resData.value:zaisitu::varchar(41) as zaisitu
            , flattened_resData.value:itaatu::varchar(40) as itaatu
            , flattened_resData.value:zu::varchar(1) as zu
            , flattened_resData.value:zu2d::varchar(1) as zu2d
            , flattened_resData.value:zu3d::varchar(1) as zu3d
            , flattened_resData.value:com21::varchar(54) as com21
            , flattened_resData.value:com22::varchar(54) as com22
            , flattened_resData.value:com23::varchar(54) as com23
            , flattened_resData.value:com24::varchar(54) as com24
            , flattened_resData.value:com29::varchar(54) as com29
            , '' as com30
            , flattened_resData.value:seppen::varchar(10) as seppen
            , flattened_resData.value:torokutime::varchar(16) as torokutime
        from
            varchar_to_json
            , lateral flatten(input => response_json:resData) as flattened_resData
    )

select * from tmp_sms_api_parts_info_res_relational