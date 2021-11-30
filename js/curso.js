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
    pool.query('SELECT mo.nombremodulo, mo.descripcionmodulo, clase.* FROM clase INNER JOIN modulo mo ON (clase.idmodulo = mo.idmodulo AND clase.clavecurso = mo.clavecurso) WHERE clase.clavecurso = $2 AND clase.clavecurso NOT IN (SELECT clavecurso FROM participante WHERE rutcomun = $1)', [req.body.rut, Number(req.body.clavecurso)], function (err, resp) {
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
                    modulos.push({ "id": row.idmodulo, "nombre": row.nombremodulo, "descripcion": row.descripcionmodulo, "clases": new Array() });
                    index_modulo += 1;
                    ids.push(row.idmodulo);
                }
                if (!ids.includes(row.idmodulo)) {
                    modulos.push({ "id": row.idmodulo, "nombre": row.nombremodulo, "descripcion": row.descripcionmodulo, "clases": new Array() });
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
var POST_CURSO = function (req, res) {
    pool.query('INSERT INTO curso(rutpro, nombrecurso,descripcion,duracioncurso,publicado,cerrado) VALUES($1,$2,$3,$4,$5,$6) RETURNING clavecurso', [req.body.rut, req.body.curso.nombrecurso, req.body.curso.descripcion, 0, req.body.publicar, false], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                res.send(JSON.stringify({ "clavecurso": row.clavecurso }));
            }
        }
    });
};
var POST_MODULO = function (req, res) {
    pool.query('INSERT INTO modulo(clavecurso, idmodulo, nombremodulo, descripcionmodulo, duracionmodulo) VALUES($1,$2,$3,$4,$5)', [Number(req.body.clavecurso.clavecurso), Number(req.body.modulo.id), req.body.modulo.nombre, req.body.modulo.descripcion, 0], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            res.send(JSON.stringify({ "status": "ok" }));
        }
    });
};
var POST_CLASE = function (req, res) {
    pool.query('INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase) VALUES($1,$2,$3,$4,$5,$6,&7)', [Number(req.body.clase.idclase), Number(req.body.idmodulo), Number(req.body.clavecurso.clavecurso), req.body.clase.nombre, req.body.clase.descripcion, req.body.clase.video, 0], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                res.send(JSON.stringify({ "clavecurso": row.clavecurso }));
            }
        }
    });
};
module.exports = {
    GETCURSO: GETCURSO,
    POST_PARTC: POST_PARTC,
    POST_CURSO: POST_CURSO,
    POST_MODULO: POST_MODULO,
    POST_CLASE: POST_CLASE
};
