create table customers
(
    customer_id serial primary key,
    first_name  varchar(50),
    last_name   varchar(50),
    email       varchar(150),
    age         int
);

/* insert data in specific columns and return specific record from modified row */
insert into customers (first_name, last_name)
values ('Mike O''konell', 'Jr.')
RETURNING customer_id;

insert into customers (first_name, last_name, email, age)
values ('Alex', 'Med', 'sypchik@gmail.com', 10);

insert into customers (first_name)
values ('o''konell')
RETURNING *;

/* add new column */
alter table customers
    add is_enable varchar(2);

/* update all records */
update customers
set is_enable ='Y';

/* update specific record(-s) */
update customers
set first_name = 'Koons',
    last_name  = 'Soft'
where customer_id = 4;

/* update specific record(-s) and return modified rows */
update customers
set first_name = 'Smith'
where customer_id = 3
returning *;

