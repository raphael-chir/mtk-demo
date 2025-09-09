import random
from faker import Faker
from datetime import datetime

fake = Faker()

NUM_CUSTOMERS = 30000
NUM_PRODUCTS = 7000
NUM_ORDERS = 15000
NUM_RATINGS = 35000

# =====================
# Customers
# =====================
with open("customers.sql", "w") as f:
    for _ in range(NUM_CUSTOMERS):
        first = fake.first_name()
        last = fake.last_name()
        email = f"{first.lower()}.{last.lower()}@gmail.com"
        signup_date = fake.date_between(start_date="-5y", end_date="today")
        f.write(f"INSERT INTO customers (first_name, last_name, email, signup_date) "
                f"VALUES ('{first}', '{last}', '{email}', TO_DATE('{signup_date}', 'YYYY-MM-DD'));\n")

# =====================
# Products
# =====================
categories = ["Electronics", "Home", "Books", "Sports", "Fashion"]

with open("products.sql", "w") as f:
    for _ in range(NUM_PRODUCTS):
        name = fake.catch_phrase().replace("'", "''")
        description = fake.text(max_nb_chars=100).replace("\n", " ").replace("'", "''")
        price = round(random.uniform(5, 2000), 2)
        creation_date = fake.date_between(start_date="-3y", end_date="today")

        category = random.choice(categories)
        weight = random.randint(100, 3000)
        dimensions = f"{random.randint(5,50)}x{random.randint(5,50)}x{random.randint(5,50)}"
        manufacturer = fake.company().replace("'", "''")
        features = "".join([f"<feature>{fake.bs()}</feature>" for _ in range(random.randint(1,4))])

        xml = f"""<product>
  <category>{category}</category>
  <weight unit="grams">{weight}</weight>
  <dimensions unit="cm">{dimensions}</dimensions>
  <manufacturer>{manufacturer}</manufacturer>
  <features>{features}</features>
</product>"""

        f.write(f"INSERT INTO products (name, description, price, creation_date, details_xml) "
                f"VALUES ('{name}', '{description}', {price}, TO_DATE('{creation_date}', 'YYYY-MM-DD'), "
                f"XMLType('{xml.replace('\'','\'\'')}'));\n")

# =====================
# Orders & Order Lines dans un bloc PL/SQL
# =====================
with open("orders.sql", "w") as fo:
    for _ in range(NUM_ORDERS):
        customer_id = random.randint(1, NUM_CUSTOMERS)
        order_date = fake.date_time_between(start_date="-2y", end_date="now")
        num_lines = random.randint(1, 5)
        total_amount = 0
        log_entries = []

        # PL/SQL block
        fo.write("DECLARE\n  v_order_id NUMBER;\nBEGIN\n")
        fo.write("  v_order_id := orders_seq.NEXTVAL;\n")
        fo.write(f"  INSERT INTO orders (order_id, customer_id, order_date, total_amount, activity_log) VALUES "
                 f"(v_order_id, {customer_id}, TO_DATE('{order_date.strftime('%Y-%m-%d %H:%M:%S')}', 'YYYY-MM-DD HH24:MI:SS'), NULL, EMPTY_CLOB());\n")

        for _ in range(num_lines):
            product_id = random.randint(1, NUM_PRODUCTS)
            quantity = random.randint(1, 3)
            unit_price = round(random.uniform(5, 2000), 2)
            line_total = quantity * unit_price
            total_amount += line_total
            fo.write(f"  INSERT INTO order_lines (order_id, product_id, quantity, unit_price) "
                     f"VALUES (v_order_id, {product_id}, {quantity}, {unit_price});\n")
            log_entries.append(f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - Added product {product_id} x{quantity}")

        log_entries.extend([
            f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - Order processed",
            f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - Shipped via UPS",
            f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - Delivered"
        ])

        full_log = "\n".join(log_entries).replace("'", "''")
        fo.write(f"  UPDATE orders SET total_amount={round(total_amount,2)}, activity_log=TO_CLOB('{full_log}') "
                 f"WHERE order_id=v_order_id;\n")
        fo.write("END;\n/\n")

# =====================
# Ratings
# =====================
with open("ratings.sql", "w") as f:
    for _ in range(NUM_RATINGS):  
        customer_id = random.randint(1, NUM_CUSTOMERS)
        product_id = random.randint(1, NUM_PRODUCTS)
        rating = random.randint(1, 5)
        review = fake.text(max_nb_chars=100).replace('\n', ' ')  # éviter les retours à la ligne
        rating_date = fake.date_between(start_date="-2y", end_date="today")
        f.write(f"INSERT INTO ratings (customer_id, product_id, rating, review, rating_date) "
                f"VALUES ({customer_id}, {product_id}, {rating}, '{review.replace("'", "''")}', "
                f"TO_DATE('{rating_date}', 'YYYY-MM-DD'));\n")
