/*
    to_char(value,format)

        format is a string consisting of a symbolic code
        symbolic code dictionary can be found here:
        https://www.postgresql.org/docs/current/functions-formatting.html

        returns a value in TEXT data type



    Tip:
    TO_TIMESTAMP and TO_DATE exist to handle input formats that cannot be converted by simple casting.
    For most standard date/time formats, simply casting the source string to the required data type works,
    and is much easier.
    Similarly, TO_NUMBER is unnecessary for standard numeric representations.

*/
select to_char(100870, '9,99999');
select to_char(100870, '9,999');

select release_date,
       to_char(release_date, 'Dy, MM, YYYY')
from movies;

-- converting timestamp
select to_char(timestamp '2020-01-01 10:35:40', 'HH24:MI:SS');

-- adding dollar sign, for example
select movie_id,
       revenues_domestic,
       to_char(revenues_domestic, '$99999D99')
from movies_revenues;


/* to_number */
select to_number('1420.89', '9999.9');
-- formatting
select to_number('10625,78-', '99G999D99S');
select to_number('$1420,64', 'L9G999.99')