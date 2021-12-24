select id, count(from_user_id) as counted, from_user_id, to_user_id from messages
where to_user_id = 191
group by from_user_id
limit 1;


SELECT p.sex, COUNT(p.sex) as total FROM likes as l 
	JOIN profiles as p ON (p.user_id = l.user_id && p.sex IN ('f','m'))
GROUP by p.sex
ORDER BY total desc;