/* v.56
    IN and NOT IN are used to check if a value matches in a list
    returns true or false
    syntax:
        value IN (val1, val2,...)
   */
select *
from movies
where movie_lang in ('English', 'Japanese', 'Chinese');
/* is equal to: */
select *
from movies
where movie_lang = 'English'
   or movie_lang = 'Japanese'
   or movie_lang = 'Chinese';

/* v.57
    BETWEEN and NOT BETWEEN are used to match against the rage of values inclusively (>= and <=)
    returns true or false
    syntax:
        value BETWEEN low AND high
   */
select *
from movies
where release_date between '1998-01-01' and '2002-01-01';
/* is equal to: */
select *
from movies
where release_date >= '1998-01-01'
  and release_date <= '2002-01-01';


/* v.58
    LIKE and ILIKE are used query data using "pattern matching"
    returns true or false
    both let you search for patterns using 2 special symbols:
        %  - any sequence of zero or more chars
        _  - any single char
    syntax:
        value LIKE pattern

   LIKE is case sensitive, ILIKE -- isn't

   Because LIKE and ILIKE search for patterns, performance on large databases can be slow.
   We can improve performance using indexes and more.
   */
select 'hello' LIKE 'hello';
select 'hello' LIKE 'h%';
select 'hello' LIKE '%e%';
select 'hello' LIKE '__llo';

/* get all actors names where first name starting with "A" */
select (first_name || ' ' || last_name) as "Full name"
from actors
where first_name like 'A%'
order by "Full name";

/* get all actors names where first name is 5 chars length */
select (first_name || ' ' || last_name) as "Full name"
from actors
where first_name like '_____'
order by "Full name";

/* v.59
   IS NULL, IS NOT NULL
    syntax:
        value IS NULL
*/
/* find list of actors with missing birth date */
select *
from actors
where date_of_birth is null;