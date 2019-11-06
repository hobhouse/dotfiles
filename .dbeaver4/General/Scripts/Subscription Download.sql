select s.id, s.created_at, s.updated_at, s.customer_account_id, s.pet_name, c.practice_id, s.status, s.approved_at from subscriptions as s
inner join customer_accounts as c on s.customer_account_id = c.id
where s.status = 10