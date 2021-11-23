import { modulo } from "./modulo";
export interface curso{
    clavecurso:BigInteger;
    profesor:String;
    nombrecurso:String;
    descripcion:String;
    modulos:Array<modulo> | undefined;
}