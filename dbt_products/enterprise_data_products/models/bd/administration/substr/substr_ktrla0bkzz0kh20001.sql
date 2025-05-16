with substr_ktrla0bkzz0kh20001 as (
    select
        substr(raw_data, 1, 7)::varchar(7) as empcd, -- 従業員・社外者コード
        substr(raw_data, 8, 1)::varchar(1) as prnno, -- 発行回数
        substr(raw_data, 9, 8)::varchar(8) as pubymd, -- 発行日
        substr(raw_data, 17, 8)::varchar(8) as endymd, -- 有効期限（マデ）
        substr(raw_data, 25, 4)::varchar(4) as location, -- ロケーション
        substr(raw_data, 29, 1)::varchar(1) as blackflg, -- ブラックフラグ
        substr(raw_data, 30, 1)::varchar(1) as wprnno, -- 最新ホワイト回数
        substr(raw_data, 31, 1)::varchar(1) as bprnno, -- 最新ブラック回数
        ldts::timestamp_ntz as ldts, -- B層取込日時
        line_number::number(38, 0) as line_number -- 行番号
    from {{ source('snowpipe_db_administration', 'raw_ktrla0bkzz0kh20001') }}
)
select *  from substr_ktrla0bkzz0kh20001
