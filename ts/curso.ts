import {clase} from './Interfaces/clase'
require('dotenv').config();
const Pool = require('pg').Pool;
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});

const GETCURSO = (req:any, res:any) =>{
    let clases= new Array<clase>();
    pool.query('SELECT modulo.nombremodulo, clase.* FROM clase INNER JOIN modulo ON (clase.idmodulo = modulo.idmodulo AND clase.clavecurso = modulo.clavecurso) WHERE clase.clavecurso = $1 ', [Number(req.body.clavecurso)],
        (err:any, resp:any)=>{
            if(err){
                console.log(err);
                return;
            }else{
                for(let row of resp.rows){
                    clases.push(row);
                }
                res.send(JSON.stringify(clases))
            }
        })
}
module.exports ={
    GETCURSO
}