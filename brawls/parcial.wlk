import parcial.*
class Personaje{
    var property copas
    method destreza()
    method estrategia()
    // method realizarMision()
}
class Arquero inherits Personaje{
    const agilidad
    const rango
    override method estrategia() = rango > 100
    override method destreza() = agilidad * rango
}
class Guerrera inherits Personaje{
    const fuerza
    const tieneEstrategia
    override method destreza() = fuerza * 1.5
    override method estrategia() = tieneEstrategia
}
class Ballestero inherits Arquero{
    override method destreza() = super() * 2
}
class Grupo{
    const integrantes = []
    method estrategicos() = integrantes.filter{integrante => integrante.estrategia()}.size() > (integrantes.size()) / 2
    method destrezaMayorA(numero) = integrantes.all{integrante => integrante.destreza() > numero}
    method totalDeCopas() = integrantes.sum{integrante => integrante.copas()}
}
class Mision{
    var tipoDeMision
    method copasEnJuegoBase(grupo)
    method copasEnJuegoFinal(unoOMuchos) = tipoDeMision.cantCopas(self,unoOMuchos)
    const dificultad
    method puedeSerSuperada(unoOMuchos)
    method realizarMision(unoOMuchos)
    method repartirCopas(personaje,numero){personaje.copas(personaje.copas() + numero)}
}
class Individual inherits Mision{
    override method copasEnJuegoBase(x) = dificultad * 2
    override method puedeSerSuperada(personaje) = personaje.estrategia() || (personaje.destreza() > dificultad)
    override method realizarMision(personaje){
        if(personaje.copas() < 10){ self.error ('Mision no puede comenzar')}
        else if(self.puedeSerSuperada(personaje)){
            self.repartirCopas(personaje, self.copasEnJuegoFinal(personaje))
        }
        else {self.repartirCopas(personaje, -(self.copasEnJuegoFinal(personaje)))}
    }

}
class Equipo inherits Mision{
    override method copasEnJuegoBase(grupo) = 50 / grupo.integrantes().size()
    override method puedeSerSuperada(grupo) = grupo.estrategicos() || grupo.destrezaMayorA(400)
    override method realizarMision(grupo){
        if(grupo.totalDeCopas() < 60){self.error('Mision no puede comenzar')}
        else if(self.puedeSerSuperada(grupo)){
            grupo.integrantes().forEach{integrante => self.repartirCopas(integrante, self.copasEnJuegoFinal(grupo))}
        }
        else{grupo.integrantes().forEach{integrante => self.repartirCopas(integrante, -(self.copasEnJuegoFinal(grupo)))}}
    }
}
object Boost {
    const multiplicador
    method cantCopas(mision,unoOMuchos) = mision.copasEnJuegoBase(unoOMuchos) * multiplicador
}
object Bonus {
    method cantCopas(mision, unoOMuchos) = mision.copasEnJuegoBase(unoOMuchos) + unoOMuchos.integrantes().size()
}