use storedb;

DROP TABLE IF EXISTS customers_load;

CREATE EXTERNAL TABLE customers_load ( id int, name string, contactnm string, addr string, city string, pcode string, cntry string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '${DATAFILE_LOCATION}/customers';

INSERT INTO customers 
 SELECT * FROM customers_load;

DROP TABLE customers_load;
DROP TABLE IF EXISTS categories_load;

CREATE EXTERNAL TABLE categories_load (id int, name string, descr string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '${DATAFILE_LOCATION}/categories';

INSERT INTO categories
 SELECT * FROM categories_load;

DROP TABLE categories_load;
DROP TABLE IF EXISTS employees_load;

CREATE EXTERNAL TABLE employees_load (id int, lname string, fname string, bdte string, phto string, nots string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '${DATAFILE_LOCATION}/employees';

INSERT INTO employees
 SELECT * FROM employees_load;

DROP TABLE employees_load;
DROP TABLE IF EXISTS orderdetails_load;

CREATE EXTERNAL TABLE orderdetails_load (id int, ordrid int, prodid int, qnty int)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '${DATAFILE_LOCATION}/orderdetails';

INSERT INTO orderdetails
 SELECT * FROM orderdetails_load;

DROP TABLE orderdetails_load;
DROP TABLE IF EXISTS orders_load;

CREATE EXTERNAL TABLE orders_load (id int, custid int, empid int, ordrdt string, shprid int)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '${DATAFILE_LOCATION}/orders';

INSERT INTO orders
 SELECT * FROM orders_load;

DROP TABLE orders_load;
DROP TABLE IF EXISTS products_load;

CREATE EXTERNAL TABLE products_load (id int, name int, supid int, catid int, unt string, prc double)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '${DATAFILE_LOCATION}/products';

INSERT INTO products
 SELECT * FROM products_load;

DROP TABLE products_load;
DROP TABLE IF EXISTS shippers_load;

CREATE EXTERNAL TABLE shippers_load (id int, name string, phn string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '${DATAFILE_LOCATION}/shippers';

INSERT INTO shippers
 SELECT * FROM shippers_load;

DROP TABLE shippers_load;
DROP TABLE IF EXISTS suppliers_load;

CREATE EXTERNAL TABLE suppliers_load (id int, name string, contactnm string, addr string, city string, pcode string, cntry string, phn string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
location '${DATAFILE_LOCATION}/suppliers';

INSERT INTO suppliers
 SELECT * FROM suppliers_load;

DROP TABLE suppliers_load;


