select distinct firstname from users
order by firstname asc;


ALTER TABLE profiles
ADD is_active enum('true', 'false') default 'true';
UPDATE profiles set is_active = "false"
WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;


delete from messages
where created_at < current_timestamp();



