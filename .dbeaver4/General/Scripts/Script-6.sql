select si.id, s.id, s.shipment_date, s.subscription_id, l.practice_product_id, pp.practice_id, pp.product_id, si.product_quantity, p."name" from shipment_items as si
inner join shipments as s on si.shipment_id = s.id
inner join line_items as l on l.id = line_item_id
inner join practice_products as pp on pp.id = l.practice_product_id
inner join products as p on pp.product_id = p.id
inner join subscriptions as sub on sub.id = s.subscription_id
where s.shipped_at is null or sub.status = 10