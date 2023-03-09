/* v.54
   LIMIT limits output amount
   OFFSET optionally an be added
   syntax:
    SELECT col_name
    FROM table_name
    LIMIT number OFFSET from_number
*/
select *
from movies
order by movie_length desc
limit 5;

select *
from directors
where nationality = 'American'
order by date_of_birth
limit 5 offset 2;

/* v.55
   OFFSET FETCH is functionally equivalent to the LIMIT clause
   syntax:
    OFFSET start { ROW | ROWS }
    FETCH { FIRST | NEXT } [row_count] { ROW | ROWS } ONLY

    start is int > 0
    if start > number of rows in the result set, no rows are returned

   OFFSET is optional

   The ROW and ROWS, FIRST and NEXT are the synonyms. Therefore, you can use them interchangeably.
   */
select *
from movies fetch first 2 row only;
/*is equal to */
select *
from movies fetch next 2 rows only;

/* fetch top 5 movies by length after the longest one */
select *
from movies
order by movie_length desc
offset 1 row fetch next 5 rows only;

/* get top 5 youngest female actors*/
select *
from actors
where gender = 'F'
order by date_of_birth desc fetch first 5 rows only;