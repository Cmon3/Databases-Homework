drop table if exists order_items;
drop table if exists orders;
drop table if exists customers;
drop table if exists products;
drop table if exists suppliers;

CREATE TABLE customers (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(50) NOT NULL,
  address  VARCHAR(120),
  city     VARCHAR(30),
  country  VARCHAR(20)
);

CREATE TABLE suppliers (
    id              SERIAL PRIMARY KEY,
    supplier_name   VARCHAR(100) NOT NULL,
    country         VARCHAR(20) NOT NULL
);

CREATE TABLE products (
    id             SERIAL PRIMARY KEY,
    product_name   VARCHAR(100) NOT NULL,
    unit_price     INT NOT NULL,
    supplier_id    INT REFERENCES suppliers(id)
);

CREATE TABLE orders (
    id              SERIAL PRIMARY KEY,
    order_date      DATE NOT NULL,
    order_reference VARCHAR(10) NOT NULL,
    customer_id     INT REFERENCES customers(id)
);

CREATE TABLE order_items (
    id          SERIAL PRIMARY KEY,
    order_id    INT REFERENCES orders(id),
    product_id  INT REFERENCES products(id),
    quantity    INT NOT NULL
);

INSERT INTO customers (name, address, city, country) VALUES ('Guy Crawford','770-2839 Ligula Road','Paris','France');
INSERT INTO customers (name, address, city, country) VALUES ('Hope Crosby','P.O. Box 276, 4976 Sit Rd.','Steyr','United Kingdom');
INSERT INTO customers (name, address, city, country) VALUES ('Britanney Kirkland','P.O. Box 577, 5601 Sem, St.','Little Rock','United Kingdom');
INSERT INTO customers (name, address, city, country) VALUES ('Amber Tran','6967 Ac Road','Villafranca Asti','United States');
INSERT INTO customers (name, address, city, country) VALUES ('Edan Higgins','Ap #840-3255 Tincidunt St.','Arles','United States');
INSERT INTO customers (name, address, city, country) VALUES ('Quintessa Austin','597-2737 Nunc Rd.','Saint-Marc','United Kingdom');

INSERT INTO suppliers (supplier_name, country) VALUES ('Amazon', 'United States');
INSERT INTO suppliers (supplier_name, country) VALUES ('Taobao', 'China');
INSERT INTO suppliers (supplier_name, country) VALUES ('Argos', 'United Kingdom');
INSERT INTO suppliers (supplier_name, country) VALUES ('Sainsburys', 'United Kingdom');

INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Tee Shirt Olympic Games', 20, 1);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Tee Shirt Olympic Games', 18, 2);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Tee Shirt Olympic Games', 21, 3);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Mobile Phone X', 299, 1);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Mobile Phone X', 249, 4);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Super warm socks', 10, 1);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Super warm socks', 5, 2);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Super warm socks', 8, 3);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Super warm socks', 10, 4);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Le Petit Prince', 10, 1);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Le Petit Prince', 10, 4);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Ball', 14, 1);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Ball', 15, 4);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Ball', 20, 2);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Javascript Book', 40, 1);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Javascript Book', 39, 3);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Javascript Book', 41, 2);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Coffee Cup', 3, 1);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Coffee Cup', 4, 2);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Coffee Cup', 4, 3);
INSERT INTO products (product_name, unit_price, supplier_id) VALUES ('Coffee Cup', 5, 4);

INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-06-01', 'ORD001', 1);
INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-07-15', 'ORD002', 1);
INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-07-11', 'ORD003', 1);
INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-05-24', 'ORD004', 2);
INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-05-30', 'ORD005', 3);
INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-07-05', 'ORD006', 4);
INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-04-05', 'ORD007', 4);
INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-07-23', 'ORD008', 5);
INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-07-24', 'ORD009', 5);
INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2019-05-10', 'ORD010', 5);

