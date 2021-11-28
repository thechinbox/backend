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
    POSTPOST: POSTPOST
};
