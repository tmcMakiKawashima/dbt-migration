{% test freshness(model, column_name, hour, skip_dayname) %}

    {{ config(severity = 'error') }}
    select max({{ column_name }}) as max_col from {{ model }}
    having datediff(hour, max({{ column_name }}), current_timestamp)
           > iff(dayname(current_timestamp) in {{ skip_dayname }}, null, {{ hour }})
           
{% endtest %}