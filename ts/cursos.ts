import {modulo} from './Interfaces/modulo';
import {curso} from './Interfaces/curso'

require('dotenv').config();
const Pool = require('pg').Pool;
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});
const pool2 = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});

async function GETMOUDULOS() {
    
}

const GETCURSOS = (req:any, res:any) => {
    let cursos = new Array<curso>();
    pool.query( 'SELECT clavecurso, CONCAT(pro.nombres, \' \', pro.apellidos) as profesor, nombrecurso, descripcion FROM curso cu INNER JOIN profesional pro ON cu.rutpro = pro.rutpro' , (err:any, resp:any)=>{
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
        console.log(cursos);
        res.send(JSON.stringify(cursos))  
    })
}

module.exports ={
    GETCURSOS
}