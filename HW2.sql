DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;

DROP table if exists users;
create table users (
	id INT unsigned,
	name VARCHAR(255) COMMENT '��� ����������'
) COMMENT '������������'

mysqldump -v -uroot -p example > example.SQL
CREATE DATABASE sample;
mysql -u root -p sample < example.sql