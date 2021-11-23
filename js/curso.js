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
    pool.query('SELECT modulo.nombremodulo, clase.* FROM clase INNER JOIN modulo ON (clase.idmodulo = modulo.idmodulo AND clase.clavecurso = modulo.clavecurso) WHERE clase.clavecurso = $1 ', [Number(req.body.clavecurso)], function (err, resp) {
        if (err) {
            console.log(err);
            return;
        }
        else {
            for (var _i = 0, _a = resp.rows; _i < _a.length; _i++) {
                var row = _a[_i];
                console.log("la row");
                clases.push(row);
            }
            res.send(JSON.stringify(clases));
        }
    });
};
module.exports = {
    GETCURSO: GETCURSO
};
