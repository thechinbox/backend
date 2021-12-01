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
var LOGINPRO = function (req, res) {
    var pro;
    pool.query("SELECT us.rut, us.email, pro.nombres, pro.apellidos, pro.pais, pro.ciudad, pro.telefono, pro.anoegreso, pro.casaestudio FROM usuarios us INNER JOIN profesional pro ON pro.rutpro=us.rut WHERE email = $1 AND clave= $2", [req.body.email, req.body.clave], function (errpool, respool) {
        if (errpool) {
            console.error(errpool);
            return;
        }
        else {
            for (var _i = 0, _a = respool.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                pro = row;
            }
            res.send(JSON.stringify(pro));
        }
    });
};
var LOGINEMPRESA = function (req, res) {
    var empresa;
    pool.query("SELECT us.rut as rutempresa, us.email, emp.nombreempresa, emp.logo, emp.pais, emp.ciudad, emp.telefono, emp.descripcion FROM usuarios us INNER JOIN empresa emp ON emp.rutempresa=us.rut WHERE email = $1 AND clave= $2", [req.body.email, req.body.clave], function (errpool, respool) {
        if (errpool) {
            console.error(errpool);
            return;
        }
        else {
            for (var _i = 0, _a = respool.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                empresa = row;
            }
            res.send(JSON.stringify(empresa));
        }
    });
};
module.exports = {
    LOGINCCOMUN: LOGINCCOMUN,
    LOGINPRO: LOGINPRO,
    LOGINEMPRESA: LOGINEMPRESA
};
