const express = require('express')
const app = express();
const bodyParser = require('body-parser');
const cors=require('cors');
const registrocomun = require('./registro')

// create application/json parser

const configuracion={
    hostname: "127.0.0.1",
    port: 8080,
}

app.use(cors());
// create application/json parser
app.use(bodyParser.json());

app.post('/registrocomun',bodyParser.json(),registrocomun.PostUsuario);

app.get("/", (req:any, res:any) => {
    res.json({ message: "Welcome to bezkoder application." });
});

app.listen(configuracion, () => {
    console.log(`Conectando al servidor http://${configuracion.hostname}:${configuracion.port}`)
})