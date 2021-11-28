import { empresa } from "./Interfaces/empresa";
import { oferta } from "./Interfaces/oferta";

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
    pool.query('SELECT emp.nombreempresa, emp.pais, emp.ciudad, emp.telefono, emp.descripcion as descripcionem, usr.email, ofl.* FROM ofertalaboral ofl INNER JOIN empresa emp ON emp.rutempresa = ofl.rutempresa INNER JOIN usuarios usr ON usr.rut = ofl.rutempresa WHERE cerrada = false', 
        (err:any,resp:any)=>{
        
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
module.exports ={
    GETOFERTAS
}