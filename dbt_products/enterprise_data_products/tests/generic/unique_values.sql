{% test unique_values(model) %}

    {{ config(fail_calc = "cnt") }}

    select b.cnt - a.cnt as cnt
    from
    (
        select
            count(*) as cnt
        from (
            select
                *
            from {{ model }}
            group by all
        )
    ) a, (
        select
            count(*) as cnt
        from {{ model }}
    ) b

{% endtest %}