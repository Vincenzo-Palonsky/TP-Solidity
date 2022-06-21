// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Estudiante{
    //Declaración variables
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping(string => uint)[5] private bimestres;
    string [][5] private materias;
    address [] private _docentes;
    event registrarNota(address profesor, string materia, uint256 nota);

    //Inicialización de variables
    constructor(string memory nombre_, string memory apellido_, string memory curso_){
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
        _docentes.push(msg.sender);
    }

    //Función devuelve el apellido
    function apellido() public view returns (string memory){
        return _apellido;
    }

    //Función devuelve nombre y apellido
    function nombre_completo() public view returns (string memory){
        return string.concat(_nombre, " ", _apellido);
    }

    //Función devuelve el curso
    function curso() public view returns (string memory){
        return _curso;
    }

    //Función asigna una nota a una materia en un bimestre específico
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
            materias[bimestre_-1].push(materia_);
        }
        else{
            bimestres[bimestre_-1][materia_] = nota_;
        }

        emit registrarNota(msg.sender, materia_, nota_); 
    }

    //Función devuelve la nota de una materia, aclarando el bimestre de la misma
    function nota_materia(string memory materia_, uint bimestre_) public view returns (uint){
        return bimestres[bimestre_-1][materia_];
    }

    //Función devuelve true o false dependiendo de si una materia en un bimestre dado está aprobada
    function aprobo(string memory materia_, uint bimestre_) public view returns (bool){
        if(bimestres[bimestre_-1][materia_]>=60){
            return true;
        }
        else{
            return false;
        }
    }

    //Función devuelve el promedio de las notas de todas las materias de todos los bimestres, el promedio anual total
    function promedio() public view returns (uint){
        uint _promedio;
        uint _suma;
        uint _cantMaterias;

        for(uint i=0; i<4; i++){
            if(materias[i].length == 0){
                _suma += 0;
            }

            else{
                for(uint j=0; j<materias[i].length; j++){
                    _suma = _suma + bimestres[i][materias[i][j]];
                    _cantMaterias++;
                }
            }
        }
        
        _promedio = _suma/_cantMaterias;
        return _promedio;
    }

    //Función permite darle el permiso a un profesor de ponerle la nota a una materia
    function set_permiso(address docente_) public{
        require(msg.sender == _docente);
        _docentes.push(docente_);
    }
}