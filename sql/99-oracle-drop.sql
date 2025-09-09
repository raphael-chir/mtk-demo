-- ============================================
-- DROP CONSTRAINTS (Foreign Keys)
-- ============================================
ALTER TABLE order_lines DROP CONSTRAINT fk_order_lines_orders;
ALTER TABLE order_lines DROP CONSTRAINT fk_order_lines_products;
ALTER TABLE orders DROP CONSTRAINT fk_orders_customers;

-- ============================================
-- DROP TRIGGERS
-- ============================================
DROP TRIGGER trg_customers_pk;
DROP TRIGGER trg_products_pk;
DROP TRIGGER trg_orders_pk;
DROP TRIGGER trg_order_lines_pk;

-- ============================================
-- DROP INDEXES
-- ============================================
DROP INDEX idx_customers_last_first;
DROP INDEX idx_products_name;
DROP INDEX idx_products_price;
DROP INDEX idx_orders_customer_id;
DROP INDEX idx_orders_date;
DROP INDEX idx_order_lines_order_id;
DROP INDEX idx_order_lines_product_id;
DROP INDEX idx_order_lines_order_product;

-- ============================================
-- DROP TABLES
-- ============================================
DROP TABLE order_lines CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE products CASCADE CONSTRAINTS;
DROP TABLE customers CASCADE CONSTRAINTS;

-- ============================================
-- DROP SEQUENCES
-- ============================================
DROP SEQUENCE customers_seq;
DROP SEQUENCE products_seq;
DROP SEQUENCE orders_seq;
DROP SEQUENCE order_lines_seq;

-- ============================================
-- DROP PROCEDURES / FUNCTIONS
-- ============================================
DROP PROCEDURE report_orders_summary;
DROP PROCEDURE concat_customer_notes;
DROP FUNCTION get_customer_total;
