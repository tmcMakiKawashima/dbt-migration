{% macro create_masking_policy_sell_price_mask(node_database,node_schema) %}

create masking policy if not exists {{node_database}}.{{node_schema}}.sell_price_mask as (val number)
  returns number -> 9999999

{% endmacro %}