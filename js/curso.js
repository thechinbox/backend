"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require('dotenv').config();
var Pool = require('pg').Pool;
var pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});
var GETCURSO = function (req, res) {
    var clases = new Array();
    pool.query('SELECT modulo.nombremodulo, clase.* FROM clase INNER JOIN modulo ON (clase.idmodulo = modulo.idmodulo AND clase.clavecurso = modulo.clavecurso) WHERE modulo.clavecurso = $2 AND modulo.clavecurso NOT IN (SELECT clavecurso FROM participante WHERE rutcomun = $1)', [req.body.rut, Number(req.body.clavecurso)], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                clases.push(row);
                console.log(row);
            }
            console.log(clases);
            res.send(JSON.stringify(clases));
        }
    });
};
var POST_PARTC = function (req, res) {
    pool.query('INSERT INTO participante(clavecurso,rutcomun,tasavance,tiempoestudio,finalizado) VALUES($1,$2,0,0,false) ', [req.body.clavecurso, req.body.rut], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            res.send(JSON.stringify({ "status": "ok" }));
        }
    });
};
var GETCURSO_PARTC = function (req, res) {
    pool.query();
};
module.exports = {
    GETCURSO: GETCURSO,
    POST_PARTC: POST_PARTC
};
