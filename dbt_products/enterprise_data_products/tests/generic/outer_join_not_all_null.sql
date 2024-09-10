{% test outer_join_not_all_null(model, column_name) %}

    {{ config(fail_calc = "cnt") }}

    select IFF(count(*) = 0, 1, 0) as cnt
    from {{ model }}
    where {{ column_name }} is not null

{% endtest %}