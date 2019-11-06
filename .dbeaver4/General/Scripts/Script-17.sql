select sh.id, sh.subscription_id, sh.shipment_date, sh.paid_at, sh.shipped_at, s.created_at, s.updated_at, s.customer_account_id, s.pet_species, s.pet_name, s.pet_year_of_birth from shipments as sh
inner join subscriptions as s on s.id = sh.subscription_id
where s.status = 10