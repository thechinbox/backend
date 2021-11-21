"use strict";
require('dotenv').config();
var Pool_registro = require('pg').Pool;
var pool_usuario = new Pool_registro({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});
var PostUsuario = function (req, res) {
    pool_usuario.query('INSERT INTO "usuarios" (rut,clave,email,idtipo) VALUES($1,$2,$3,$4)', [req.body.rut, req.body.clave, req.body.email, 1], function (err, resp) {
        if (err) {
            console.log(err);
        }
        else {
            pool_usuario.query('INSERT INTO "comun" (rutcomun,nombres,apellidos,pais,ciudad,telefono) VALUES($1,$2,$3,$4,$5,$6)', [req.body.rut, req.body.nombres, req.body.apellidos, req.body.pais, req.body.ciudad, req.body.telefono], function (err2, resp2) {
                if (err2) {
                    console.log(err2);
                }
                else {
                    res.send(JSON.stringify({ "status": "ok" }));
                }
            });
        }
    });
    /*Hacer trigger en la bd que borre la insercion si es que no existe en ambas tablas */
};
module.exports = {
    PostUsuario: PostUsuario
};
