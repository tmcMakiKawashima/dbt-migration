with
    stg_riyosyasyutekiyonengetsusyameikatashiki as (
        select
            syamei as cd_model_nm, -- 車名コード
            dd_pubbnd_trmfrym, -- 車種世代適用年月FROM年月
            kosyo_kt as cd_fll_mdl, -- 呼称型式コード
            cd_vtype, -- 車型コード
            cd_pubbnd -- 車種世代コード
        from {{ ref('stg_riyosyasyutekiyonengetsusyameikatashiki') }} -- 利用車種世代適用年月車名型式テーブル
    ),
    stg_riyosyasyusedaitekiyonengetsu as (
        select
            my as dd_mdly, -- モデルイヤー
            cd_pubbnd, -- 車種世代コード
            dd_pubbnd_trmfrym -- 車種世代適用年月FROM年月
        from {{ ref('stg_riyosyasyusedaitekiyonengetsu') }} -- 利用車種世代適用年月テーブル
    ),
    stg_riyopubmaster2 as (
        select
            no_pub_termfrid, -- パブ適用FROM連番
            no_pub, -- パブNo
            no_ofr_alt_pub, -- 提供子パブNo
            kb_lang, -- 言語区分
            kb_pub_type, -- 提供パブ種別区分
            kb_cont_type, -- コンテンツ種別区分
            cd_trgt, -- 仕向コード
            cd_brand, -- ブランドコード
            dt_server_opn, -- 情報公開サーバ公開実施日
            kb_pub_form, -- パブ形式区分
            cd_pubbnd, -- 車種世代コード
            dd_pub_trmfrym -- パブ適用FROM年月
        from {{ ref('stg_riyopubmaster2')}} -- 利用パブマスタ２
    )
select
    stg_riyosyasyutekiyonengetsusyameikatashiki.*,
    stg_riyosyasyusedaitekiyonengetsu.* exclude (cd_pubbnd, dd_pubbnd_trmfrym),
    stg_riyopubmaster2.* exclude (cd_pubbnd, dd_pub_trmfrym)
from stg_riyosyasyutekiyonengetsusyameikatashiki
inner join stg_riyosyasyusedaitekiyonengetsu
  on stg_riyosyasyutekiyonengetsusyameikatashiki.cd_pubbnd = stg_riyosyasyusedaitekiyonengetsu.cd_pubbnd
 and stg_riyosyasyutekiyonengetsusyameikatashiki.dd_pubbnd_trmfrym = stg_riyosyasyusedaitekiyonengetsu.dd_pubbnd_trmfrym
inner join stg_riyopubmaster2
  on stg_riyosyasyutekiyonengetsusyameikatashiki.cd_pubbnd = stg_riyopubmaster2.cd_pubbnd
 and stg_riyosyasyutekiyonengetsusyameikatashiki.dd_pubbnd_trmfrym = stg_riyopubmaster2.dd_pub_trmfrym