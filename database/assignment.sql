create extension if not exists "uuid-ossp";

create table "user" (
"id" uuid not null default uuid_generate_v4() primary key,
"email" character varying not null,
"password" character varying not null
)

create table address (
"id" uuid not null default uuid_generate_v4() primary key,
"user_id" uuid references "user"(id),
"name" character varying not null,
"address" character varying,
"phone_number" character varying
);

create table product_category (
"id" uuid not null default uuid_generate_v4() primary key,
"category_name" character varying
)

create table product (
"id" uuid not null default uuid_generate_v4() primary key,
"name" character varying not null,
"description" character varying,
"price" float,
"sku" character varying,
"product_category" uuid references product_category(id)
);

create table "order" (
"id" uuid not null default uuid_generate_v4() primary key,
"ordered_user_id" uuid not null references "user"(id),
"order_address" uuid references address(id),
"price" float
);

create table order_product (
"order_id" uuid not null references "order"(id),
"product_id" uuid not null references product(id),
"count" numeric not null
);

insert
	into
	"user"
values (uuid_generate_v4(),
'amal@gmail.com',
'12345'),
(uuid_generate_v4(),
'arun@gmail.com',
'16252'),
(uuid_generate_v4(),
'jack@gmail.com',
'fdgasd');

insert
	into
	address
values (uuid_generate_v4(),
(
select
	id
from
	"user"
where
	"email" = 'amal@gmail.com'),
'Amal',
'Street 11',
'9878671234'),
(uuid_generate_v4(),
(
select
	id
from
	"user"
where
	"email" = 'arun@gmail.com'),
'Arun',
'Street 12',
'9871271234'),
(uuid_generate_v4(),
(
select
	id
from
	"user"
where
	"email" = 'jack@gmail.com'),
'Jack',
'Street 12',
'1234567890');

insert
	into
	"product_category"
(id,
	category_name)
values(uuid_generate_v4(),
'Computer Accessories'),
(uuid_generate_v4(),
'Groceries');

insert
	into
	product
values (uuid_generate_v4(),
'Keyboard',
'Wireless keyboard',
2000,
'SKU1',
(
select
	id
from
	product_category
where
	category_name = 'Computer Accessories')),
(uuid_generate_v4(),
'Charger',
'Wired charger',
5000,
'SKU2',
(
select
	id
from
	product_category
where
	category_name = 'Computer Accessories')),
(uuid_generate_v4(),
'Mouse',
'Wireless mouse',
1000,
'SKU3',
(
select
	id
from
	product_category
where
	category_name = 'Computer Accessories')),
(uuid_generate_v4(),
'Apple',
'Red apple',
100,
'SKU4',
(
select
	id
from
	product_category
where
	category_name = 'Groceries')),
(uuid_generate_v4(),
'Orange',
'Orange orange',
80,
'SKU5',
(
select
	id
from
	product_category
where
	category_name = 'Groceries'));

insert
	into
	"order"
values (
uuid_generate_v4(),
(
select
	id
from
	"user"
where
	"email" = 'amal@gmail.com'),
(
select
	id
from
	address
where
	"name" = 'Amal'),
3000
),
(
uuid_generate_v4(),
(
select
	id
from
	"user"
where
	"email" = 'amal@gmail.com'),
(
select
	id
from
	address
where
	"name" = 'Amal'),
80
),
(
uuid_generate_v4(),
(
select
	id
from
	"user"
where
	"email" = 'amal@gmail.com'),
(
select
	id
from
	address
where
	"name" = 'Amal'),
5000
),
(
uuid_generate_v4(),
(
select
	id
from
	"user"
where
	"email" = 'arun@gmail.com'),
(
select
	id
from
	address
where
	"name" = 'Arun'),
1000
),
(
uuid_generate_v4(),
(
select
	id
from
	"user"
where
	"email" = 'arun@gmail.com'),
(
select
	id
from
	address
where
	"name" = 'Arun'),
2000
);

insert
	into
	order_product
values
('287c751e-425b-48b7-a51f-f611d2e06f01',
'4bd173bd-05a6-4662-a4dc-07594065e109',
1),
('287c751e-425b-48b7-a51f-f611d2e06f01',
'25a29f14-27df-40d3-a8db-393356e23185',
1),
('ed574075-b263-4807-8d01-d9ca93e33f26',
'4c279ea0-d033-4636-92cf-65e0cdb42e1d',
1),
('1e258059-5298-437a-972c-34633cd3cb40',
'02fd5195-98e0-4d55-bc4f-557c9f432e90',
1),
('44b28368-dfff-4127-99bb-c518d5a27e64',
'25a29f14-27df-40d3-a8db-393356e23185',
1),
('3ed9913d-1a87-4b2e-affe-352482494035',
'4bd173bd-05a6-4662-a4dc-07594065e109',
1);

create index product_name on
product(name);

