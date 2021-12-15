alter table users add age INT unsigned;
update users set age=FLOOR(year(NOW()) - year(birthday_at));

select ROUND(AVG(age) as median_age from users);


SELECT
    DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day_of_birthday_in_this_Year,
    COUNT(*) AS amount_of_birthday
FROM
    users
GROUP BY 
    week_day_of_birthday_in_this_Year
ORDER BY
	amount_of_birthday DESC;