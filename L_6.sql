select count(*), from_user_id, to_user_id from messages
where to_user_id = 191
group by from_user_id
order by 1 desc
limit 1;


select count(*), user_id from likes
where user_id in (select user_id from profiles where ((year(now()) - year(birthday)) < 10))
group by user_id 
order by 1;


select case(sex)
		when 'm' then 'мужчин'
		when 'f' then 'женщин'
	   end as 'The most'
from profiles
where user_id in (select user_id from likes)
group by sex
having count(*) > 1
limit 1;