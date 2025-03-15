-- Получить информацию о доставке конкретного заказа
SELECT o.order_id,
       o.order_date,
       s.shipment_status,
       s.tracking_number,
       c.carrier_name
FROM orders o
         JOIN shipments s ON o.order_id = s.order_id
         JOIN carriers c ON s.carrier_id = c.carrier_id
WHERE o.order_id = 1;


-- Получить список всех заказов конкретного пользователя
SELECT o.order_id,
       o.order_date,
       o.total_amount,
       o.status,
       oi.product_id,
       p.product_name,
       oi.quantity,
       oi.price
FROM orders o
         JOIN order_items oi ON o.order_id = oi.order_id
         JOIN products p ON oi.product_id = p.product_id
WHERE o.user_id = 1;


-- Получить список всех скидок, которые активны на текущий момент
SELECT discount_code,
       discount_percentage,
       start_date,
       end_date
FROM discounts
WHERE is_active = TRUE
  AND CURRENT_TIMESTAMP BETWEEN start_date AND end_date;

-- Получить количество заказов и общую сумму, потраченную каждым пользователем
SELECT u.user_id,
       u.first_name,
       u.last_name,
       COUNT(o.order_id)   AS total_orders,
       SUM(o.total_amount) AS total_spent
FROM users u
         LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id;

-- Получить все отзывы о товаре
SELECT p.product_name,
       pr.rating,
       pr.review_text,
       u.first_name,
       u.last_name
FROM product_reviews pr
         JOIN products p ON pr.product_id = p.product_id
         JOIN users u ON pr.user_id = u.user_id
WHERE p.product_id = 1;