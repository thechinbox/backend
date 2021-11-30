import { clase } from "./clase";

export interface modulo{
    id:number;
    nombre:string;
    descripcion:string;
    clases: Array<clase>;
} 