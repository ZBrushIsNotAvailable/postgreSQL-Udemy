/* some operators that can be used in postgres */

/* CAST -- allows to convert data to the selected data type
    syntax:
        CAST(data as data-type)
    alias syntax:
        data::data-type
*/
select cast('my string' as char(10));
select 'my string'::char(10);

/* NOW()                                        -- returns current timestamp with time zone
   timeofday()                                  -- Sun Mar 12 17:46:13.787960 2023 EET
   CURRENT_DATE                                 -- returns date
   CURRENT_TIME(seconds_precision [optional])   -- returns time with time zone
   LOCALTIME(seconds_precision [optional])      -- returns local-machine time without time zone
   CURRENT_TIMESTAMP

   show timezone;
   set timezone = 'Europe/Kiev';
*/

/* network addresses
   set_masklen(ip,24)         -- set netmask length for inet value

*/