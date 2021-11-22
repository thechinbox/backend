import {Comun} from './Interfaces/comun';

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


module.exports = {
    LOGINCCOMUN
}