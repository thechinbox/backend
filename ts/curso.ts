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
    pool.query('SELECT mo.nombremodulo, mo.descripcionmodulo, clase.* FROM clase INNER JOIN modulo mo ON (clase.idmodulo = mo.idmodulo AND clase.clavecurso = mo.clavecurso) WHERE clase.clavecurso = $2 AND clase.clavecurso NOT IN (SELECT clavecurso FROM participante WHERE rutcomun = $1)', 
        [req.body.rut,Number(req.body.clavecurso)],(err:any, resp:any)=>{
            if(err){
                console.log(err);
                return;
            }else{
                let index_modulo = -1;
                let ids = new Array<number>();
                for(let row of resp.rows){                   
                    if(index_modulo == -1){
                        modulos.push({"id":row.idmodulo, "nombre":row.nombremodulo, "descripcion":row.descripcionmodulo,"clases":new Array<clase>()})
                        index_modulo += 1;
                        ids.push(row.idmodulo)
                    }
                    if(!ids.includes(row.idmodulo) ){
                        modulos.push({"id":row.idmodulo, "nombre":row.nombremodulo, "descripcion":row.descripcionmodulo,"clases":new Array<clase>()})
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

const POST_CURSO = (req:any, res:any) => {
    pool.query('INSERT INTO curso(rutpro, nombrecurso,descripcion,duracioncurso,publicado,cerrado) VALUES($1,$2,$3,$4,$5,$6) RETURNING clavecurso',
    [req.body.rut, req.body.curso.nombrecurso, req.body.curso.descripcion, 0, req.body.publicar, false ], (err:any, resp:any)=>{
        if(err){
            console.log(err);
            return;
        }else{
            for(let row of resp.rows){
                res.send(JSON.stringify({"clavecurso":row.clavecurso}))
            }
        }
    })
}

const POSTPUBLICAR = (req:any, res:any) =>{
    pool.query('UPDATE curso SET publicado = true WHERE clavecurso = $1',[req.body.clavecurso], (err:any, resp:any) =>{
        if(err){
            console.log(err);
            return;
        }else{
            res.send(JSON.stringify({"status":"ok"}))
        }
    })
}
const POSTCERRAR = (req:any, res:any) =>{
    pool.query('UPDATE curso SET cerrado = true WHERE clavecurso = $1',[req.body.clavecurso], (err:any, resp:any) =>{
        if(err){
            console.log(err);
            return;
        }else{
            res.send(JSON.stringify({"status":"ok"}))
        }
    })
}

const POST_MODULO = (req:any, res:any) => {
    pool.query('INSERT INTO modulo(clavecurso, idmodulo, nombremodulo, descripcionmodulo, duracionmodulo) VALUES($1,$2,$3,$4,$5)',
    [Number(req.body.clavecurso.clavecurso), Number(req.body.modulo.id) ,req.body.modulo.nombre, req.body.modulo.descripcion, 0], (err:any, resp:any)=>{
        if(err){
            console.log(err);
            return;
        }else{
            res.send(JSON.stringify({"status":"ok"}))
        }
    })
}

const POST_CLASE= (req:any, res:any) => {    
    pool.query('INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase) VALUES($1,$2,$3,$4,$5,$6,$7)',
    [Number(req.body.clase.idclase),Number(req.body.idmodulo), Number(req.body.clavecurso.clavecurso), req.body.clase.nombre, req.body.clase.descripcion, req.body.clase.video, req.body.clase.duracionclase], (err:any, resp:any)=>{
        if(err){
            console.log(err);
            return;
        }else{
            for(let row of resp.rows){
                res.send(JSON.stringify({"clavecurso":row.clavecurso}))
            }
        }
    })
}

module.exports ={
    GETCURSO,
    POST_PARTC,
    POST_CURSO,
    POST_MODULO,
    POST_CLASE,
    POSTPUBLICAR,
    POSTCERRAR
}