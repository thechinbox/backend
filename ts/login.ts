require('dotenv').config();
const Pool = require('pg').Pool;
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});

const GETUser= (req:any, res:any) => {
    pool.query(`SELECT * FROM  usuarios WHERE email = $1`, req.email), (err:any, respuesta:any) => {
        if (err) {
            console.error(err);
            return;
        }else{
            console.log("exito");
        }
    }
}