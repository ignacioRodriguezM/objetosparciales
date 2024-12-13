class Empleado{
    var habilidades = #{}
    var salud
    method incapacitado() = salud < self.saludCritica() //punto 1
    method saludCritica() = rol.saludCritica()
    var rol
    method puedeUsar(habilidad) = not self.incapacitado() and self.posee(habilidad)
    method posee(habilidad) = habilidades.contains(habilidad)
    method cumpleReqs(reqs) = reqs.all{req => self.puedeUsar(req)}
    method recibirDanio(peligrosidad){self.modificarSalud(peligrosidad)}
    method modificarSalud(numero){salud = salud + numero}

    method registrar(habRequeridas){if(self.estaVivo()){rol.terminar(habRequeridas, self)}
    else{self.error('El empleado murio, no se puede registrar nada')}}

    method estaVivo() = salud > 0

    method aprenderHabilidades(nuevas){habilidades.add(nuevas)}
    
    method puedeAscenderAEspia() = rol.suficienteExp()
    method ascenso(){
        if(not self.puedeAscenderAEspia()){self.error('No posee suficiente experiencia')}
        else {self.ascenderAEspia()}
    }
    method ascenderAEspia(){rol = espia}

}
object espia{
    method saludCritica() = 15
    method terminar(habRequeridas, empleado){
        empleado.aprenderHabilidades(habRequeridas)
    }
}
class Oficinista{
    var estrellas
    method saludCritica() = 40 - 5 * estrellas
    method terminar(_,_){estrellas += 1}
    method suficienteExp() = estrellas >= 3
}
class Equipo{
    const integrantes = #{}
    method puedeUsar(habilidades) = integrantes.any{integrante => integrante.cumpleReqs(habilidades)}
    method recibirDanio(peligrosidad) = integrantes.forEach{integrante => integrante.modificarSalud(peligrosidad/3)}
    method registrar(habRequeridas) = integrantes.forEach{integrante => integrante.registrar(habRequeridas)}
}
class Jefe inherits Empleado{
    const subordinados = #{}
    override method posee(habilidad) = super(habilidad) or subordinados.any{subordinado => subordinado.puedeUsar(habilidad)}
}
class Mision{
    const habRequeridas = #{}
    const peligrosidad
    method puedeSerCumplidaPor(unoOMuchos) = habRequeridas.all{hab => unoOMuchos.puedeUsar(hab)}
    method serRealizadaPor(unoOMuchos){
        if(not self.puedeSerCumplidaPor(unoOMuchos)){self.error('La mision no puede ser cumplida')}
        else{self.causarEfectoEn(unoOMuchos)}
    }
    method causarEfectoEn(unoOMuchos){
        unoOMuchos.recibirDanio(peligrosidad)
        unoOMuchos.registrar(habRequeridas)
    }
}