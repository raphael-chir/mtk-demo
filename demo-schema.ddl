-- ============================================
-- Create Oracle schema for EPAS demo
-- Using sequences + triggers for PKs
-- FKs created via ALTER TABLE
-- ============================================

-- ===============
-- Table customers
-- ===============
CREATE TABLE customers (
    customer_id       NUMBER PRIMARY KEY,
    last_name         VARCHAR2(100) NOT NULL,
    first_name        VARCHAR2(100),
    email             VARCHAR2(150) UNIQUE,
    signup_date       DATE DEFAULT SYSDATE
);

CREATE SEQUENCE customers_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER trg_customers_pk
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    IF :NEW.customer_id IS NULL THEN
        SELECT customers_seq.NEXTVAL INTO :NEW.customer_id FROM dual;
    END IF;
END;
/

-- ===============
-- Table products
-- ===============
CREATE TABLE products (
    product_id        NUMBER PRIMARY KEY,
    name              VARCHAR2(150) NOT NULL,
    description       VARCHAR2(4000),
    price             NUMBER(10,2) NOT NULL,
    creation_date     DATE DEFAULT SYSDATE,
    details_xml       XMLTYPE
);

CREATE SEQUENCE products_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER trg_products_pk
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF :NEW.product_id IS NULL THEN
        SELECT products_seq.NEXTVAL INTO :NEW.product_id FROM dual;
    END IF;
END;
/

-- ===============
-- Table orders
-- ===============
CREATE TABLE orders (
    order_id          NUMBER PRIMARY KEY,
    customer_id       NUMBER NOT NULL,
    order_date        DATE DEFAULT SYSDATE,
    total_amount      NUMBER(10,2),
    activity_log      CLOB
);

CREATE SEQUENCE orders_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER trg_orders_pk
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF :NEW.order_id IS NULL THEN
        SELECT orders_seq.NEXTVAL INTO :NEW.order_id FROM dual;
    END IF;
END;
/

-- =================
-- Table order_lines
-- =================
CREATE TABLE order_lines (
    line_id           NUMBER PRIMARY KEY,
    order_id          NUMBER NOT NULL,
    product_id        NUMBER NOT NULL,
    quantity          NUMBER(5) DEFAULT 1,
    unit_price        NUMBER(10,2) NOT NULL
);

CREATE SEQUENCE order_lines_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TRIGGER trg_order_lines_pk
BEFORE INSERT ON order_lines
FOR EACH ROW
BEGIN
    IF :NEW.line_id IS NULL THEN
        SELECT order_lines_seq.NEXTVAL INTO :NEW.line_id FROM dual;
    END IF;
END;
/

-- ============================================
-- Foreign keys via ALTER TABLE
-- ============================================

ALTER TABLE orders
    ADD CONSTRAINT fk_orders_customers
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE order_lines
    ADD CONSTRAINT fk_order_lines_orders
    FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE order_lines
    ADD CONSTRAINT fk_order_lines_products
    FOREIGN KEY (product_id) REFERENCES products(product_id);

-- ============================================
-- Indexes for EPAS demo schema (Oracle + EPAS compatible)
-- ============================================

-- Customers
CREATE INDEX idx_customers_last_first 
    ON customers(last_name, first_name);

-- Products
CREATE INDEX idx_products_name 
    ON products(name);

CREATE INDEX idx_products_price 
    ON products(price);

-- Orders
CREATE INDEX idx_orders_customer_id 
    ON orders(customer_id);

CREATE INDEX idx_orders_date 
    ON orders(order_date);

-- Order Lines
CREATE INDEX idx_order_lines_order_id 
    ON order_lines(order_id);

CREATE INDEX idx_order_lines_product_id 
    ON order_lines(product_id);

CREATE INDEX idx_order_lines_order_product 
    ON order_lines(order_id, product_id);


-- ============================================
-- Procedure : Report orders summary by customer via DBMS_OUTPUT 
-- ============================================
CREATE OR REPLACE PROCEDURE report_orders_summary IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Orders summary :');
    FOR rec IN (SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS nb_orders,
                       SUM(o.total_amount) AS total
                FROM customers c
                LEFT JOIN orders o ON c.customer_id = o.customer_id
                GROUP BY c.customer_id, c.first_name, c.last_name
                ORDER BY total DESC) LOOP
        DBMS_OUTPUT.PUT_LINE('Customer ' || rec.customer_id || ' - ' ||
                             rec.first_name || ' ' || rec.last_name ||
                             ' : ' || rec.nb_orders || ' orders, total = ' || rec.total);
    END LOOP;
END;
/

-- ============================================
-- Function : Total amount spent by a customer via DBMS_SQL
-- ============================================
CREATE OR REPLACE FUNCTION get_customer_total(p_customer_id NUMBER) RETURN NUMBER IS
    v_total NUMBER := 0;
    v_cursor INTEGER;
    v_dummy  INTEGER;
BEGIN
    v_cursor := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(v_cursor, 'SELECT SUM(total_amount) FROM orders WHERE customer_id = :1', DBMS_SQL.NATIVE);
    DBMS_SQL.BIND_VARIABLE(v_cursor, ':1', p_customer_id);
    DBMS_SQL.DEFINE_COLUMN(v_cursor, 1, v_total);
    v_dummy := DBMS_SQL.EXECUTE(v_cursor);
    IF DBMS_SQL.FETCH_ROWS(v_cursor) > 0 THEN
        DBMS_SQL.COLUMN_VALUE(v_cursor, 1, v_total);
    END IF;
    DBMS_SQL.CLOSE_CURSOR(v_cursor);
    RETURN NVL(v_total, 0);
END;
/

-- ============================================
-- Procedure : Concatenate all orders activity log for a given customer via DBMS_LOB
-- ============================================
CREATE OR REPLACE PROCEDURE get_all_orders_activity_log(p_customer_id NUMBER) IS
  v_notes CLOB;
BEGIN
  DBMS_LOB.CREATETEMPORARY(v_notes, TRUE);
  FOR rec IN (
    SELECT o.activity_log AS c
    FROM orders o
    WHERE o.customer_id = p_customer_id
      AND o.activity_log IS NOT NULL
  ) LOOP
    DBMS_LOB.APPEND(v_notes, rec.c || CHR(10));
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('All orders activity logs for customer ' || p_customer_id || ' :');
  DBMS_OUTPUT.PUT_LINE(v_notes);

  DBMS_LOB.FREETEMPORARY(v_notes);
END;
/


-- ============================================
-- End of DDL
-- ============================================
