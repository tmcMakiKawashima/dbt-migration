{{
  config(
    materialized ='incremental',
    unique_key = ['jigyoutaicd', 'kouku', 'renban', 'syasyu', 'siyoubui', 'oyahin', 'gc', 'kohin', 'ruibetu', 'kanrikt', 'ktkigo', 'jikt01', 'jikt02', 'jikt03', 'jikt04', 'jikt05', 'jikt06', 'jikt07', 'jikt08', 'jikt09', 'jikt10', 'jikt11', 'jikt12', 'jikt13', 'jikt14', 'oyakt', 'tck', 'naigaikbn', 'tehaishogokey', 'idline', 'unitkbn', 'nisugata', 'oderkbn', 'shimukecd', 'shimukekouku', 'multisspkbn', 'blkcd'],
    incremental_strategy = 'merge'
  )
}}

with stg_hinban_hikiate_koumusms as (
    select
        jigyoutaicd::varchar(2) as jigyoutaicd, --事業体コード
        kouku::varchar(1) as kouku, --工区
        renban::varchar(1) as renban, --連番
        syasyu::varchar(4) as syasyu, --車種コード
        siyoubui::varchar(10) as siyoubui, --使用部位
        oyahin::varchar(10) as oyahin, --親品番／使用部位／ＢＬＫ
        gc::varchar(2) as gc, --グループコード
        kohin::varchar(10) as kohin, --子品番／使用部位／ＢＬＫ
        ruibetu::varchar(2) as ruibetu, --類別
        smskosu::varchar(3) as smskosu, --ＳＭＳ使用個数
        psmskosu::varchar(3) as psmskosu, --Ｐ－ＳＭＳ使用個数
        hikikosu::varchar(3) as hikikosu, --引当個数
        sentaku::varchar(2) as sentaku, --選択符号
        com11umukbn::varchar(1) as com11umukbn, --11コメント有無区分
        com15umukbn::varchar(1) as com15umukbn, --15コメント有無区分
        com16umukbn::varchar(1) as com16umukbn, --16コメント有無区分
        com18umukbn::varchar(1) as com18umukbn, --18コメント有無区分
        taisyogaikbn::varchar(1) as taisyogaikbn, --対象外区分
        ktchk::varchar(1) as ktchk, --工程チェック
        rtrim(kanrikt)::varchar(6) as kanrikt, --管理工程
        rtrim(ktkigo)::varchar(2) as ktkigo, --工程記号
        rtrim(jikt01)::varchar(6) as jikt01, --自工程工程符号１
        rtrim(jikt02)::varchar(6) as jikt02, --自工程工程符号２
        rtrim(jikt03)::varchar(6) as jikt03, --自工程工程符号３
        rtrim(jikt04)::varchar(6) as jikt04, --自工程工程符号４
        rtrim(jikt05)::varchar(6) as jikt05, --自工程工程符号５
        rtrim(jikt06)::varchar(6) as jikt06, --自工程工程符号６
        rtrim(jikt07)::varchar(6) as jikt07, --自工程工程符号７
        rtrim(jikt08)::varchar(6) as jikt08, --自工程工程符号８
        rtrim(jikt09)::varchar(6) as jikt09, --自工程工程符号９
        rtrim(jikt10)::varchar(6) as jikt10, --自工程工程符号１０
        rtrim(jikt11)::varchar(6) as jikt11, --自工程工程符号１１
        rtrim(jikt12)::varchar(6) as jikt12, --自工程工程符号１２
        rtrim(jikt13)::varchar(6) as jikt13, --自工程工程符号１３
        rtrim(jikt14)::varchar(6) as jikt14, --自工程工程符号１４
        rtrim(oyakt)::varchar(6) as oyakt, --親工程工程符号
        seppenk::varchar(10) as seppenk, --設変№カラ
        seppenm::varchar(10) as seppenm, --設変№マデ
        shinkyu::varchar(4) as shinkyu, --新旧区分
        rtrim(tck)::varchar(8) as tck, --工場Ｔ／Ｃカラ
        tcm::varchar(8) as tcm, --工場Ｔ／Ｃマデ
        rtrim(naigaikbn)::varchar(1) as naigaikbn, --内外区分
        rtrim(tehaishogokey)::varchar(6) as tehaishogokey, --手配照合キー
        rtrim(idline)::varchar(5) as idline, --ｱｲﾃﾞﾝﾄﾗｲﾝ/LOT符号
        rtrim(unitkbn)::varchar(1) as unitkbn, --ユニット区分
        rtrim(nisugata)::varchar(1) as nisugata, --荷姿
        hkbn::varchar(1) as hkbn, --比率条件区分
        hkosu::varchar(3) as hkosu, --比率条件比率／個数
        dkbn::varchar(1) as dkbn, --代表品番区分
        dhinban::varchar(10) as dhinban, --代表品番品番
        druibetu::varchar(2) as druibetu, --代表品番類別
        dkosu::varchar(3) as dkosu, --代表品番個数
        com::varchar(20) as com, --工場コメント
        rtrim(oderkbn)::varchar(1) as oderkbn, --オーダー区分
        rtrim(shimukecd)::varchar(3) as shimukecd, --仕向地ｺｰﾄﾞ
        rtrim(shimukekouku)::varchar(1) as shimukekouku, --現地工区
        togosyasyu::varchar(4) as togosyasyu, --統合車種ｺｰﾄﾞ
        konpoukouku::varchar(1) as konpoukouku, --梱包工区
        setblukkbn::varchar(1) as setblukkbn, --セット／バルク区分
        sentakuumuopm::varchar(1) as sentakuumuopm, --選択符号(OPM)有無
        rtrim(multisspkbn)::varchar(1) as multisspkbn, --ﾏﾙﾁｿｰｽSSP区分
        jyohomotokbn::varchar(1) as jyohomotokbn, --情報元区分
        hosenyouflg::varchar(1) as hosenyouflg, --補給専用ＦＬＧ
        hosiyoubui::varchar(10) as hosiyoubui, --所番地
        seiyakuumukbn::varchar(1) as seiyakuumukbn, --制約条件有無区分
        tyofuku::varchar(10) as tyofuku, --重複記載
        rtrim(blkcd)::varchar(10) as blkcd, --BLKｺｰﾄﾞ
        unitcd::varchar(4) as unitcd, --ﾕﾆｯﾄｺｰﾄﾞ
        torokujunk::varchar(9) as torokujunk, --登録/生認順カラ
        torokujunopmk::varchar(9) as torokujunopmk, --登録/生認順ｶﾗ(海生)
        torokujunm::varchar(9) as torokujunm, --登録/生認順マデ
        torokujunopmm::varchar(9) as torokujunopmm, --登録/生認順ﾏﾃﾞ(海生)
        sakuseitime::varchar(16) as sakuseitime, --作成日時
        kousintime::varchar(16) as kousintime, --更新日時
        userid::varchar(10) as userid, --更新者ＩＤ
        _fivetran_synced::timestamp_ntz as ldts, --B層取込日時
        row_number() over(partition by 
            jigyoutaicd,
            kouku,
            renban,
            syasyu,
            siyoubui,
            oyahin,
            gc,
            kohin,
            ruibetu,
            kanrikt,
            ktkigo,
            jikt01,
            jikt02,
            jikt03,
            jikt04,
            jikt05,
            jikt06,
            jikt07,
            jikt08,
            jikt09,
            jikt10,
            jikt11,
            jikt12,
            jikt13,
            jikt14,
            oyakt,
            tck,
            naigaikbn,
            tehaishogokey,
            idline,
            unitkbn,
            nisugata,
            oderkbn,
            shimukecd,
            shimukekouku,
            multisspkbn,
            blkcd
        order by kousintime desc, ldts desc, _fivetran_id desc) aggkey
    from {{ source('fivetran_database_oraclerds_lzdata01_sms_dxpfy2d','raw_cb403hikiate') }}
    where _fivetran_deleted = false
    {% if is_incremental() %}
        and ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select * exclude(aggkey) from stg_hinban_hikiate_koumusms
where aggkey = 1