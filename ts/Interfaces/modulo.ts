import { clase } from "./clase";

export interface modulo{
    id:number;
    nromodulo:number;
    nombre:string;
    video:string;
    descripcion:string;
    clases: Array<clase>;
} 