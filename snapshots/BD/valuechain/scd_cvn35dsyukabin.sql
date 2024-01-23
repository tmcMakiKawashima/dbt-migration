{% snapshot scd_cvn35dsyukabin%}

{{
    config(
        unique_key="concat_ws('-',
                    dlrcd,
                    syubetsu,
                    yusokbn,
                    syukkakyotenkbn,
                    sykikicd,
                    satflg,
                    haisyahhmm,
                    tekiyokaisiymd)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ref('stg_cvn35dsyukabin') }}

{% endsnapshot %}