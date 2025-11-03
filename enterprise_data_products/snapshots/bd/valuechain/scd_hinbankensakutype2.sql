{% snapshot scd_hinbankensakutype2 %}

{{
    config(
        unique_key="concat_ws('-',
                    langkbn,
                    ctlgcd,
                    hinmeicd,
                    syasyu_cd,
                    hinban,
                    kosu,
                    jissijikik,
                    jissijikim,
                    siyoptno,
                    epckataptno,
                    kiricdk,
                    kiricdm,
                    trmcdmlt,
                    clrcdmlt,
                    tkstkbn,
                    hktkgaikbn,
                    hosemhin)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hinbankensakutype2') }}

{% endsnapshot %}