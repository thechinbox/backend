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
var LOGINCCOMUN = function (req, res) {
    var comun = new Array();
    pool.query("SELECT us.rut, us.email, cm.nombres, cm.apellidos, cm.pais, cm.ciudad, cm.telefono FROM usuarios us INNER JOIN comun cm ON cm.rutcomun=us.rut WHERE email = $1 AND clave= $2", [req.body.email, req.body.clave], function (errpool, respool) {
        if (errpool) {
            console.error(errpool);
            return;
        }
        else {
            for (var _i = 0, _a = respool.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                comun.push(row);
            }
            res.send(JSON.stringify(comun));
        }
    });
};
module.exports = {
    LOGINCCOMUN: LOGINCCOMUN
};
