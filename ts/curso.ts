import {clase} from './Interfaces/clase'
import { curso } from './Interfaces/curso';
import {modulo} from './Interfaces/modulo'
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
    let modulos = new Array<modulo>();
    pool.query('SELECT mo.nombremodulo,mo.video, mo.descripcionmodulo, clase.* FROM clase INNER JOIN modulo mo ON (clase.idmodulo = mo.idmodulo AND clase.clavecurso = mo.clavecurso) WHERE clase.clavecurso = $2 AND clase.clavecurso NOT IN (SELECT clavecurso FROM participante WHERE rutcomun = $1)', 
        [req.body.rut,Number(req.body.clavecurso)],(err:any, resp:any)=>{
            if(err){
                console.log(err);
                return;
            }else{
                let index_modulo = -1;
                let ids = new Array<number>();
                for(let row of resp.rows){
                    if(index_modulo == -1){
                        modulos.push({"id":row.idmodulo, "nombre":row.nombremodulo, "descripcion":row.descripcionmodulo, "video":row.video, "clases":new Array<clase>()})
                        index_modulo += 1;
                        ids.push(row.idmodulo)
                    }
                    if(!ids.includes(row.idmodulo) ){
                        modulos.push({"id":row.idmodulo, "nombre":row.nombremodulo, "descripcion":row.descripcionmodulo, "video":row.video, "clases":new Array<clase>()})
                        index_modulo += 1;
                        ids.push(row.idmodulo)
                    }
                    modulos[index_modulo].clases.push({"idclase":row.idclase,"nombre":row.nombreclase,"descripcion":row.descripcionclase, "video":row.videoclase, "duracionclase":row.duracionclase});
                    
                }
                res.send(JSON.stringify(modulos))
            }
    })
}

const POST_PARTC = (req:any, res:any)=>{
    pool.query('INSERT INTO participante(clavecurso,rutcomun,tiempoestudio,finalizado) VALUES($1,$2,0,false) ',
        [req.body.clavecurso,req.body.rut],(err:any,resp:any)=>{
        if(err){
            console.log(err);
            return;
        }else{
            res.send(JSON.stringify({"status":"ok"}))
        }

    })
}


module.exports ={
    GETCURSO,
    POST_PARTC
}