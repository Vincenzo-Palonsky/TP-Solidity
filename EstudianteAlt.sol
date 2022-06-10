// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Estudiante{
    string private _nombre;
    string private _apellido;
    string private _curso;
    mapping(string => uint) [4] private bimestres;
    address private _docente;
    string [][] private materias;
    string [] private permitidos;
    
    constructor(string memory nombre_, string memory apellido_, string memory curso_){
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }

    function apellido() public view returns (string memory){
        return _apellido;
    }

    function nombre_completo() public view returns (string memory){
        return string.concat(_nombre, _apellido);
    }

    function curso() public view returns (string memory){
        return _curso;
    }

    function set_nota_materias(string memory materia_, uint bimestre_, uint nota_, string memory bimestreStr_) public{
        require(msg.sender == _docente, "Solo el owner puede setear poderes");
        bimestre_ = bimestre_-1;
        bimestres[bimestre_][materia_] = nota_;
        materias[bimestre_].push(materia_);
    }

    function nota_materia(string memory materia_, uint bimestre_) public view returns (uint){
        return bimestres[bimestre_][materia_];
    }

    function aprobo(string memory materia_, uint bimestre_) public view returns (bool){
        if(bimestres[bimestre_][materia_]>=60){
            return true;
        }
        else{
            return false;
        }
    }

    function promedio() public view returns (uint){
        uint _promedio;
        uint suma;
        
        for(uint i=0; i<4; i++){
            for(uint j=0; j<materias.length; j++){
                suma = suma + bimestres[i][materias[j]];
            }
        }
        
        _promedio = suma/(materias.length*4);
        return _promedio;
    }
}