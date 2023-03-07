/* 1. SELECT statement returns rows in unspecified order
   ORDER BY clause allows u to sort it
   syntax:
        SELECT
            column_list
        FROM table_name
        ORDER BY
            sort_expr_1 [ASC | DESC],
            ...
            sort_expr_n [ASC | DESC];

   ASC is default order direction

   ORDER BY can be run with multiple sort columns (or expr)
*/

select movie_id     "id",
       movie_name   "Name",
       release_date "Released"
from movies
order by release_date desc;


select age_certificate "id",
       movie_name      "Name",
       release_date    "Released"
from movies
order by age_certificate desc,
         movie_name;

/* v.41
    ORDER BY with expression
    ORDER BY can be used with aliases */

select first_name,
       length(first_name) as len
from actors
order by len DESC;

/* v.42
   ORDER BY can be sorted by column number (if specific columns selected, not *) */
select first_name,
       last_name,
       date_of_birth
from actors
order by 1,
         3 DESC

/* v.43
   ORDER BY with NULL values
   when you sort rows that contains NULL values you can specify their order
   with NULLS FIRST and NULLS LAST options of the ORDER BY clause
   syntax:
        SELECT
            column_list
        FROM table_name
        ORDER BY
            sort_expr [ASC | DESC] [NULLS FIRST | NULLS LAST];

   ASC: NULLS LAST is default
   DESC: NULLS FIRST is default
*/