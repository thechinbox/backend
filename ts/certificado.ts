import { certificado } from "./Interfaces/certificado";

require('dotenv').config();
const Pool = require('pg').Pool;
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});

const GETCERT = (req:any, res:any) =>{
    let certificados = new Array<certificado>();
    pool.query('SELECT CONCAT(co.nombres, \' \', co.apellidos) as nombre_estudiante, CONCAT(pro.nombres, \' \', pro.apellidos) as profesor, cu.nombrecurso as nombre_curso, fechafin as fechaaprob FROM participante par INNER JOIN curso cu ON par.clavecurso = cu.clavecurso	INNER JOIN profesional pro ON pro.rutpro = cu.rutpro INNER JOIN comun co ON co.rutcomun = par.rutcomun WHERE finalizado = true AND par.rutcomun = $1', 
        [req.body.rut], (err:any, resp:any)=>{
        if(err){
            console.log(err);
            return;            
        }else{
            for(let row of resp.rows){
                certificados.push(row)
            }
            res.send(JSON.stringify(certificados))
        }

    })
}

module.exports ={
    GETCERT
}
