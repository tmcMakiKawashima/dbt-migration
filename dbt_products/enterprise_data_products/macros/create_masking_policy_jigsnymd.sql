{% macro create_masking_policy_jigsnymd_mask(node_database,node_schema) %}

create masking policy if not exists {{node_database}}.{{node_schema}}.jigsnymd_mask AS (val string) 
  returns string ->
      case when current_role() in ('dbt_role') then val 
      else '********'
      end

{% endmacro %}