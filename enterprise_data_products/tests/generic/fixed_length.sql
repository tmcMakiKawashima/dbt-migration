{% test fixed_length(model, column_name, length) %}

    {{ config(severity = 'error') }}

    select *
    from {{ model }}
    where length( {{ column_name }} ) != {{ length }}

{% endtest %}