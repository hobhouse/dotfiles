select scr.subscription_id, scr.reason, scr."comment", scr.updated_at from subscriptions as s
inner join subscription_cancellation_reasons as scr on s.id = scr.subscription_id
where s.status = 20
