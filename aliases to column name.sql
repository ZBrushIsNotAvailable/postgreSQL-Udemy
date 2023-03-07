/* 1. ADDING ALIASES TO COLUMNS (FIELDS) NAMES
   syntax:
       SELECT column AS alias_name FROM table_name

    use to:
        make fields names more readable,
        make queries to be more presentable and readable
   */

 /* by default aliases will be in lowercase and not support spaces

   we can use double quotes to make alias fully mach string
   syntax:
*/
SELECT first_name as "first NAME" from actors;

/* AS is optional */
SELECT
    movie_name "Movie",
    movie_lang "Language"
from movies;

/*******/

/* 2. Combine 2 columns together and providing an alias for this data
   SELECT
    col_1 || col_2 || 'extra string' AS alias_name
   FROM table_name
*/
SELECT
    first_name || ' ' || last_name AS "Full name"
   FROM actors

/* you can use "SELECT" expression without table_name
   syntax:
   SELECT 2 * 5;
*/
