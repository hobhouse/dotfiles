select first_name, last_name, email, practice_id, name 
from users as u
inner join practices as p 
on u.practice_id = p.id
where u.role=2