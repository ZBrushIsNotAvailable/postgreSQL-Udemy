create database mydata;

create table persons
(
    person_id  serial primary key,
    first_name varchar(20) not null,
    last_name  varchar(20) not null
);

/* add column */
alter table persons
    add is_enable varchar(1);

select *
from persons;

alter table persons
    add if not exists nationality varchar(20) not null,
    add email                     varchar(100) unique;

/* rename a table */
alter table persons
    rename to users;

/* rename column */
alter table persons
    rename column age to persons_age;

/* drop column */
alter table persons
    drop column persons_age;

/* change column data type */
/*
There is no implicit (automatic) cast from text or varchar to integer
(i.e. you cannot pass a varchar to a function expecting integer or assign a varchar field to an integer one),
so you must specify an explicit cast using
ALTER TABLE ... ALTER COLUMN ... TYPE ... USING:

ALTER TABLE the_table ALTER COLUMN col_name TYPE integer USING (col_name::integer);

Note that you may have whitespace in your text fields; in that case, use:
    ALTER TABLE the_table ALTER COLUMN col_name TYPE integer USING (trim(col_name)::integer);
to strip white space before converting.
*/
alter table persons
    alter column age type int using age::int;


/* set default vals for a colunm */
alter table persons
    alter is_enable set default 'y';

insert into persons (first_name, last_name, nationality)
values ('john', 'newman', 'US');


/* 2. Add constraints to a column */

/*create table web_links
(
    link_id     serial primary key,
    link_url    varchar(255) not null,
    link_target varchar(20)
);

select *
from web_links;

insert into web_links (link_url, link_target)
values ('https://www.rozetka.com', '_blank');*/

/* 2.1. Adding UNIQUE constraint to a column */
alter table web_links
    add constraint unique_web_url unique (link_url);

/* 2.2 Set a column to accept only defined allowed values */
/* alter table web_links
    add is_enable varchar(2);

 insert into web_links(link_url, link_target, is_enable)
 values ('https://www.enko.ua', '_blank', 'y');*/

alter table web_links
    add check ( is_enable in ('y', 'n'));

/* update web_links
set is_enable='y'
where link_id = 1; */