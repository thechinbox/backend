import {modulo} from './Interfaces/modulo'
import {curso} from './Interfaces/curso'
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

const GETCURSOS = (req:any, res:any) => {
    let cursos = new Array<curso>();
    pool.query('SELECT cu.clavecurso, CONCAT(pro.nombres, \' \', pro.apellidos) as profesor, nombrecurso, descripcion FROM curso cu INNER JOIN profesional pro ON cu.rutpro = pro.rutpro  WHERE publicado = true AND cerrado = false AND cu.clavecurso NOT IN (SELECT curs.clavecurso FROM curso curs INNER JOIN participante par ON (par.rutcomun = $1 AND par.clavecurso = curs.clavecurso))',
        [req.body.rut] , (err:any, resp:any)=>{
        if (err) {
            console.error(err);
            return;
        }else{
            for (let row of resp.rows) {
                let modulos = new Array<modulo>();          
                let curso = {"clavecurso":row.clavecurso, "profesor": row.profesor, "nombrecurso": row.nombrecurso, "descripcion":row.descripcion, "modulos": modulos }              
                cursos.push(curso)
            }    
        } 
        res.send(JSON.stringify(cursos))  
    })
}

module.exports ={
    GETCURSOS
}