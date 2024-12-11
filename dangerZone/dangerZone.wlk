//empleado.incapacitado()
//empleado.puedeUsar(habilidad)
//equipo.cumplirMision(mision) || empleado.cumplirMision(mision)
class Empleado {
    const habilidades = []
    var salud 
    var puesto
    method incapacitado() = salud < puesto.saludCritica()
    method puedeUsar(habilidad) = not self.incapacitado() && self.poseeHabilidad(habilidad)
    method poseeHabilidad(habilidad) = habilidades.contains(habilidad)
    method puedeUsarTodas(habilidadesRequeridas) = habilidadesRequeridas.all{habilidad => self.puedeUsar(habilidad)}
    method recibirDanio(cantidad){ salud -= cantidad}
    method finalizarMision(mision){
        if (self.estaVivo()) {
            self.completarMision(mision)
        }
    }
    method estaVivo() = salud > 0
    method completarMision(mision){
        puesto.completarMision(mision, self)
    }
}
class Oficinista inherits Empleado{
    var cantidadDeEstrellas = 10
    method saludCritica() = 40 - 5 * cantidadDeEstrellas
    method completarMision(mision, empleado)
}
object espia {
    method saludCritica() = 15
    method completarMision(mision, empleado){
        
    }
}
class Jefe inherits Empleado {
    const subordinados = []
    override method poseeHabilidad(habilidad) 
        = super(habilidad) || self.algunSubordinadoLaPuedeUsar(habilidad)

    method algunSubordinadoLaPuedeUsar(habilidad) 
        = subordinados.any{subordinado => subordinado.poseeHabilidad(habilidad)}
}
class Mision {
    const habilidadesRequeridas = []
    var peligrosidad = 100
    method cumplirMision(asignado) {
        self.validarHabilidades(asignado)
        asignado.recibirDanio(peligrosidad)
        asignado.finalizarMision(self)
}

    method validarHabilidades(asignado){
        if (not self.reuneHabilidadesRequeridas(asignado)){
            self.error('No se puede realizar la mision')}
    }

    method reuneHabilidadesRequeridas(asignado) = habilidadesRequeridas.all{hab => asignado.puedeUsar(hab)}
}
object equipo{
    const integrantes = #{}
    method puedeUsar()
    method recibirDanio(peligrosidad)
    method finalizarMision(mision)
}