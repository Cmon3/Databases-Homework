const express = require("express");
const app = express();
const { Pool } = require('pg');
const secret = require('./secrets.json');

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

app.get("/products", function(req, res) {
    pool.query("SELECT p.product_name, s.supplier_name FROM products p inner join suppliers s on s.id = p.supplier_id where s.country= 'United Kingdom'", (error, result) => {
        console.log(error);
        res.json(result.rows);
    });
});

app.listen(3000, function() {
    console.log("Server is listening on port 3000. Ready to accept requests!");
});