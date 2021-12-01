import { empresa } from "./Interfaces/empresa";
import { oferta } from "./Interfaces/oferta";
import {Comun} from './Interfaces/comun'

require('dotenv').config();
const Pool = require('pg').Pool;
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});

const GETOFERTAS= (req:any, res:any) =>{
    let ofertas = new Array<oferta>();
    pool.query('SELECT emp.nombreempresa, emp.pais, emp.ciudad, emp.telefono, emp.descripcion as descripcionem, usr.email, ofl.* FROM ofertalaboral ofl INNER JOIN empresa emp ON emp.rutempresa = ofl.rutempresa INNER JOIN usuarios usr ON usr.rut = ofl.rutempresa WHERE cerrada = false AND idoferta NOT IN (SELECT idoferta FROM solicitudempleo WHERE rut = $1)', 
        [req.body.rut], (err:any,resp:any)=>{
        
        if(err){
            console.log(err);
            return;            
        }else{
            for(let row of resp.rows){
                let empresa:empresa = {"rutempresa":row.rutempresa, "email":row.email, "telefono":row.telefono, "pais":row.pais,"ciudad":row.ciudad,"nombreempresa":row.nombreempresa,"descripcion":row.descripcionem};
                ofertas.push({"idoferta":row.idoferta,"cargo":row.cargo,"descripcion":row.descripcion,"empresa":empresa,"fechapublicacion":row.fechapublicacion,"ubicacion":row.ubicacion})
            }
            res.send(JSON.stringify({"status":"ok","lista":ofertas}))
        }
    })
}
const GETOFERTASEMPRESA= (req:any, res:any) =>{
    let ofertas = new Array<oferta>();
    pool.query('SELECT emp.nombreempresa, emp.pais, emp.ciudad, emp.telefono, emp.descripcion as descripcionem, usr.email, ofl.* FROM ofertalaboral ofl INNER JOIN empresa emp ON emp.rutempresa = ofl.rutempresa INNER JOIN usuarios usr ON usr.rut = ofl.rutempresa WHERE cerrada = false AND ofl.rutempresa = $1', 
        [req.body.rutempresa], (err:any,resp:any)=>{
        if(err){
            console.log(err);
            return;            
        }else{
            for(let row of resp.rows){
                let empresa:empresa = {"rutempresa":row.rutempresa, "email":row.email, "telefono":row.telefono, "pais":row.pais,"ciudad":row.ciudad,"nombreempresa":row.nombreempresa,"descripcion":row.descripcionem};
                ofertas.push({"idoferta":row.idoferta,"cargo":row.cargo,"descripcion":row.descripcion,"empresa":empresa,"fechapublicacion":row.fechapublicacion,"ubicacion":row.ubicacion})                
            }
            res.send(JSON.stringify({"status":"ok","lista":ofertas}))
        }
    })
}
const GETSOLICITUDESEMPRESA= (req:any, res:any) =>{
    let postulantes = new Array<Comun>();
    pool.query('SELECT cm.rutcomun as rut , us.email, cm.nombres, cm.apellidos, cm.pais, cm.ciudad, cm.telefono FROM ofertalaboral ol INNER JOIN solicitudempleo sl ON ol.idoferta = sl.idoferta INNER JOIN comun cm ON sl.rut = cm.rutcomun INNER JOIN usuarios us ON sl.rut= us.rut WHERE ol.idoferta= $1 UNION SELECT pro.rutpro as rut, us.email, pro.nombres, pro.apellidos, pro.pais, pro.ciudad, pro.telefono FROM ofertalaboral ol INNER JOIN solicitudempleo sl ON ol.idoferta = sl.idoferta INNER JOIN profesional pro ON sl.rut = pro.rutpro INNER JOIN usuarios us ON sl.rut = us.rut WHERE ol.idoferta= $1', 
        [Number(req.body.idoferta)], (err:any,resp:any)=>{
        if(err){
            console.log(err);
            return;            
        }else{
            let i = 0;
            for(let row of resp.rows){
                postulantes.push({"nombres":row.nombres,"apellidos":row.apellidos,"rut":row.rut, "email": row.email,"pais":row.pais,"ciudad":row.ciudad,"telefono":row.telefono})
            }
            res.send(JSON.stringify({"postulantes":postulantes}))
        }
    })
}

const POSTOFERTA = (req:any,res:any) => {
    pool.query('INSERT INTO ofertalaboral(rutempresa, fechapublicacion, descripcion, ubicacion, cargo, cerrada) VALUES($1, NOW(), $2, $3, $4, false)',
        [req.body.rutempresa, req.body.descripcion, req.body.ubicacion, req.body.cargo], (err:any, resp:any)=>{
        if(err){
            console.log(err);
            return;
        }else{
            res.send(JSON.stringify({"status":"ok"}))
        }
    })
}

const POSTPOST = (req:any,res:any)=> {
    pool.query('INSERT INTO solicitudempleo(rut, idoferta) VALUES($1, $2)',[req.body.rut, Number(req.body.idoferta)], (err:any, resp:any)=>{
        if(err){
            console.log(err);
            return;
        }else{
            res.send(JSON.stringify({"status":"ok"}))
        }
    })
}

module.exports ={
    GETOFERTAS,
    POSTPOST,
    GETSOLICITUDESEMPRESA,
    GETOFERTASEMPRESA,
    POSTOFERTA
}