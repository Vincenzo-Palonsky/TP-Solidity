// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Estudiante{
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping(string => uint)[5] private bimestres;
    string [][5] private materias;
    address [] private _docentes;

    constructor(string memory nombre_, string memory apellido_, string memory curso_){
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
        _docentes.push(msg.sender);
    }

    function apellido() public view returns (string memory){
        return _apellido;
    }

    function permisos() public view returns (address){
        return _docentes[1];
    }

    function nombre_completo() public view returns (string memory){
        return string.concat(_nombre, " ", _apellido);
    }

    function curso() public view returns (string memory){
        return _curso;
    }

    function set_nota_materias(string memory materia_, uint bimestre_, uint nota_) public{
        bool puede = false;
        for(uint i=0; i<_docentes.length; i++){
            if (msg.sender == _docentes[i]){
                puede = true;
                break;
            }
        }
        
        require(puede == true, "Requieres permisos para setear notas");
        bool insertar = true;
        for(uint i=0; i<materias[bimestre_-1].length; i++){
            if(keccak256(bytes(materia_)) == keccak256(bytes(materias[bimestre_-1][i]))){
                insertar = false;
            }
        }

        if(insertar){
            bimestres[bimestre_-1][materia_] = nota_;
            materias[bimestre_].push(materia_);
        }
        else{
            bimestres[bimestre_-1][materia_] = nota_;
        }        
    }

    function nota_materia(string memory materia_, uint bimestre_) public view returns (uint){
        return bimestres[bimestre_-1][materia_];
    }

    function aprobo(string memory materia_, uint bimestre_) public view returns (bool){
        if(bimestres[bimestre_-1][materia_]>=60){
            return true;
        }
        else{
            return false;
        }
    }

    // function promedio() public view returns (uint){
    //     uint _promedio;
    //     uint suma;
        
    //     for(uint i=0; i<4; i++){
    //         for(uint j=0; j<materias[i].length; j++){
    //             suma = suma + bimestres[i][materias[i][j]];
    //         }
    //     }
        
    //     _promedio = suma/(materias.length*4);
    //     return _promedio;
    // }

    function set_permiso(address docente_) public{
        require(msg.sender == _docente);
        _docentes.push(docente_);
    }
}