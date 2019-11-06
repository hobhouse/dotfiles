select pp.id, price_per_pack, name from practice_products as pp 
inner join products as p on p.id = pp.product_id 
where practice_id = 54
