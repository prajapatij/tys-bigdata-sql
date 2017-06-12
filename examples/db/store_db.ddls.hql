create database if not exists storedb;

use storedb;

create table customers ( id int, name string, contactnm string, addr string, city string, pcode string, cntry string)
 stored as parquet;

create table categories (id int, name string, descr string)
 stored as parquet;

create table employees (id int, lname string, fname string, bdte string, phto string, nots string)
 stored as parquet;

create table orderdetails (id int, ordrid int, prodid int, qnty int)
 stored as parquet;

create table orders (id int, custid int, empid int, ordrdt string, shprid int)
 stored as parquet;

create table products (id int, name int, supid int, catid int, unt string, prc double)
 stored as parquet;

create table shippers (id int, name string, phn string)
 stored as parquet;

create table suppliers (id int, name string, contactnm string, addr string, city string, pcode string, cntry string, phn string)
 stored as parquet;


