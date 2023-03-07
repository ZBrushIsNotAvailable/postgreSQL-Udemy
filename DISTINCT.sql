/* v.44 DISTINCT
   Select unique data from the table (no rows with duplicated values)
   syntax:
        SELECT DISTINCT col_name FROM table_name

   you can also select distinct combinations of columns (SELECT DISTINCT col_name_1, col_name_2 FROM table_name)
*/

select  distinct movie_lang,  director_id
from movies