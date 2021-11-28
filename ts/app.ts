const express = require('express')
const app = express();
const bodyParser = require('body-parser');
const cors=require('cors');
const registrocomun = require('./registro')
const logincomun = require('./login')
const cursos  = require('./cursos')
const curso = require('./curso')
const part = require('./participante')
const certificado = require('./certificado')
const ofertas = require('./ofertas')

// create application/json parser

const configuracion={
    hostname: "127.0.0.1",
    port: 8080,
}

app.use(cors());
// create application/json parser
app.use(bodyParser.json());

app.post('/registrocomun',bodyParser.json(),registrocomun.PostUsuario);
app.post('/logincomun', bodyParser.json(), logincomun.LOGINCCOMUN)
app.post('/getcurso', bodyParser.json(), curso.GETCURSO)
app.post('/participar', bodyParser.json(), curso.POST_PARTC)
app.post('/getcursos', bodyParser.json(), cursos.GETCURSOS)
app.post('/getpart', bodyParser.json(), part.GETCURSOSPARTC)
app.post('/getmicurso', bodyParser.json(), part.GETCURSO_PARTC)
app.post('/getprogreso', bodyParser.json(), part.GETPROGRESO)
app.post('/postfin', bodyParser.json(), part.POSTFIN)
app.post('/postprogreso', bodyParser.json(), part.POSTPROG)
app.post('/getcertificados', bodyParser.json(), certificado.GETCERT)
app.post('/getofertas',bodyParser.json(),ofertas.GETOFERTAS)
app.post('/postsolicitud', bodyParser.json(), ofertas.POSTPOST)
app.get("/", (req:any, res:any) => {
    res.json("Corriendo Servidor");
});

app.listen(configuracion, () => {
    console.log(`Conectando al servidor http://${configuracion.hostname}:${configuracion.port}`)
})