{{
  config(
    materialized='incremental',
    unique_key = ['employee_cd','syozoku_cd_honrai'],
    incremental_strategy = 'append',
    pre_hook=[
      "{{ dbt_snow_mask.create_masking_policy('models')}}",
      "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
      "
    ],
    post_hook=[
      "{{ dbt_snow_mask.apply_masking_policy('models') }}"
    ]
  )
}}

with stg_employee_kenmu as (
    select
        jcd::varchar(7) as employee_cd, -- 従業員コード
        nyscanflg::varchar(1) as nyscanflg, -- 入社キャンセルフラグ
        hnkgkjnam::varchar(20) as hnkgkjnam, -- 変更後漢字氏名
        hnkgknnam::varchar(20) as hnkgknnam, -- 変更後カナ氏名
        hnkgrmnam::varchar(50) as hnkgrmnam, -- 変更後ローマ字氏名
        jigsnymd::varchar(8) as jigsnymd, -- 従業員生年月日
        jigseb::varchar(1) as jigseb, -- 従業員性別
        ssktdfkcd::varchar(2) as ssktdfkcd, -- 都道府県コード
        knicd::varchar(3) as knicd, -- 国コード
        nysymd::varchar(8) as nysymd, -- 入社年月日
        ntinysy::varchar(4) as ntinysy, -- 認定入社年
        taiymd::varchar(8) as taiymd, -- 退社年月日
        syoymd::varchar(8) as syoymd, -- 採用年月日
        tskymd::varchar(8) as tskymd, -- 退職年月日
        jigkbncd::varchar(1) as jigkbncd, -- 従業員区分コード
        nysketcd::varchar(1) as nysketcd, -- 入社形態コード
        kznsu::varchar(2) as kznsu, -- 勤続年数
        gakrei::varchar(2) as gakrei, -- 学令
        nnjgrk::varchar(6) as nnjgrk, -- 年次学歴
        jhnysf::varchar(1) as jhnysf, -- 自販入社フラグ
        svphjflg::varchar(1) as svphjflg, -- ＳＶＰ補助フラグ
        n2nkykrknis::number(3, 1) as n2nkykrknis, -- 一昨年度年休繰越日数
        n1nkykrknis::number(3, 1) as n1nkykrknis, -- 昨年度年休繰越日数
        hnednkyfynis::number(3, 1) as hnednkyfynis, -- 本年度年休付与日数
        hgsumf::varchar(1) as hgsumf, -- 配偶者有無フラグ
        sybknrcd::varchar(1) as sybknrcd, -- 疾病管理コード
        kskf::varchar(1) as kskf, -- 休職フラグ
        hriszstaymd::varchar(8) as hriszstaymd, -- 本来所属有効開始年月日
        hriszcd::varchar(5) as syozoku_cd_honrai, -- 本来所属コード
        bucd::varchar(2) as bucd, -- 部コード
        sskbunam1::varchar(30) as sskbunam1, -- 正式部名称１
        sskbunam2::varchar(30) as sskbunam2, -- 正式部名称２
        rskbunam::varchar(6) as rskbunam, -- 略式部名称
        bmncd::varchar(2) as bmncd, -- 部門コード
        buno::varchar(3) as buno, -- 部ＮＯ
        ykinno::varchar(2) as ykinno, -- 役員ＮＯ
        stkcd::varchar(3) as stkcd, -- 室課コード
        sskstknam::varchar(30) as sskstknam, -- 正式室課名称
        rskstknam::varchar(6) as rskstknam, -- 略式室課名称
        stkno::varchar(2) as stkno, -- 室課ＮＯ
        stkkbncd::varchar(1) as stkkbncd, -- 室課区分コード
        kkrgcd::varchar(4) as kkrgcd, -- 係Ｇコード
        sskkkrgnam::varchar(30) as sskkkrgnam, -- 正式係Ｇ名称
        rskkrgnam::varchar(6) as rskkrgnam, -- 略式係Ｇ名称
        kkrgno::varchar(2) as kkrgno, -- 係ＧＮＯ
        kkrgkbncd::varchar(1) as kkrgkbncd, -- 係Ｇ区分コード
        kmcd::varchar(5) as kmcd, -- 組コード
        knmtyocd::varchar(4) as knmtyocd, -- 勤務態様コード
        buaibmncd::varchar(2) as buaibmncd, -- 歩合部門コード
        shopcd::varchar(3) as shopcd, -- ショップコード
        ltszcdymd::varchar(8) as ltszcdymd, -- 最新所属コード開始年月日
        ltszcd::varchar(5) as syozoku_cd_latest, -- 最新所属コード
        sbucd::varchar(2) as sbucd, -- 最新所属＿部コード
        ssskbunam1::varchar(30) as ssskbunam1, -- 最新所属＿正式部名称１
        ssskbunam2::varchar(30) as ssskbunam2, -- 最新所属＿正式部名称２
        srskbunam::varchar(6) as srskbunam, -- 最新所属＿略式部名称
        sstkcd::varchar(3) as sstkcd, -- 最新所属＿室課コード
        ssskstknam::varchar(30) as ssskstknam, -- 最新所属＿正式室課名称
        srskstknam::varchar(6) as srskstknam, -- 最新所属＿略式室課名称
        skkrgcd::varchar(4) as skkrgcd, -- 最新所属＿係Ｇコード
        ssskkkrgnam::varchar(30) as ssskkkrgnam, -- 最新所属＿正式係Ｇ名称
        srskkrgnam::varchar(6) as srskkrgnam, -- 最新所属＿略式係Ｇ名称
        loccd::varchar(3) as loccd, -- ロケーションコード
        gbustaym::varchar(6) as gbustaym, -- 現部開始年月
        kaisyacd::varchar(5) as kaisyacd, -- 会社コード
        rskksnam::varchar(6) as rskksnam, -- 略式部＿会社名称
        kytjjcd::varchar(2) as kytjjcd, -- 拠点人事コード
        sykicd::varchar(3) as sykicd, -- 職位コード
        sykinam::varchar(32) as sykinam, -- 職位名称
        mnstkbncd::varchar(1) as mnstkbncd, -- マネスタ区分コード
        slkbncd::varchar(1) as slkbncd, -- ＳＬ区分コード
        nowbnycd::varchar(3) as nowbnycd, -- 現在分野コード
        hribnycd::varchar(3) as hribnycd, -- 本来分野コード
        sykscd::varchar(2) as sykscd, -- 職種コード
        stptkbncd::varchar(2) as stptkbncd, -- 嘱託パート区分コード
        skkstaymd::varchar(8) as skkstaymd, -- 昇格有効開始年月日
        skktkkbncd::varchar(1) as skktkkbncd, -- 資格体系区分コード
        skkcd::varchar(2) as skkcd, -- 資格コード
        mnstskkkbncd::varchar(1) as mnstskkkbncd, -- マネスタ昇格区分コード
        tgntkystaymd::varchar(8) as tgntkystaymd, -- 賃金等級有効開始年月日
        tgntkycd::varchar(3) as tgntkycd, -- 賃金等級コード
        sytkyf::varchar(1) as sytkyf, -- 昇降等級フラグ
        grkcd::varchar(2) as grkcd, -- 学歴コード
        stgymd::varchar(6) as stgymd, -- 卒業年月
        gkocd::varchar(6) as gkocd, -- 学校コード
        kjgkonam1::varchar(60) as kjgkonam1, -- 漢字学校名１
        gkbnam::varchar(40) as gkbnam, -- 学部名称
        gkkanam::varchar(40) as gkkanam, -- 学科名称
        snkocd::varchar(2) as snkocd, -- 専攻コード
        kjsnknam::varchar(40) as kjsnknam, -- 漢字専攻名
        snkoknam::varchar(40) as snkoknam, -- 専攻科名称
        syaneknjknymdmax::varchar(8) as syaneknjknymdmax, -- 最高社内英検受験年月日
        syaneknkymax::varchar(1) as syaneknkymax, -- 最高社内英検級
        syaneknjknymdnew::varchar(8) as syaneknjknymdnew, -- 最新社内英検受験年月日
        syaneknkynew::varchar(1) as syaneknkynew, -- 最新社内英検級
        gymkbncd::varchar(2) as gymkbncd, -- 業務区分コード
        ldts::timestamp as ldts, -- B層取込日時
        row_number() over(partition by employee_cd, syozoku_cd_honrai
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20079') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20079')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_employee_kenmu where aggkey = 1
