-- Вставка пользователей
INSERT INTO users (first_name, last_name, email, phone)
VALUES ('Иван', 'Иванов', 'ivan.ivanov@example.com', '+71234567890'),
       ('Мария', 'Петрова', 'maria.petrovna@example.com', '+79876543210'),
       ('Алексей', 'Сидоров', 'alexey.sidorov@example.com', '+79991234567');

-- Вставка адресов
INSERT INTO addresses (user_id, street, city, region, zip_code, country)
VALUES (1, 'ул. Тверская, д. 10', 'Москва', 'Московская область', '125009', 'Россия'),
       (2, 'ул. Невский, д. 15', 'Санкт-Петербург', 'Санкт-Петербург', '191002', 'Россия'),
       (3, 'ул. Ленина, д. 20', 'Краснодар', 'Краснодарский край', '350000', 'Россия');

-- Вставка категорий
INSERT INTO categories (category_name)
VALUES ('Телевизоры'),
       ('Компьютеры'),
       ('Дом и сад');

-- Вставка поставщиков
INSERT INTO suppliers (supplier_name, contact_info)
VALUES ('ООО "ТехноМаг"', 'Москва, ул. Техно, д. 1'),
       ('ООО "Зеленый уголок"', 'Краснодар, ул. Садоводов, д. 50');

-- Вставка товаров
INSERT INTO products (product_name, description, price, stock_quantity, category_id, supplier_id)
VALUES ('Телевизор Samsung', 'Телевизор с экраном 55 дюймов, 4K', 49999.99, 10, 1, 1),
       ('Ноутбук Lenovo', 'Ноутбук с процессором Intel Core i7', 74999.99, 5, 1, 1),
       ('Газонокосилка', 'Электрическая газонокосилка для дачи', 8500.00, 15, 3, 2);

-- Вставка заказов
INSERT INTO orders (user_id, total_amount, shipping_address_id, status)
VALUES (1, 54999.99, 1, 'Оплачен'),
       (2, 1200.00, 2, 'В обработке'),
       (3, 10000.00, 3, 'Отменен');

-- Вставка товаров в заказах
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (1, 1, 1, 49999.99),
       (2, 2, 1, 74999.99),
       (3, 3, 1, 8500.00);

-- Вставка методов оплаты
INSERT INTO payment_methods (payment_method_name)
VALUES ('Банковская карта'),
       ('Наличные');

-- Вставка платежей
INSERT INTO payments (order_id, payment_amount, payment_method_id, payment_status)
VALUES (1, 54999.99, 1, 'Оплачен'),
       (2, 1200.00, 2, 'Ожидает'),
       (3, 8500.00, 1, 'Отменен');

-- Вставка поставщиков доставки
INSERT INTO carriers (carrier_name)
VALUES ('Сдек'),
       ('Почта России');

-- Вставка доставки
INSERT INTO shipments (order_id, shipment_status, tracking_number, carrier_id)
VALUES (1, 'Доставляется', '1234567890', 1),
       (2, 'Отправлено', '9876543210', 2);

-- Вставка скидок
INSERT INTO discounts (discount_code, discount_percentage, start_date, end_date, is_active)
VALUES ('SPRING10', 10.00, '2023-03-01 00:00:00', '2023-03-31 00:00:00', TRUE),
       ('SUMMER15', 15.00, '2023-06-01 00:00:00', '2023-06-30 00:00:00', TRUE);

-- Вставка отзывов о товарах
INSERT INTO product_reviews (product_id, user_id, rating, review_text)
VALUES (1, 1, 1, 'Плохой телевизор'),
       (2, 2, 4, 'Хороший ноутбук'),
       (3, 3, 5, 'Отлично');

-- Вставка скидок на заказ
INSERT INTO order_discounts (order_id, discount_id, discount_amount)
VALUES (1, 1, 5499.99),
       (2, 2, 180.00);