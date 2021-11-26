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

const GETCURSOSPARTC = (req:any, res:any)=>{
    let cursos = new Array<curso>();
    pool.query('SELECT cu.clavecurso, CONCAT(pro.nombres, \' \', pro.apellidos) as profesor, nombrecurso, descripcion FROM curso cu INNER JOIN profesional pro ON cu.rutpro = pro.rutpro  INNER JOIN participante pa ON (pa.rutcomun = $1 AND pa.clavecurso = cu.clavecurso AND pa.finalizado = false)',
        [req.body.rut],(err:any, resp:any)=>{  
        if(err){
            console.log(err);
            return;
        }else{
            for (let row of resp.rows) {
                let curso = {"clavecurso":row.clavecurso, "profesor": row.profesor, "nombrecurso": row.nombrecurso, "descripcion":row.descripcion, "modulos": new Array<modulo>()}              
                cursos.push(curso)
            }  
        }
        res.send(JSON.stringify(cursos)) 

    })

}
const GETCURSO_PARTC = (req:any, res:any) =>{
    let curso:curso;
    pool.query('SELECT CONCAT(pro.nombres, \' \', pro.apellidos) as profesor, cu.nombrecurso, cu.descripcion, mo.nromodulo_curso,mo.nombremodulo,mo.video, mo.descripcionmodulo, clase.* FROM clase INNER JOIN modulo mo ON (clase.idmodulo = mo.idmodulo AND clase.clavecurso = mo.clavecurso) INNER JOIN curso cu ON cu.clavecurso = clase.clavecurso INNER JOIN profesional pro ON cu.rutpro = pro.rutpro WHERE clase.clavecurso = $2 AND clase.clavecurso IN (SELECT clavecurso FROM participante WHERE rutcomun = $1)', 
        [req.body.rut,Number(req.body.clavecurso)],(err:any, resp:any)=>{
            if(err){
                console.log(err);
                return;
            }else{
                let index_modulo = -1;
                let ids = new Array<number>();
                for(let row of resp.rows){
                    if(index_modulo == -1){
                        curso = {"clavecurso":row.clavecurso, "nombrecurso": row.nombrecurso, "profesor":row.profesor,"descripcion":row.descripcion,"modulos":new Array<modulo>()}
                        curso.modulos.push({"id":row.idmodulo, "nombre":row.nombremodulo, "nromodulo":row.nromodulo_curso, "descripcion":row.descripcionmodulo, "video":row.video, "clases":new Array<clase>()})
                        index_modulo += 1;
                        ids.push(row.idmodulo)
                    }
                    if(!ids.includes(row.idmodulo) ){
                        curso.modulos.push({"id":row.idmodulo, "nombre":row.nombremodulo, "nromodulo":row.nromodulo_curso, "descripcion":row.descripcionmodulo, "video":row.video, "clases":new Array<clase>()})
                        index_modulo += 1;
                        ids.push(row.idmodulo)
                    }
                    curso.modulos[index_modulo].clases.push({"idclase":row.idclase,"nombre":row.nombreclase,"descripcion":row.descripcionclase,"nroclase":row.nroclase_modulo,"video":row.videoclase});
                    
                }
                res.send(JSON.stringify(curso))
            }
    })
}

module.exports ={
    GETCURSOSPARTC,
    GETCURSO_PARTC
}



/*
const GETCURSOSPARTC = (req:any, res:any)=>{
    let cursos = new Array<curso>();
    pool.query('SELECT DISTINCT cu.clavecurso, cu.nombrecurso, cu.descripcion,(SELECT CONCAT(nombres, \' \',apellidos) FROM profesional WHERE rutpro = cu.rutpro) as profesor, cu.nromodulos, mo.idmodulo,mo.nombremodulo, mo.video , mo.descripcionmodulo, mo.duracionmodulo, cl.idclase, cl.nombreclase, cl.descripcionclase, cl.videoclase  FROM curso cu INNER JOIN modulo mo ON mo.clavecurso = cu.clavecurso INNER JOIN clase cl ON cl.idmodulo = mo.idmodulo INNER JOIN participante pa ON (pa.rutcomun = $1 AND pa.clavecurso = cu.clavecurso)',
        [req.body.rut], (err:any,resp:any)=>{
        if(err){
            console.log("aqui estoy");
            console.log(err);
            return;
        }else{
            let curso_actual = resp.rows[0].clavecurso;
            let modulo_actual = resp.rows[0].idmodulo;
            let index_curso = 0;
            let index_modulo = 0;
            let nuevocurso:curso = {"clavecurso": resp.rows[0].clavecurso, "descripcion":resp.rows[0].descripcion, "nombrecurso":resp.rows[0].nombrecurso, 
                                    "profesor":resp.rows[0].profesor, "modulos": new Array<modulo>()}
            cursos.push(nuevocurso)
            let modulo:modulo = {"id":resp.rows[0].idmodulo,"descripcion":resp.rows[0].descripcionmodulo,"nombre":resp.rows[0].nombremodulo,"duracion":resp.rows[0].duracionmodulo,
                                    "video":resp.rows[0].video, "clases": new Array<clase>()};
            cursos[index_curso].modulos.push(modulo);
            for (let row of resp.rows) {
                let clase:clase;
                if(row.clavecurso = curso_actual){
                    if(modulo_actual = row.idmodulo){
                        clase = {"idclase": row.idclase,"nombre": row.nombreclase, "descripcion": row.descripcionclase, "video":row.videoclase,
                                "nombremodulo":undefined};
                        cursos[index_curso].modulos[index_modulo].clases.push(clase);
                    }else{
                        let modulo:modulo = {"id":row.idmodulo,"descripcion":row.descripcionmodulo,"nombre":row.nombremodulo,"duracion":row.duracionmodulo,
                                                "video":row.video, "clases": new Array<clase>()};
                        cursos[index_curso].modulos.push(modulo);
                        index_modulo +=1;
                        modulo_actual = row.idmodulo;
                        clase = {"idclase": row.idclase,"nombre": row.nombreclase, "descripcion": row.descripcionclase, "video":row.videoclase,
                                "nombremodulo":undefined};
                        cursos[index_curso].modulos[index_modulo].clases.push(clase);
                    }
                }else{
                    curso_actual = row.clavecurso;
                    modulo_actual = row.idmodulo;
                    let nuevocurso:curso = {"clavecurso": row.clavecurso, "descripcion":row.descripcion, "nombrecurso":row.nombrecurso, 
                                            "profesor":row.profesor, "modulos": new Array<modulo>()}
                    cursos.push(nuevocurso)
                    let modulo:modulo = {"id":row.idmodulo,"descripcion":row.descripcionmodulo,"nombre":row.nombremodulo,"duracion":row.duracionmodulo,
                                                "video":row.video, "clases": new Array<clase>()};
                    cursos[index_curso].modulos.push(modulo);
                    index_modulo +=1;
                    clase = {"idclase": row.idclase,"nombre": row.nombreclase, "descripcion": row.descripcionclase, "video":row.videoclase,
                                "nombremodulo":undefined};
                    cursos[index_curso].modulos[index_modulo].clases.push(clase);
                }       
            }            
            res.send(JSON.stringify(cursos));    
        }
    })
}*/