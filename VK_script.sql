drop database if exists vk;
create database vk;
use vk;

create table if not exists users (
	id BIGINT unsigned not null auto_increment primary key,
	firstname VARCHAR(50) COMMENT 'Имя',
	lastname VARCHAR(50) COMMENT 'Фамилия',
	email VARCHAR(255) unique COMMENT 'Электронная почта',
	password_hash VARCHAR(255) COMMENT 'Хэш пароля',
	phone INT unsigned unique COMMENT 'Номер телефона',
	
	index users_firstname_lastname_idx (firstname, lastname)
) COMMENT 'Пользователи';

create table if not exists profiles (
	user_id BIGINT unsigned not null,
	sex VARCHAR(1) COMMENT 'Пол',
	birthday DATE COMMENT 'День рождения',
	photo_id BIGINT unsigned COMMENT 'Фото',
	created_at DATETIME on update current_timestamp COMMENT 'Дата создания',
	hometown VARCHAR(255) COMMENT 'Домашний адрес'
) COMMENT 'Информация о пользователе';

alter table profiles add constraint fk_user_id
foreign key (user_id) references users(id)
on update cascade
on delete restrict;

create table if not exists messages (
	id SERIAL, -- BIGINT unsigned not null auto_increment
	from_user_id BIGINT unsigned not null,
	to_user_id BIGINT unsigned not null,
	body TEXT ,
	created_at DATETIME on update current_timestamp,
	
	foreign key (from_user_id) references users(id),
	foreign key (to_user_id) references users(id)
) COMMENT 'Чат';

create table if not exists friends_requests (
	initiator_user_id BIGINT unsigned not null,
	target_user_id BIGINT unsigned not null,
	`status` enum('requesed', 'approved', 'declined', 'unfriended'),
	requested_at DATETIME on update current_timestamp,
	updated_at DATETIME on update current_timestamp,
	
	primary key (initiator_user_id, target_user_id),	
	foreign key (initiator_user_id) references users(id),
	foreign key (target_user_id) references users(id)
) COMMENT 'Запрос в друзья';

alter table friends_requests 
add check (initiator_user_id <> target_user_id);

create table if not exists communities (
	id SERIAL,
	name VARCHAR(52),
	admin_user_id BIGINT unsigned not null,
	
	index communities_name_idx (name),
	foreign key (admin_user_id) references users(id)
) COMMENT 'Сообщество';

create table if not exists user_communities (
	user_id BIGINT unsigned not null,
	community_id BIGINT unsigned not null,
	
	primary key (user_id, community_id),
	foreign key (user_id) references users(id),
	foreign key (community_id) references communities(id)
) COMMENT 'Пользователи сообщества';

create table if not exists media_types (
	id SERIAL,
	name VARCHAR(255),
	created_at DATETIME on update current_timestamp,
	updated_at DATETIME on update current_timestamp
) COMMENT 'Тип медиа';

create table if not exists media(
	id SERIAL,
	media_type_id BIGINT unsigned not null,
	user_id BIGINT unsigned not null,
	body TEXT,
	filename VARCHAR(255),
	`size` INT unsigned,
	metadata json,
	created_at DATETIME on update current_timestamp,
	updated_at DATETIME on update current_timestamp,
	
	foreign key (user_id) references users(id),
	foreign key (media_type_id) references media_types(id)
) COMMENT 'Медиа';

create table if not exists likes (
	id SERIAL,
	user_id BIGINT unsigned not null,
	media_id BIGINT unsigned not null,
	created_at DATETIME on update current_timestamp
) COMMENT 'Лайки';

create table if not exists photo_albums (
	id SERIAL,
	name VARCHAR(100),
	user_id BIGINT unsigned not null,
	
	foreign key (user_id) references users(id),
	primary key (id)
) COMMENT 'Фото альбомы';

create table if not exists photos(
	id SERIAL,
	album_id BIGINT unsigned not null,
	media_id BIGINT unsigned not null,
	
	foreign key (album_id) references photo_albums(id),
	foreign key (media_id) references media(id)
) COMMENT 'Фото';

create table if not exists reminder (
	id SERIAL,
	add_user_id BIGINT unsigned not null,
	name VARCHAR(255),
	created_at DATETIME default now(),
	appointed_at DATETIME,
	
	foreign key (add_user_id) references users(id)
) COMMENT 'Напоминание';

create table if not exists bookmarks (
	id SERIAL,
	add_user_id BIGINT unsigned not null,
	name VARCHAR(128),
	body TEXT,
	created_at DATETIME default now(),
	update_at DATETIME default now(),
	
	foreign key (add_user_id) references users(id)
) COMMENT 'Закладки';

create table if not exists music_albums (
	id SERIAL,
	name VARCHAR(100),
	user_id BIGINT unsigned not null,
	
	foreign key (user_id) references users(id),
	primary key (id)
) COMMENT 'Плейлисты';

create table if not exists music (
	id SERIAL,
	album_id BIGINT unsigned not null,
	media_id BIGINT unsigned not null,
	
	foreign key (album_id) references music_albums(id),
	foreign key (media_id) references media(id)
) COMMENT 'Музыка';