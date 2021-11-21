"use strict";
require('dotenv').config();
var Pool = require('pg').Pool;
var pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});
var GETUser = function (req, res) {
    pool.query("SELECT * FROM  usuarios WHERE email = $1", req.email), function (err, respuesta) {
        if (err) {
            console.error(err);
            return;
        }
        else {
            console.log("exito");
        }
    };
};
