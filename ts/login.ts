import {Comun} from './Interfaces/comun';
import { profesional } from './Interfaces/profesional';
import { empresa } from './Interfaces/empresa';


require('dotenv').config();
const Pool = require('pg').Pool;
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});

const LOGINCCOMUN= (req:any, res:any) => {
    let comun = new Array<Comun>();
    
    pool.query(`SELECT us.rut, us.email, cm.nombres, cm.apellidos, cm.pais, cm.ciudad, cm.telefono FROM usuarios us INNER JOIN comun cm ON cm.rutcomun=us.rut WHERE email = $1 AND clave= $2`,
        [req.body.email,req.body.clave],(errpool:any, respool:any) => {
        if (errpool) {
            console.error(errpool);
            return;
        }else{
            for (let row of respool.rows) {
                comun.push(row)               
            }
            res.send(JSON.stringify(comun))
        }
    })
}

const LOGINPRO= (req:any, res:any) => {
    let pro:profesional;
    
    pool.query(`SELECT us.rut, us.email, pro.nombres, pro.apellidos, pro.pais, pro.ciudad, pro.telefono, pro.anoegreso, pro.casaestudio FROM usuarios us INNER JOIN profesional pro ON pro.rutpro=us.rut WHERE email = $1 AND clave= $2`,
        [req.body.email,req.body.clave],(errpool:any, respool:any) => {
        if (errpool) {
            console.error(errpool);
            return;
        }else{
            for (let row of respool.rows) {
                pro = row;               
            }
            res.send(JSON.stringify(pro))
        }
    })
}

const LOGINEMPRESA= (req:any, res:any) => {
    let empresa:empresa;
    pool.query(`SELECT us.rut as rutempresa, us.email, emp.nombreempresa, emp.logo, emp.pais, emp.ciudad, emp.telefono, emp.descripcion FROM usuarios us INNER JOIN empresa emp ON emp.rutempresa=us.rut WHERE email = $1 AND clave= $2`,
        [req.body.email,req.body.clave],(errpool:any, respool:any) => {
        if (errpool) {
            console.error(errpool);
            return;
        }else{
            for (let row of respool.rows) {
                empresa = row;               
            }
            res.send(JSON.stringify(empresa))
        }
    })
}

module.exports = {
    LOGINCCOMUN,
    LOGINPRO,
    LOGINEMPRESA
}