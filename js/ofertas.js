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
var GETOFERTAS = function (req, res) {
    var ofertas = new Array();
    pool.query('SELECT emp.nombreempresa, emp.pais, emp.ciudad, emp.telefono, emp.descripcion as descripcionem, usr.email, ofl.* FROM ofertalaboral ofl INNER JOIN empresa emp ON emp.rutempresa = ofl.rutempresa INNER JOIN usuarios usr ON usr.rut = ofl.rutempresa WHERE cerrada = false AND idoferta NOT IN (SELECT idoferta FROM solicitudempleo WHERE rut = $1)', [req.body.rut], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                var empresa = { "rutempresa": row.rutempresa, "email": row.email, "telefono": row.telefono, "pais": row.pais, "ciudad": row.ciudad, "nombreempresa": row.nombreempresa, "descripcion": row.descripcionem };
                ofertas.push({ "idoferta": row.idoferta, "cargo": row.cargo, "descripcion": row.descripcion, "empresa": empresa, "fechapublicacion": row.fechapublicacion, "ubicacion": row.ubicacion });
            }
            res.send(JSON.stringify({ "status": "ok", "lista": ofertas }));
        }
    });
};
var GETOFERTASEMPRESA = function (req, res) {
    var ofertas = new Array();
    pool.query('SELECT emp.nombreempresa, emp.pais, emp.ciudad, emp.telefono, emp.descripcion as descripcionem, usr.email, ofl.* FROM ofertalaboral ofl INNER JOIN empresa emp ON emp.rutempresa = ofl.rutempresa INNER JOIN usuarios usr ON usr.rut = ofl.rutempresa WHERE cerrada = false AND ofl.rutempresa = $1', [req.body.rutempresa], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                var empresa = { "rutempresa": row.rutempresa, "email": row.email, "telefono": row.telefono, "pais": row.pais, "ciudad": row.ciudad, "nombreempresa": row.nombreempresa, "descripcion": row.descripcionem };
                ofertas.push({ "idoferta": row.idoferta, "cargo": row.cargo, "descripcion": row.descripcion, "empresa": empresa, "fechapublicacion": row.fechapublicacion, "ubicacion": row.ubicacion });
            }
            res.send(JSON.stringify({ "status": "ok", "lista": ofertas }));
        }
    });
};
var GETSOLICITUDESEMPRESA = function (req, res) {
    var postulantes = new Array();
    pool.query('SELECT cm.rutcomun as rut , us.email, cm.nombres, cm.apellidos, cm.pais, cm.ciudad, cm.telefono FROM ofertalaboral ol INNER JOIN solicitudempleo sl ON ol.idoferta = sl.idoferta INNER JOIN comun cm ON sl.rut = cm.rutcomun INNER JOIN usuarios us ON sl.rut= us.rut WHERE ol.idoferta= $1 UNION SELECT pro.rutpro as rut, us.email, pro.nombres, pro.apellidos, pro.pais, pro.ciudad, pro.telefono FROM ofertalaboral ol INNER JOIN solicitudempleo sl ON ol.idoferta = sl.idoferta INNER JOIN profesional pro ON sl.rut = pro.rutpro INNER JOIN usuarios us ON sl.rut = us.rut WHERE ol.idoferta= $1', [Number(req.body.idoferta)], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            var i = 0;
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                postulantes.push({ "nombres": row.nombres, "apellidos": row.apellidos, "rut": row.rut, "email": row.email, "pais": row.pais, "ciudad": row.ciudad, "telefono": row.telefono });
            }
            res.send(JSON.stringify({ "postulantes": postulantes }));
        }
    });
};
var POSTOFERTA = function (req, res) {
    pool.query('INSERT INTO ofertalaboral(rutempresa, fechapublicacion, descripcion, ubicacion, cargo, cerrada) VALUES($1, NOW(), $2, $3, $4, false)', [req.body.rutempresa, req.body.descripcion, req.body.ubicacion, req.body.cargo], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            res.send(JSON.stringify({ "status": "ok" }));
        }
    });
};
var POSTPOST = function (req, res) {
    pool.query('INSERT INTO solicitudempleo(rut, idoferta) VALUES($1, $2)', [req.body.rut, Number(req.body.idoferta)], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            res.send(JSON.stringify({ "status": "ok" }));
        }
    });
};
module.exports = {
    GETOFERTAS: GETOFERTAS,
    POSTPOST: POSTPOST,
    GETSOLICITUDESEMPRESA: GETSOLICITUDESEMPRESA,
    GETOFERTASEMPRESA: GETOFERTASEMPRESA,
    POSTOFERTA: POSTOFERTA
};
