import { empresa } from "./empresa";

export interface oferta{
    idoferta:number,
    fechapublicacion:Date,
    descripcion:string,
    ubicacion:string,
    cargo:string,
    empresa:empresa
};