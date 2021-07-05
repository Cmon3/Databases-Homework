const express = require("express");
const app = express();
const { Pool } = require('pg');
const secret = require('./secrets.json');
const bodyParser = require("body-parser");
app.use(bodyParser.json());

const pool = new Pool(secret);

app.get("/hello", function(req, res) {
    res.send("Hello world")
});

app.get("/customers", function(req, res) {
    pool.query('SELECT * FROM customers', (error, result) => {
        console.log(error);
        res.json(result.rows);
    });
});

app.get("/suppliers", function(req, res) {
    pool.query('SELECT * FROM suppliers', (error, result) => {
        res.json(result.rows);
    });
});

/*app.get("/products", function(req, res) {
    pool.query("SELECT p.product_name, s.supplier_name FROM products p inner join suppliers s on s.id = p.supplier_id where s.country= 'United Kingdom'", (error, result) => {
        console.log(error);
        res.json(result.rows);
    });
});*/

app.get("/products", function (req, res) {
    const productNameQuery = req.query.name;
    console.log(productNameQuery);

         let query = `SELECT p.product_name, s.supplier_name FROM products p inner join suppliers s on s.id = p.supplier_id`;

           if (productNameQuery) {
             query = `SELECT p.product_name, s.supplier_name FROM products p inner join suppliers s on s.id = p.supplier_id 
             where p.product_name like '%${productNameQuery}%'`;
           } 
               
           pool
             .query(query)
             .then((result) => 
               productNameQuery ? res.json(result.rows[0]) :  res.json(result.rows)
               )
             .catch((e) => console.error(e));
});

app.get("/customers/:customerId", function (req, res) {
    const customerId = req.params.customerId;
  
    pool
      .query("SELECT * FROM customers WHERE id=$1", [customerId])
      .then((result) => res.json(result.rows))
      .catch((e) => console.error(e));
  });

app.get("/customers/:customerId/orders", function (req, res) {
    const customerId = req.params.customerId;

    let query = `select o.order_reference, o.order_date, p.product_name, p.unit_price, p.supplier_id, oi.quantity from products p inner join order_items oi on oi.product_id = p.id inner join orders o on o.id = oi.order_id inner join customers c on c.id = o.customer_id where customer_id ='${customerId}'`;         
           pool
             .query(query)
             .then((result) => res.json(result.rows))
             .catch((e) => console.error(e));
});


app.post("/customers", function (req, res) {
    const newCustomerName = req.body.name;
    const newAddress = req.body.address;
    const newCity = req.body.city; 
    const newCountry = req.body.country;

        pool
        .query("SELECT * FROM customers WHERE name=$1", [newCustomerName])
        .then((result) => {
            if (result.rows.length > 0) {
            return res
                .status(400)
                .send("A customer with the same name already exists!");
            } else {
            const query =
                "INSERT INTO customers (name, address, city, country) VALUES ($1, $2, $3, $4)";
            pool
                .query(query, [newCustomerName, newAddress, newCity, newCountry])
                .then(() => res.send(`Customer ${newCustomerName} created!`))
                .catch((e) => console.error(e));
            }
        });
});

app.post("/products", function (req, res) {
    const newProductName = req.body.name;
    const newPrice = req.body.price;
    const newSupplierId = req.body.supplierId; 

    if (!Number.isInteger(newPrice) || newPrice <= 0) {
        return res
          .status(400)
          .send("The price should be a positive integer.");
      }

        pool
        .query("SELECT * FROM products where supplier_id=$1", [newSupplierId])
        .then((result) => {
            if (!result.rows.length > 0) {
            return res
                .status(400)
                .send("The supplier id does not exists!");
            } else {
            const query =
                "INSERT INTO products (product_name, unit_price, supplier_id) VALUES ($1, $2, $3)";
            pool
                .query(query, [newProductName, newPrice, newSupplierId])
                .then(() => res.send(`Product ${newProductName} created!`))
                .catch((e) => console.error(e));
            }
        });
});

app.post("/customers/:customerId/orders", function (req, res) {
    const customerId = req.params.customerId;
    const newOrderDate = req.body.date;
    const newOrderReference = req.body.reference;

        pool
        .query("SELECT * FROM customers WHERE id=$1", [customerId])
        .then((result) => {
            if (!result.rows.length > 0) {
            return res
                .status(400)
                .send("A customer with that id does not exists!");
            } else {
            const query =
                "INSERT INTO orders (order_date, order_reference, customer_id) VALUES ($1, $2, $3)";
            pool
                .query(query, [newOrderDate, newOrderReference, customerId])
                .then(() => res.send(`Order ${newOrderReference} created!`))
                .catch((e) => console.error(e));
            }
        });
});

app.put("/customers/:customerId", function (req, res) {
    const customerId = req.params.customerId;
    const newName = req.body.name;
    const newAddress = req.body.address;
    const newCity = req.body.city; 
    const newCountry = req.body.country;
    console.log(newName);

    pool
        .query("UPDATE customers SET name=$1, address=$2, city=$3, country=$4 WHERE id=$5", [newName, newAddress, newCity, newCountry, customerId])
        .then(() => res.send(`Customer ${customerId} updated!`))
        .catch((e) => console.error(e));
});

app.delete("/orders/:orderId", function (req, res) {
    const orderId = req.params.orderId;
  
    pool
      .query("DELETE FROM order_items WHERE order_id=$1", [orderId])
      .then(() => {
        pool
          .query("DELETE FROM orders WHERE id=$1", [orderId])
          .then(() => res.send(`Order ${orderId} deleted!`))
          .catch((e) => console.error(e));
      })
      .catch((e) => console.error(e));
  });

  app.delete("/customers/:customerId", function (req, res) {
    const customerId = req.params.customerId;

    pool
    .query("SELECT * FROM orders WHERE customer_id=$1", [customerId])
    .then((result) => {
        if (result.rows.length > 0) {
        return res
            .status(400)
            .send("That customer has pending orders!");
        } else {
        const query =
            "DELETE FROM customers WHERE id=$1";
        pool
          .query(query, [customerId])
          .then(() => res.send(`Customer ${customerId} deleted!`))
          .catch((e) => console.error(e));
        }
      })
  });

app.listen(3000, function() {
    console.log("Server is listening on port 3000. Ready to accept requests!");
});