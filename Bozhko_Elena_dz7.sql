-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.--

use shop;

truncate orders;
select * from users;
select * from orders;
select * from orders_products;

insert into orders (user_id)
select id from users where name like 'кар%';

insert into orders_products (order_id, product_id, total, created_at)
select last_insert_id(), id, 5, now()
from products where name like 'int%';

insert into orders (user_id)
select id from users where name like 'нат%';

insert into orders_products (order_id, product_id, total, created_at)
	select last_insert_id(), id, 2, now()
from products where id in (1, 6);

insert into orders (user_id)
select id from users where name like '%рия';

insert into orders_products (order_id, product_id, total, created_at)
	select last_insert_id(), id, 1, now()
from products where id in (1, 3, 4, 6, 7);

select * from users
where id in (select user_id from orders);


select users.id, users.name, users.birthday_at, orders.created_at from users
join orders on users.id = orders.user_id;


-- Выведите список товаров products и разделов catalogs, который соответствует товару.--

insert into products(name, description, price, catlog_id, created_at, updated_at) values
	('куртка', 'NIKE', '18500', 4, now(), now()),
	('куртка', 'adik', '28500', 4, now(), now()),
	('майка', 'NIKE', '2500', 2, now(), now()),
	('майка', 'adik', '3500', 2, now(), now()),
	('кросовки', 'NIKE', '15500', 7, now(), now()),
	('кросовки', 'adik', '18500', 7, now(), now())
;

SELECT
	catalogs.name AS catalog_name,
	products.name AS product_name,
	products.price,
	products.description AS product_description
FROM products
LEFT JOIN catalogs ON catalogs.id = products.catalog_id;


-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.---

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id serial PRIMARY KEY,
	'from' VARCHAR(40),
	'to' VARCHAR(40)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	id serial PRIMARY KEY,
	label varchar(40),
	name varchar(40)
);

INSERT INTO flights ('from', 'to') VALUES
	('samara', 'sochi'),
	('moscow', 'kazan'),
	('omsk', 'tula'),
	('voroneg', 'saratov'),
	('rostov', 'kursc');

INSERT INTO cities (TABLE, name) VALUES
	('samara', 'Самара'),
	('moscow', 'Москва'),
	('kazan', 'Казань'),
	('tula', 'Тула'),
	('kursc', 'Курск');

SELECT
	id,
	(SELECT name FROM cities WHERE label = flights.'from') AS 'from',
	(SELECT name FROM cities c WHERE label = flights.'to') AS 'to'
	
FROM flights;

SELECT flights.id, 'from'.name AS 'from', 'to'. name AS 'to'
FROM flights
JOIN cities AS 'from' ON flights.'from' = 'from'.label
JOIN cities AS 'to' ON flights.'to' = 'to'.label
ORDER BY id
;
	


