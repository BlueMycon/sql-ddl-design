CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL
);


-- TABLE bikes
    --bike model (primary key)
    --price
-- TODO: UNIQUE constraint on bike_id (in case additional models)
CREATE TABLE bikes (
    bike_id VARCHAR(25) PRIMARY KEY
        CHECK (bike_id IN ('FLY', 'HAUL', 'SKIN', 'BUD')),
    price NUMERIC(5,2) NOT NULL
);


-- TABLE orders
    -- order id (primary key)
    -- customer id (reference customers)
    -- timestamp
    -- price
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id NOT NULL REFERENCES customers,
    order_date NOT NULL TIMESTAMP
);


-- TABLE bikes_orders
    --serialized (primary key)
    --bike (reference bikes)
    --order id (reference orders)
    --note
    --TODO: How to reference NON-primary key?
CREATE TABLE bikes_orders (
    bikes_orders_id SERIAL PRIMARY KEY,
    bike_id VARCHAR(25) NOT NULL REFERENCES bikes,
    order_id INT NOT NULL REFERENCES orders,
    purchase_cost NUMERIC(5,2) NOT NULL,
    note VARCHAR(50) DEFAULT ''
);


---bottom needed?----


-- TABLE prices
    --bike model
    --effective timestamp
    --price
CREATE TABLE prices (
    price_id SERIAL PRIMARY KEY,
    bike_id VARCHAR(25) REFERENCES bikes,
    effective_date TIMESTAMP NOT NULL,
    price NUMERIC(5,2) NOT NULL,
    UNIQUE (bike_id, effective_date)
);
