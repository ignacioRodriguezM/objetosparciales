class Empleado{
    const habilidades = #{}
    var salud
    method salud() = salud
    method saludCritica() = empleo.saludCritica()
    var empleo
    method incapacitado() = salud < self.saludCritica()
    method puedeUsar(habilidad) = (not self.incapacitado() and self.posee(habilidad))
    method posee(habilidad) = habilidades.contains(habilidad)
    method cumpleRequisitos(reqs) = reqs.all{habilidad => self.puedeUsar(habilidad)} //verifica que el empleado cumpla todos los reqs
    method finalizarMision(mision){
        self.modificarSalud(-mision.peligrosidad())
        if(self.salud() > 0){
        empleo.completar(mision, self)
        }
    }
    method modificarSalud(numero){salud = salud + numero}
    method chequearAscenso() = empleo.puedeAscender()// se utilizaria en un futuro para ver si puede hacerse espia
}
object espia{
    method saludCritica() = 15
    method puedeAscender() = false
    method completar(mision, empleado){
        empleado.habilidades().add(mision.requeridas())
    }
}
class Oficinista{
    var estrellas
    method puedeAscender() = self.estrellas() >= 3
    method estrellas() = estrellas
    method saludCritica() = 40 - 5 * self.estrellas()
    method completar(mision, empleado){
        self.modificarEstrellas(1)
    }
    method modificarEstrellas(numero){estrellas = estrellas + numero}

}
class Jefe inherits Empleado{
    const subordinados = []
    override method puedeUsar(habilidad) = (super(habilidad) or self.algunSubordinadoLaPuedeUsar(habilidad))
    method algunSubordinadoLaPuedeUsar(habilidad) = subordinados.any{subordinado => subordinado.puedeUsar(habilidad)}
}
class Mision{
    const peligrosidad
    method peligrosidad() = peligrosidad
    const requeridas = []
    method serCumplidaPor(empleado){
        if(empleado.cumpleRequisitos(requeridas)){ 
            empleado.finalizarMision(self)
         }}
    }
class Equipo{
    const integrantes = []
    method cumpleRequisitos(habilidades) = integrantes.any{integrante => integrante.cumpleRequisitos(habilidades)} 
    //al menos 1 integrante cumple todos
    method finalizarMision(mision){
        integrantes.forEach{integrante => integrante.modificarSalud(mision.peligrosidad() / 3)}
        
    }
}