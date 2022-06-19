# TP-Solidity
Ignacio B. Micaela C. Vincenzo Luca P.

Opcional:
a. ¿Cómo modificarías el Smart Contract para que acepte notas de 4 bimestres?
Para que se acepten notas de 4 bimestres, sería necesario hacer un array de int a mappings. Este tendría cuatro posiciones que irían del primer al cuarto bimestre. De esta forma, cada bimestre tendría un mapping que contenga todas las materias, con sus respectivas notas.

b. Como le permitirias al docente darle permiso a otros docentes de asignar notas
Para que el docente pueda darle permiso a otros docente de asignar notas, deberíamos hacer un require, que pida que para que alguien pueda asignar notas debe estar registrado en un array, el cual nosotros utilizamos como agenda para anotar a los que queremos darle el permiso.

c. Investigar sobre los eventos de Solidity, como incluirías un evento para registrar cuando el docente determina una nota.
Para incluir el evento para registrar cuando determina una nota, haríamos esto:
event Boletin(string_NombreDocente,string_NombreMateria, uint _nota);
emit Boletin(_NombreDocente, _NombreMateria,_nota);
Un evento para nosotros, es una parte de un contrato que almacena datos que se pasan en otros registros anteriores. Estos eventos se usan para mostrar e informar el estado actual del contrato. También nos ayudan a que sepamos cuando hay alguna modificación.
