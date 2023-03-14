/* v.62
   1. Boolean
    can be TRUE, FALSE or NULL

    TRUE value can be evaluated from:
        TRUE, 'true', 't', 'yes', 'y', '1';
    FALSE value can be evaluated from:
        FALSE, 'false', 'f', 'no', 'n', '0';

   */
create table table_boolean
(
    product_id   serial primary key,
    is_available boolean not null
);

insert into table_boolean (is_available)
values ('y'),
       (false);


/* using NOT */

select *
from table_boolean
where is_available;
/* is equals to */
select *
from table_boolean
where is_available = true;

select *
from table_boolean
where not is_available;
/* is equals to */
select *
from table_boolean
where is_available = false;


/* how to set the default value */
alter table table_boolean
    alter column is_available
        set default false;


/* v.63
   2. Character data types:
        CHARACTER(n), CHAR(n)             -- fixed length, blank padded
                                            (if enter less then max chars, data will be padded with spaces)
        CHARACTER VARYING(n), VARCHAR(n)  -- variable length with length limit
        TEXT, VARCHAR                     -- variable length, not part of SQL standard

        n -- if not specified, default to 1;

        if sting length exceeds n, it will be truncated;
        if the excessive chars are spaces, Postgres truncates them to max length
*/


/* v.64
3. Numeric data types:
        Numeric data types CAN'T hold NULL values

    3.1 Integers:

        smallint    2 bytes    +-32767 (32 k)
        integer     4 bytes    +-2147483647 (2.1 billion)
        bigint      8 bytes    +-9223372036854775807

        Autoincrement integers:
            smallserial     2 bytes    1 to 32767 (32 k)
            serial          4 bytes    1 to 2147483647 (2.1 billion)
            bigserial       8 bytes    1 to 9223372036854775807


    3.2 Fixed-point numbers (arbitrary precision type):

        numeric     variable bytes    up to 131072 digits before the decimal point
                                      up to 16383 digits after the decimal point

        syntax:
        numeric(precision, scale) or decimal(precision, scale);

            precision -- maximum number of digits to the left and right of the decimal point
            scale -- number of digits allowed to the right of the decimal point


    3.3 Floating-point numbers:

        real                4 bytes     up to 6 decimal digits precision;
        double precision    8 bytes     up to 15 decimal digits precision;

*/
create table table_numeric
(
    numeric numeric(20, 5),
    real    real,
    double  double precision
);
insert into table_numeric(numeric, real, double)
values (.9, .9, .9),
       (3.13579, 3.13579, 3.13579),
       (4.1357987654, 4.1357987654, 4.1357987654);


/* v.66
   Selecting numeric data type:
    1. Use INTEGER whenever possible
    2. If ur decimal calculations need to be exact, use DECIMAL or NUMERIC;
        FLOAT will save space but be careful about the inexactness;

*/


/* v.67
   4. Date data types:
        Date            date only                   4713 BC to 294276 AD      4 bytes;
        Time            time only                   4713 BC to 5874897 AD     8 bytes;
        Timestamp       date and time               4713 BC to 294276 AD
        Timestamptz     date, time and timestamp    4713 BC to 294276 AD

        Interval        values    4713 BC to 294276 AD
*/

/* v.68-

    4.1 DATE

        YYYY-MM-DD is default format
        keywords:
            CURRENT_DATE stores current date

*/
create table table_dates
(
    id       serial primary key,
    name     varchar(100) not null,
    add_date date default current_date
);

/*
   4.2 TIME

       syntax:
        TIME(precision)

        precision -- [optionally] number of fraction digits in the seconds field (up to 6 digits)

        common formats:
            HH:MM
            HH:MM:SS
            HHMMSS

            MM:SS.pppppp      59:21.777777
            HH:MM:SS.pppppp   03:59:21.777777
            HHMMSS.pppppp     035921.777777
*/
create table table_times
(
    id         serial primary key,
    class_name varchar(100) not null,
    start_time time         not null,
    end_time   time         not null
);

/*
   4.3 INTERVAL

       syntax:
        INTERVAL 'n type'

        n - amount;
        type -- can be: second, minute, hour, day, month, year...
*/
select current_time,
       current_time + interval '-2 hours' as result;

