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
    var modulos = new Array();
    pool.query('SELECT mo.nombremodulo,mo.video, mo.descripcionmodulo, clase.* FROM clase INNER JOIN modulo mo ON (clase.idmodulo = mo.idmodulo AND clase.clavecurso = mo.clavecurso) WHERE clase.clavecurso = $2 AND clase.clavecurso NOT IN (SELECT clavecurso FROM participante WHERE rutcomun = $1)', [req.body.rut, Number(req.body.clavecurso)], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            var index_modulo = -1;
            var ids = new Array();
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                if (index_modulo == -1) {
                    modulos.push({ "id": row.idmodulo, "nombre": row.nombremodulo, "descripcion": row.descripcionmodulo, "video": row.video, "clases": new Array() });
                    index_modulo += 1;
                    ids.push(row.idmodulo);
                }
                if (!ids.includes(row.idmodulo)) {
                    modulos.push({ "id": row.idmodulo, "nombre": row.nombremodulo, "descripcion": row.descripcionmodulo, "video": row.video, "clases": new Array() });
                    index_modulo += 1;
                    ids.push(row.idmodulo);
                }
                modulos[index_modulo].clases.push({ "idclase": row.idclase, "nombre": row.nombreclase, "descripcion": row.descripcionclase, "video": row.videoclase, "duracionclase": row.duracionclase });
            }
            res.send(JSON.stringify(modulos));
        }
    });
};
var POST_PARTC = function (req, res) {
    pool.query('INSERT INTO participante(clavecurso,rutcomun,tiempoestudio,finalizado) VALUES($1,$2,0,false) ', [req.body.clavecurso, req.body.rut], function (err, resp) {
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
    GETCURSO: GETCURSO,
    POST_PARTC: POST_PARTC
};
