// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Estudiante{
    string private _nombre;
    string private _apellido;
    string private _curso;
    mapping(string => uint) private notas_materias;
    address private _docente;
    string [] private materias;
    
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
        return string.concat(_nombre, " ", _apellido);
    }

    function curso() public view returns (string memory){
        return _curso;
    }

    function set_nota_materias(string memory materia_, uint nota_) public{
        require(msg.sender == _docente, "Solo el owner puede setear poderes");
        bool insertar = true;
        for(uint i=0; i<materias.length; i++){
            if(keccak256(bytes(materia_)) == keccak256(bytes(materias[i]))){
                insertar = false;
            }
        }

        if(insertar){
            notas_materias[materia_] = nota_;
            materias.push(materia_);
        }
        else{
            notas_materias[materia_] = nota_;
        }
    }

    function nota_materia(string memory materia_) public view returns (uint){
        return notas_materias[materia_];
    }

    function aprobo(string memory materia_) public view returns (bool){
        if(notas_materias[materia_]>=60){
            return true;
        }
        else{
            return false;
        }
    }

    function promedio() public view returns (uint){
        uint _promedio;
        uint _suma;
        
        if(materias.length == 0){
            _promedio = 0;
        }
        else{
            for(uint i=0; i<materias.length; i++){
                _suma = _suma + notas_materias[materias[i]];
            }
            _promedio = _suma/materias.length;
        }

        return _promedio;
    }
}