"use strict";
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var cors = require('cors');
var registrocomun = require('./registro');
// create application/json parser
var configuracion = {
    hostname: "127.0.0.1",
    port: 8080,
};
app.use(cors());
// create application/json parser
app.use(bodyParser.json());
app.post('/registrocomun', bodyParser.json(), registrocomun.PostUsuario);
app.get("/", function (req, res) {
    res.json({ message: "Welcome to bezkoder application." });
});
app.listen(configuracion, function () {
    console.log("Conectando al servidor http://" + configuracion.hostname + ":" + configuracion.port);
});
