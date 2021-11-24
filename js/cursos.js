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
var GETCURSOS = function (req, res) {
    var cursos = new Array();
    pool.query('SELECT clavecurso, CONCAT(pro.nombres, \' \', pro.apellidos) as profesor, nombrecurso, descripcion FROM curso cu INNER JOIN profesional pro ON cu.rutpro = pro.rutpro WHERE NOT EXISTS (SELECT clavecurso FROM participante WHERE rutcomun = $1 )', [req.body.rut], function (err, resp) {
        if (err) {
            console.error(err);
            return;
        }
        else {
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                var modulos = new Array();
                var curso_1 = { "clavecurso": row.clavecurso, "profesor": row.profesor, "nombrecurso": row.nombrecurso, "descripcion": row.descripcion, "modulos": modulos };
                cursos.push(curso_1);
            }
        }
        console.log(cursos);
        res.send(JSON.stringify(cursos));
    });
};
module.exports = {
    GETCURSOS: GETCURSOS
};
