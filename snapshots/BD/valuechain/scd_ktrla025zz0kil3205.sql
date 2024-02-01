{% snapshot scd_ktrla025zz0kil3205 %}

{{
    config(
        unique_key="concat_ws('-',
                    mtkbn,
                    strno,
                    dtlno,
                    sainyukodate,
                    choushikekkacd,
                    genincd,
                    hosyokbn,
                    hosyoseikyusyono,
                    fuguaisaigenkbn,
                    geninname)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_ktrla025zz0kil3205') }}

{% endsnapshot %}
