{% macro create_masking_policy_cost_mask(node_database,node_schema) %}

create masking policy if not exists {{node_database}}.{{node_schema}}.cost_mask as (val number)
  returns number -> 9999999

{% endmacro %}