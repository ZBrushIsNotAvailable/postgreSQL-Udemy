/* v.45
   Three types of operators

   Operators are special keywords in SQL that we use in conjunction with SQL clauses to:
    -- Compare the values of fields
    -- Select subset of fields
    -- Perform arithmetic operations

 Types of Operators:
   1. COMPARISON:
    =, >, <, >=, <=, <> or != (not equal to)

   2. LOGICAL:
    AND, OR, LIKE, IN, BETWEEN

   3. ARITHMETIC:
    +, -, /, *, % (modulo)

 These types of operators can be combined

   v.49
   WHERE can only be used after FROM
   ORDER BY is always after WHERE
   */
SELECT *
FROM movies
WHERE movie_lang = 'Japanese'
   OR age_certificate = 'U';

/* combining OR and AND */
SELECT *
FROM movies
WHERE (movie_lang = 'Japanese'
    OR age_certificate = 'U')
  AND movie_id <= 30
ORDER BY release_date

/* v.53 Using logical operators
    1. Comprising date
   Take care of a date format e.g.: YYYY-MM-DD or DD-MM-YYYY
   pass date in single quotes
   syntax:
    ...
    WHERE column_name > '2001-01-24'

   2.Comprising string:
    syntax:
     ...
     WHERE column_name > 'English'
     WHERE column_name <> 'English'
    */