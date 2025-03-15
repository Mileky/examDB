-- Создание пользователей
CREATE TABLE IF NOT EXISTS users
(
    id                SERIAL PRIMARY KEY,
    first_name        VARCHAR(50)                         NOT NULL,
    middle_name       VARCHAR(50),
    last_name         VARCHAR(50)                         NOT NULL,
    email             VARCHAR(100) UNIQUE                 NOT NULL,
    phone             VARCHAR(20),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE INDEX users_first_name_last_name_idx ON users (first_name, last_name);

-- Создание адресов
CREATE TABLE IF NOT EXISTS addresses
(
    id       SERIAL PRIMARY KEY,
    user_id  INT          NOT NULL,
    street   VARCHAR(255) NOT NULL,
    city     VARCHAR(100) NOT NULL,
    region   VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20)  NOT NULL,
    country  VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Создание категорий
CREATE TABLE IF NOT EXISTS categories
(
    id            SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Создание поставщиков
CREATE TABLE IF NOT EXISTS suppliers
(
    id            SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_info  TEXT         NOT NULL,
    UNIQUE (supplier_name)
);

-- Создание товаров
CREATE TABLE IF NOT EXISTS products
(
    id             SERIAL PRIMARY KEY,
    product_name   VARCHAR(100)   NOT NULL,
    description    TEXT,
    price          DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT DEFAULT 0  NOT NULL CHECK (stock_quantity >= 0),
    category_id    INT            NOT NULL,
    supplier_id    INT            NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers (id) ON DELETE SET NULL
);
CREATE INDEX products_product_name_idx ON products (product_name);

-- Создание заказов
CREATE TABLE IF NOT EXISTS orders
(
    id                  SERIAL PRIMARY KEY,
    user_id             INT            NOT NULL,
    order_date          TIMESTAMP               DEFAULT CURRENT_TIMESTAMP NOT NULL,
    total_amount        DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    status              VARCHAR(20)    NOT NULL DEFAULT 'Ожидает',
    shipping_address_id INT            NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (shipping_address_id) REFERENCES addresses (id) ON DELETE CASCADE
);

-- Создание товаров в заказах
CREATE TABLE IF NOT EXISTS order_items
(
    order_item_id SERIAL PRIMARY KEY,
    order_id      INT            NOT NULL,
    product_id    INT            NOT NULL,
    quantity      INT            NOT NULL CHECK (quantity > 0),
    price         DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

-- Создание методов оплаты
CREATE TABLE IF NOT EXISTS payment_methods
(
    id                  SERIAL PRIMARY KEY,
    payment_method_name VARCHAR(50) NOT NULL
);

-- Создание платежей
CREATE TABLE IF NOT EXISTS payments
(
    id                SERIAL PRIMARY KEY,
    order_id          INT            NOT NULL,
    payment_date      TIMESTAMP               DEFAULT CURRENT_TIMESTAMP NOT NULL,
    payment_amount    DECIMAL(10, 2) NOT NULL CHECK (payment_amount >= 0),
    payment_method_id INT            NOT NULL,
    payment_status    VARCHAR(20)    NOT NULL DEFAULT 'Ожидает',
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods (id) ON DELETE CASCADE
);

-- Создание поставщиков доставки
CREATE TABLE IF NOT EXISTS carriers
(
    id           SERIAL PRIMARY KEY,
    carrier_name VARCHAR(100) NOT NULL
);

-- Создание доставки
CREATE TABLE IF NOT EXISTS shipments
(
    id              SERIAL PRIMARY KEY,
    order_id        INT          NOT NULL,
    shipment_date   TIMESTAMP             DEFAULT CURRENT_TIMESTAMP NOT NULL,
    shipment_status VARCHAR(50)  NOT NULL DEFAULT 'В пути',
    tracking_number VARCHAR(100) NOT NULL UNIQUE,
    carrier_id      INT          NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (carrier_id) REFERENCES carriers (id) ON DELETE CASCADE
);

-- Создание скидок
CREATE TABLE IF NOT EXISTS discounts
(
    id                  SERIAL PRIMARY KEY,
    discount_code       VARCHAR(50)          NOT NULL UNIQUE,
    discount_percentage DECIMAL(5, 2)        NOT NULL CHECK (discount_percentage > 0 AND discount_percentage <= 100),
    start_date          TIMESTAMP            NOT NULL,
    end_date            TIMESTAMP            NOT NULL,
    is_active           BOOLEAN DEFAULT TRUE NOT NULL
);

-- Создание отзывов о товарах
CREATE TABLE IF NOT EXISTS product_reviews
(
    id          SERIAL PRIMARY KEY,
    product_id  INT                                 NOT NULL,
    user_id     INT                                 NOT NULL,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    rating      INT                                 NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Создание скидок на заказ
CREATE TABLE IF NOT EXISTS order_discounts
(
    id              SERIAL PRIMARY KEY,
    order_id        INT            NOT NULL,
    discount_id     INT            NOT NULL,
    discount_amount DECIMAL(10, 2) NOT NULL CHECK (discount_amount >= 0),
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (discount_id) REFERENCES discounts (id) ON DELETE CASCADE
);