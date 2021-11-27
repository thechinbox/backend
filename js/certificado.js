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
var GETCERT = function (req, res) {
    var certificados = new Array();
    pool.query('SELECT CONCAT(co.nombres, \' \', co.apellidos) as nombre_estudiante, CONCAT(pro.nombres, \' \', pro.apellidos) as profesor, cu.nombrecurso as nombre_curso, fechafin as fechaaprob FROM participante par INNER JOIN curso cu ON par.clavecurso = cu.clavecurso	INNER JOIN profesional pro ON pro.rutpro = cu.rutpro INNER JOIN comun co ON co.rutcomun = par.rutcomun WHERE finalizado = true AND par.rutcomun = $1', [req.body.rut], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                certificados.push(row);
            }
            res.send(JSON.stringify(certificados));
        }
    });
};
module.exports = {
    GETCERT: GETCERT
};
