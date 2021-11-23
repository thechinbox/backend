"use strict";
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var cors = require('cors');
var registrocomun = require('./registro');
var logincomun = require('./login');
var cursos = require('./cursos');
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
app.get('/getcursos', cursos.GETCURSOS);
app.get("/", function (req, res) {
    res.json("Corriendo Servidor");
    console.log("yep");
});
app.listen(configuracion, function () {
    console.log("Conectando al servidor http://" + configuracion.hostname + ":" + configuracion.port);
});