INSERT INTO order_items (order_id, product_id, quantity) VALUES(1, 2, 1);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(1, 7, 5);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(2, 8, 4);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(2, 11, 1);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(3, 20, 10);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(3, 14, 2);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(4, 4, 1);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(5, 16, 2);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(5, 10, 1);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(6, 19, 3);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(6, 17, 1);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(6, 11, 1);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(6, 9, 3);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(7, 8, 15);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(8, 1, 1);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(8, 5, 1);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(9, 13, 2);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(10, 14, 1);
INSERT INTO order_items (order_id, product_id, quantity) VALUES(10, 6, 5);

select * from customers;

select * from suppliers;

select c."name", c.address from customers c 
where c.country = 'United States';

select * from customers c 
order by c."name" asc;

select * from products p 
where p.unit_price > 100;

select * from products p 
where p.product_name like '%socks%';

select * from products p 
order by p.unit_price desc 
limit 5;

select p.product_name, p.unit_price, s.supplier_name from products p 
inner join suppliers s on s.id = p.supplier_id; 

select p.product_name, s.supplier_name from products p 
inner join suppliers s on s.id = p.supplier_id
where s.country = 'United Kingdom'; 

select * from orders o 
WHERE o.customer_id = 1;

select * from orders o 
inner join customers c on c.id = o.customer_id 
where c."name" = 'Hope Crosby';

select p.product_name, p.unit_price, oi.quantity from products p 
inner join order_items oi on oi.product_id = p.id 
inner join orders o on o.id = oi.order_id 
where o.order_reference = 'ORD006';

select c."name", o.order_reference, o.order_date, p.product_name, s.supplier_name, oi.quantity from products p 
inner join suppliers s on s.id = p.supplier_id 
inner join order_items oi on oi.product_id = p.id 
inner join orders o on o.id = oi.order_id 
inner join customers c on c.id = o.customer_id;

select c."name" from customers c 
inner join orders o on o.customer_id = c.id 
inner join order_items oi on oi.order_id = o.id 
inner join products p on p.id = oi.product_id 
inner join suppliers s on s.id = p.supplier_id 
where s.country ='China';

--- get the top 5 suppliers who sell the most.
select s.supplier_name, oi.quantity from suppliers s 
inner join products p ON p.supplier_id = s.id 
inner join order_items oi on oi.product_id = p.id 
inner join orders o on o.id = oi.order_id 
order by oi.quantity desc 
limit 5;

--- get top 3 customers that are buying more.
select c."name", sum(oi.quantity) as total_sale from customers c 
inner join orders o on o.customer_id = c.id 
inner join order_items oi on oi.order_id = o.id
group by c.id 
order by total_sale desc
limit 3;
 
--- get the top 2 products that are bought most times. Who is selling those products?
select p.product_name, s.supplier_name, sum(oi.quantity) as total_sale from products p 
inner join suppliers s on s.id = p.supplier_id 
inner join order_items oi on oi.product_id = p.id 
inner join orders o on o.id = oi.order_id 
group by p.product_name, s.supplier_name 
order by total_sale desc
limit 2;

---Class 03/07/21
SELECT p.product_name, s.supplier_name FROM products p 
inner join suppliers s on s.id = p.supplier_id 
where p.product_name like 'B';

SELECT * FROM customers WHERE id=1;

SELECT * FROM customers WHERE name='Hope Crosby';

SELECT * FROM products where supplier_id=1;

UPDATE customers SET name='Mikkel K', address='Chupi Chupi street', city='Moscow', country='Rusia' WHERE id=1;

INSERT INTO orders (order_date, order_reference, customer_id) VALUES ('2021-05-10', 'ORD011', 6);

DELETE FROM orders WHERE id=6;
delete from order_items where order_id=6;

DELETE FROM orders WHERE customer_id=1;
DELETE FROM customers WHERE id=1;

SELECT * FROM orders WHERE customer_id=1;
DELETE FROM customers WHERE id=1;

select o.order_reference, o.order_date, p.product_name, p.unit_price, p.supplier_id, oi.quantity from products p 
inner join order_items oi on oi.product_id = p.id
inner join orders o on o.id = oi.order_id
inner join customers c on c.id = o.customer_id 
where customer_id =3;