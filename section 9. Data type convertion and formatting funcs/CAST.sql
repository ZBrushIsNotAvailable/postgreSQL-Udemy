/* 1. Two types of conversion:
   implicit -- done AUTOMATICALLY
   explicit -- via "conversion functions" e.g. CAST or ::
*/

/* implicit conversion: */
select *
from movies
where movie_id = '1';
-- '1' is automatically converted to integer

/* explicit conversion: */
select *
from movies
where movie_id = integer '1';

/* CAST
    CAST expr AS target_data_type

       expr -- a column, constant or expression

   you can also use
    expr::target_data_type
*/
select cast(10 as varchar(2));
select 10::double precision,
       '12 May 2020'::date,
       '2020-02-22 10:33'::timestamptz,
       '10 hour'::interval;

/* 2. Implicit to explicit conversions*/

-- factorial func requires bigint input:
select factorial(20) as "implicit";
select factorial(20::bigint) as "explicit";


/* 3. Convert table with already filled with data: */
create table ratings
(
    rating_id serial primary key,
    rating    varchar(2)
);
insert into ratings (rating)
values ('a'),
       ('b'),
       ('c');

/* now say we need to all ratings to be numeric and convert char data to 0:*/
insert into ratings (rating)
values (1),
       (2),
       (3);

select rating_id,
       CASE
           when rating ~ E'^\\d+$'
               then rating::int
           else 0
           END as rating
from ratings;


/* data ty*/