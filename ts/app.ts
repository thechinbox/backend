const express = require('express')
const app = express();
const bodyParser = require('body-parser');
const cors=require('cors');
const registrocomun = require('./registro')
const login = require('./login')
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
app.post('/logincomun', bodyParser.json(), login.LOGINCCOMUN)
app.post('/loginpro', bodyParser.json(), login.LOGINPRO)
app.post('/loginempresa', bodyParser.json(), login.LOGINEMPRESA)
app.post('/getcurso', bodyParser.json(), curso.GETCURSO)
app.post('/postcurso', bodyParser.json(), curso.POST_CURSO)
app.post('/postmodulo', bodyParser.json(), curso.POST_MODULO)
app.post('/postclase', bodyParser.json(), curso.POST_CLASE)
app.post('/participar', bodyParser.json(), curso.POST_PARTC)
app.post('/postpublicar', bodyParser.json(), curso.POSTPUBLICAR)
app.post('/postcerrar', bodyParser.json(), curso.POSTCERRAR)
app.post('/getcursos', bodyParser.json(), cursos.GETCURSOS)
app.post('/getcursospro', bodyParser.json(), cursos.GETCURSOSPRO)
app.post('/getpart', bodyParser.json(), part.GETCURSOSPARTC)
app.post('/getmicurso', bodyParser.json(), part.GETCURSO_PARTC)
app.post('/getprogreso', bodyParser.json(), part.GETPROGRESO)
app.post('/postfin', bodyParser.json(), part.POSTFIN)
app.post('/postprogreso', bodyParser.json(), part.POSTPROG)
app.post('/getcertificados', bodyParser.json(), certificado.GETCERT)
app.post('/getofertas',bodyParser.json(),ofertas.GETOFERTAS)
app.post('/getofertasempresa',bodyParser.json(),ofertas.GETOFERTASEMPRESA)
app.post('/getsolicitudesempresa',bodyParser.json(),ofertas.GETSOLICITUDESEMPRESA)
app.post('/postsolicitud', bodyParser.json(), ofertas.POSTPOST)
app.post('/postoferta', bodyParser.json(), ofertas.POSTOFERTA)
app.get("/", (req:any, res:any) => {
    res.json("Corriendo Servidor");
});

app.listen(configuracion, () => {
    console.log(`Conectando al servidor http://${configuracion.hostname}:${configuracion.port}`)
})