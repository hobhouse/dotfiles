select s.id, s.status, s.dd_mandate_reference_number, s.pet_name, s.customer_account_id from subscriptions	as s
inner join customer_accounts as c on c.id = s.customer_account_id
where s.status = 15 or s.status = 20
