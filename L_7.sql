insert into users (name, birthday_at, age) values
	('����', '1990-09-09', 31),
	('����', '1999-05-19', 22),
	('����', '1996-05-29', 25),
	('����', '1991-04-19', 30),
	('����', '1992-02-09', 29)
;

insert into orders (user_id) values (1), (2), (3), (4), (1), (1), (1), (2), (12), (6), (7);

select id, name from users
where id in (select user_id from orders);


select name, description, price, (select name from catalogs where id = catalog_id) as catalog_id from products
;
