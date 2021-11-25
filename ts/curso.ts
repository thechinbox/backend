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
    pool.query('SELECT modulo.nombremodulo, clase.* FROM clase INNER JOIN modulo ON (clase.idmodulo = modulo.idmodulo AND clase.clavecurso = modulo.clavecurso) WHERE modulo.clavecurso = $2 AND modulo.clavecurso NOT IN (SELECT clavecurso FROM participante WHERE rutcomun = $1)', 
        [req.body.rut,Number(req.body.clavecurso)],(err:any, resp:any)=>{
            if(err){
                console.log(err);
                return;
            }else{
                for(let row of resp.rows){
                    clases.push(row);
                    console.log(row);
                    
                }
                console.log(clases);
                res.send(JSON.stringify(clases))
            }
        })
}

const POST_PARTC = (req:any, res:any)=>{
    pool.query('INSERT INTO participante(clavecurso,rutcomun,tasavance,tiempoestudio,finalizado) VALUES($1,$2,0,0,false) ',
        [req.body.clavecurso,req.body.rut],(err:any,resp:any)=>{
        if(err){
            console.log(err);
            return;
        }else{
            res.send(JSON.stringify({"status":"ok"}))
        }

    })
}

const GETCURSO_PARTC = (req:any, res:any) =>{
    pool.query()
}

module.exports ={
    GETCURSO,
    POST_PARTC
}