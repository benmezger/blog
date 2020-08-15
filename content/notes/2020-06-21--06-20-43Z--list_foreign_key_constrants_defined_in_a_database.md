+++
title = "List Foreign key constrants defined in a database"
author = ["Ben Mezger"]
date = 2020-06-21T03:20:00-03:00
slug = "list_foreign_key_constrants_defined_in_a_database"
type = "posts"
draft = false
bookCollapseSection = true
+++

tags
: [Programming]({{< relref "2020-05-31--15-33-23Z--programming" >}}) [Code snippets]({{< relref "2020-05-31--17-28-55Z--code_snippets" >}}) [Postgres]({{< relref "2020-06-21--06-22-46Z--postgres" >}}) [Postgres]({{< relref "2020-06-21--06-22-46Z--postgres" >}})

View foreign key constrants defined in all databases

```sql
select kcu.table_schema || '.' ||kcu.table_name as foreign_table,
       '>-' as rel,
       rel_tco.table_schema || '.' || rel_tco.table_name as primary_table,
       string_agg(kcu.column_name, ', ') as fk_columns,
       kcu.constraint_name
from information_schema.table_constraints tco
join information_schema.key_column_usage kcu
          on tco.constraint_schema = kcu.constraint_schema
          and tco.constraint_name = kcu.constraint_name
join information_schema.referential_constraints rco
          on tco.constraint_schema = rco.constraint_schema
          and tco.constraint_name = rco.constraint_name
join information_schema.table_constraints rel_tco
          on rco.unique_constraint_schema = rel_tco.constraint_schema
          and rco.unique_constraint_name = rel_tco.constraint_name
where tco.constraint_type = 'FOREIGN KEY'
group by kcu.table_schema,
         kcu.table_name,
         rel_tco.table_name,
         rel_tco.table_schema,
         kcu.constraint_name
order by kcu.table_schema,
         kcu.table_name;
```

Returns

```text
+-----------------+-------+-----------------+--------------+-----------------------+
| foreign_table   | rel   | primary_table   | fk_columns   | constraint_name       |
|-----------------+-------+-----------------+--------------+-----------------------|
| public.profiles | >-    | public.users    | user_id      | profiles_user_id_fkey |
+-----------------+-------+-----------------+--------------+-----------------------+
SELECT 1
Time: 0.031s
```
