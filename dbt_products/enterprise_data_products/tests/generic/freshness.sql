{% test freshness(model, column_name, hour, skip_dayname) %}

    {{ config(severity = 'error') }}

    select * from  {{ model }}
     where datediff(hour, {{ column_name }}, current_timestamp)
           > iff(dayname(current_timestamp) in {{ skip_dayname }}, null, {{ hour }})

{% endtest %}