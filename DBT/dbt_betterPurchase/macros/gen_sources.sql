--credit to https://github.com/dbt-labs/dbt-core/issues/1082#issuecomment-1046135861

{% macro gen_sources(database_name, schema_name) %}
    {% set sql %}
with "columns" as (
	select '- name: ' || lower(column_name) || '\n            description: "'|| lower(column_name) || ' (snowflake data type: '|| lower(DATA_TYPE) || ')"'

            as column_statement,
		table_name,
	    column_name
	from {{ database_name }}.information_schema.columns
	where table_schema = '{{ schema_name | upper }}'
),
tables as (
select table_name,
'
      - name: ' || lower(table_name) || '
        columns:
'    || listagg('          ' || column_statement || '\n') within group ( order by column_name ) as table_desc
from "columns"
group by table_name
)

select '# Generated automatically, please update after generation
version: 2

sources:
  - name: {{ schema_name }}
    description: you fill this out
    database: you fill this out. It might need some jinja logic.
    schema: {{ schema_name }}
    loader: where does this source originate from?
    loaded_at_field: what field indicates the last time a row was updated from the source?

    tables:' || listagg(table_desc) within group ( order by table_name )
from tables;

{% endset %}


    {%- call statement('generator', fetch_result=True) -%}
    {{ sql }}
    {%- endcall -%}

    {%- set states=load_result('generator') -%}
    {%- set states_data=states['data'] -%}
    {%- set states_status=states['response'] -%}

{# we log as warning so it's easier for jq to find in the output #}
    {% do exceptions.warn(states_data[0][0]) %}
{% endmacro %}
