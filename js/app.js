"use strict";
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var cors = require('cors');
var registrocomun = require('./registro');
var logincomun = require('./login');
var cursos = require('./cursos');
var curso = require('./curso');
var part = require('./participante');
var certificado = require('./certificado');
var ofertas = require('./ofertas');
// create application/json parser
var configuracion = {
    hostname: "127.0.0.1",
    port: 8080,
};
app.use(cors());
// create application/json parser
app.use(bodyParser.json());
app.post('/registrocomun', bodyParser.json(), registrocomun.PostUsuario);
app.post('/logincomun', bodyParser.json(), logincomun.LOGINCCOMUN);
app.post('/getcurso', bodyParser.json(), curso.GETCURSO);
app.post('/participar', bodyParser.json(), curso.POST_PARTC);
app.post('/getcursos', bodyParser.json(), cursos.GETCURSOS);
app.post('/getpart', bodyParser.json(), part.GETCURSOSPARTC);
app.post('/getmicurso', bodyParser.json(), part.GETCURSO_PARTC);
app.post('/getprogreso', bodyParser.json(), part.GETPROGRESO);
app.post('/postfin', bodyParser.json(), part.POSTFIN);
app.post('/postprogreso', bodyParser.json(), part.POSTPROG);
app.post('/getcertificados', bodyParser.json(), certificado.GETCERT);
app.get('/getofertas', ofertas.GETOFERTAS);
app.get("/", function (req, res) {
    res.json("Corriendo Servidor");
});
app.listen(configuracion, function () {
    console.log("Conectando al servidor http://" + configuracion.hostname + ":" + configuracion.port);
});
