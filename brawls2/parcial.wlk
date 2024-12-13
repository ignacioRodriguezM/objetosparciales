class Personaje{
    var copas
    method modificarCopas(numero){copas = copas + numero}
    method destreza()
    method estrategia()
}
class Arquero inherits Personaje{
    const rango
    const agilidad
    override method destreza() = agilidad * rango
    override method estrategia() = (rango > 100)
}
class Guerrera inherits Personaje{
    const estrategia
    const fuerza
    override method estrategia() = estrategia
    override method destreza() = fuerza * 1.5
}
class Ballestero inherits Arquero{
    override method destreza() = super() * 2
}
class Mision{
    // const integrantes = []
    const dificultad
    const tipo
    method dificultad() = dificultad
    method copasFinal() = tipo.copardas(self)
    method copasBase(players)
    method puedeSerSuperadaPor(personaje)
    method serRealizadaPor(personaje)
}
object comun{
    method copardas(mision, participantes) = mision.copasBase(participantes)
}
class Boost{
    const multiplicador
    method copardas(mision, participantes) = mision.copasBase(participantes) * multiplicador
    }
class Bonus{
    method copardas(mision, participantes) = mision.copasBase(participantes) + participantes.size()
}
class MisionIndividual inherits Mision{
    override method copasBase(_) = dificultad * 2
    override method puedeSerSuperadaPor(personaje) = (personaje.estrategia() or (personaje.destreza() > dificultad))
    override method serRealizadaPor(personaje){
        if(personaje.copas() < 10){self.error('Mision no puede comenzar')}
        else if(self.puedeSerSuperadaPor(personaje)) {personaje.modificarCopas(self.copasFinal())}
        else{personaje.modificarCopas(-self.copasFinal())}
    }
}
class MisionEquipo inherits Mision{
    override method copasBase(participantes) = 50 / participantes.size()
    override method puedeSerSuperadaPor(participantes) = self.estrategicos(participantes) or self.tienenDestrezaMayorA(participantes,400)
    method estrategicos(participantes) = participantes.filter{integrante => integrante.estrategia()}.size() > participantes.size() / 2
    method tienenDestrezaMayorA(participantes, numero) = participantes.all{integrante => integrante.destreza() > numero}
    override method serRealizadaPor(personajes){
        if(self.noSonCoperos(personajes)){self.error('Mision no puede comenzar')}
        else if(self.puedeSerSuperadaPor(personajes)){self.modificarCopasATodos(personajes, self.copasFinal())}
        else {self.modificarCopasATodos(personajes, - self.copasFinal())}
    }
    method noSonCoperos(personajes) = personajes.sum{personaje => personaje.copas()} < 60
    method modificarCopasATodos(personajes,copas){personajes.forEach{personaje => personaje.modificarCopas(copas)}}
}
