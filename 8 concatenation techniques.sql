/* v.60
   1. Double pipe (||) to concatenate strings:
    SELECT 'string_1' || 'string_2' AS new_string;

   2. CONCAT to concatenate or combine columns values:
        SELECT CONCAT(col_1, col_2) AS new_string;

   3. CONCAT_WS to concatenate or combine columns values with specific separator:
        SELECT CONCAT_WS('separator', col_1, col_2) AS new_string;

   CONCAT and CONCAT_WS works ignores NULL values, unlike concatenation with ||
*/
/* combining actors first an last names */
select (first_name || ' ' || last_name) as "Full name"
from actors;

select concat(first_name, last_name) as "full name"
from actors;

select concat_ws(' | ', first_name, last_name) as "fully name"
from actors;