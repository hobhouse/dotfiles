select * from subscriptions as s
inner join customer_accounts as c on c.id = s.customer_account_id
where previous_subscription_id is not null

