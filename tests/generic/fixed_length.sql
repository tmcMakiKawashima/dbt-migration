{% test fixed_length(model, column_name, length) %}

    select *
    from {{ model }}
    where length( {{ column_name }} ) != {{ length }}

{% endtest %}