import dangerZone.*
import dangerZone.*
class Empleado{
    var salud
    const habilidades = #{}
    method estaIncapacitado() =  tipoDeEmpleado.saludCritica() > salud
    var property tipoDeEmpleado = espia
    method puedeUsarHabilidad(habilidad) = not self.estaIncapacitado() && self.poseeHabilidad(habilidad)
    method poseeHabilidad(habilidad) = habilidades.contains(habilidad)
    method modificarSalud(danio) {salud = salud + danio}
    method ultimaParte(mision){
        if(salud > 0){
            tipoDeEmpleado.ultimaParte(mision, self)
        }
    }
}
class Jefe inherits Empleado{
    const subordinados = []
    override method puedeUsarHabilidad(habilidad) = super(habilidad) or subordinados.any{subordinado => subordinado.puedeUsarHabilidad(habilidad)}
}
object espia{
    method saludCritica() = 15
    method ultimaParte(mision, empleado){
        empleado.habilidades().add(mision.habilidadesRequeridas())
        }
    }
class Oficinista{
    var cantidadEstrellas
    method saludCritica() = 40 - 5*cantidadEstrellas
    method ultimaParte(mision, empleado){
        cantidadEstrellas = cantidadEstrellas + 1
        self.chequearAscenso(empleado)
    }
    method chequearAscenso(empleado){
        if(cantidadEstrellas >= 3){
            empleado.tipoDeEmpleado(espia)
        }
    }
}
class Mision{
    const habilidadesRequeridas = []
    const peligrosidad

    method serCumplidaPor(empleado){
        if(not self.reuneHabilidadesRequeridas(empleado)){ self.error("La mision no puede ser cumplida")}
        else {
            empleado.modificarSalud(- peligrosidad)
            empleado.ultimaParte(self)
        }
    }
    method reuneHabilidadesRequeridas(empleado) = habilidadesRequeridas.all{habilidad => empleado.puedeUsarHabilidad(habilidad)}
    }
class Equipo{
    const integrantes = []

    method puedeUsarHabilidad(habilidad) = integrantes.any{integrante => integrante.puedeUsarHabilidad(habilidad)}

    method modificarSalud(danio) = integrantes.forEach{integrante => integrante.modificarSalud(danio/3)}

    method ultimaParte(mision) = integrantes.forEach{integrante => integrante.ultimaParte(mision)}
}