/*
   4.4 TIMESTAMP, TIMESTAMPTZ
     Allows to store both date and time together

     1). TIMESTAMPTZ:
        internally stored value is always in UTC (traditionally known as GMT)

        input: When a timestamptz value that is setting in has explicit timezone specified,
                it is converted to UTC, using the appropriate offset for that timezone.

               If no timezone provided, it is assumed to be in the time zone indicated
                in the system's TimeZone parameter,
                and is converted to UTC, using the appropriate offset for that timezone;

        output: when a timestamptz value is output it is always converted from UTC
                to a local time in that timezone or timezone you specified;
*/
create table table_time_tz
(
    ts   timestamp,
    tstz timestamptz
);
/* in timestamp column, '-07' timezone value will be ignored,
    but not in timestamptz column, where value will be converted to UTC
*/
insert into table_time_tz(ts, tstz)
values ('2020-02-22 10:10:10-07', '2020-02-22 10:10:10-07')
returning *;

show timezone;

set timezone = 'Europe/Kiev';

select CURRENT_TIMESTAMP;
select timeofday();
select timezone('Asia/Singapore', '2020-01-01 00:00:00');

select *
from table_time_tz;


/* 5. UUID data type

    (universal unique identifier)

   it is a 128-bit quantity generated by an algorithm that makes it unique in the universe

   example:
    40e6215d-b5c6-4896-987c-f30f3678f608
   - 32 hexadecimal digits separated by hyphens

   to create a UUID in PostgeSQL you need a third-party UUID-algorithms
    e.g. uuid-ossp

   To add UUID support and install uuid-ossp extention use this
   syntax:
    create extension if not exists "uuid-ossp";
    select uuid_generate_v4();

*/
create extension if not exists "uuid-ossp";
select uuid_generate_v1();

create table table_uuid
(
    product_id   uuid default uuid_generate_v1(),
    product_name varchar(100) not null
);

select *
from table_uuid;


/* 6. ARRAY data type

    Every data type has it's companion array data type:
        integer has an integer[] array type;
        character -- character[]
*/
create table table_array
(
    child_id uuid default uuid_generate_v4(),
    phones   text[]
);
insert into table_array (phones)
values (array ['nokia','samsung']);

select phones[1]
from table_array;

select child_id
from table_array
where phones[2] = 'samsung';

/* 7. HSTORE data type

   key-value data type

    1). The hstore module needs to be installed to start working with hstore data type;
        CREATE extension if not exists hstore;

    -- keys and values are TEXT data-type only
    -- keys should be unique. If you declare an hstore with duplicate keys, only one will be stored
        in the hstore and there is no guarantee as to which will be kept
*/
CREATE extension if not exists hstore;

create table table_hstore
(
    book_id   serial primary key,
    title     varchar(100) not null,
    book_info hstore
);

insert into table_hstore (title, book_info)
values ('title 1',
        '
        "publisher"=>"ABC Publish",
        "paper_cost"=>"10.00",
        "e_cost"=>"5.85"
        ');

select *
from table_hstore;

select book_info -> 'publisher' as "Publisher",
       book_info -> 'e_cost'    as "Electronic cost"
from table_hstore;


/* 8. JSON data type
    there are JSON and JSONB data types in Postgres

    JSON makes no content processing at all, only form validation;

    JSONB is advanced binary format with full processing, indexing and searching capabilities,
        and as such preprocess the JSON data to the internal format witch does include a single value
        per key; and also isn't sensible to extra whitespaces or indentations.
*/
create table table_json
(
    id   serial primary key,
    data json
);
insert into table_json (data)
values ('[
  1,
  2,
  3,
  4
]'),
       ('{
         "key": "value"
       }');

alter table table_json
    alter column data type jsonb;

/* search specific data in the jsonb column: */
select *
from table_json
where data @> '2';

/* creating index for faster search and all: */
create index on table_json using gin (data jsonb_path_ops);

/* 9. Network Address data types
    Postgres offers data types for IPv4, IPv4 and MAC-addresses.
    There is better to use these data types instead of plain text,
        because these types offer errors checking, indexing, specialized operators and functions

   when sorting cidr or inet IPv4 will always sort before IPv6

    cidr        7 or 19 bytes   IPv4 and IPv6 addresses
    inet        7 or 19 bytes   IPv4 and IPv6 hosts and addresses
    maccaddr    6 bytes         Mac addresses
    maccaddr8   8 bytes         Mac addresses (EUI-64 format)

*/

/* table for IPv4 and IPv6 addresses */
create table table_netaddr
(
    id serial primary key,
    ip inet
);
insert into table_netaddr (ip)
values ('4.32.221.243'),
       ('4.152.207.126'),
       ('12.1.223.132'),
       ('12.8.192.68');

select *
from table_netaddr;

/* lets analise entries for /24 ip addresses
   -- set_masklen function: set netmask length for inet value */
select ip, set_masklen(ip, 24) as inet_24
from table_netaddr;

/* convert inet to cidr on the fly */
select ip,
       set_masklen(ip, 24)       as inet_24,
       set_masklen(ip::cidr, 24) as cidr_24
from table_netaddr;