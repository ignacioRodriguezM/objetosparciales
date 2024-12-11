//plato.calorias()
//plato.catar(catador)
//cocinero.cambiarEspecialidad(nuevaEspecialidad)
//cocinero.cocinar()
//cocinero.participar(torneo)
//

class Plato {
    const base = 100
    method azucar()
    method bonito()
    method calorias() = 3 * self.azucar() + base

}
class Entrada inherits Plato{
    override method azucar() = 0
    override method bonito() = true
}
class Principal inherits Plato{
    const azucar
    const bonito

    override method azucar() = azucar
    override method bonito() = bonito
}
class Postre inherits Plato{
    var colores
    override method azucar() = 120
    override method bonito() = colores > 3
}

class Cocinero{
    var especialidad
    method catar(plato) = especialidad.catar(plato)
    method cambiarEspecialidad(nueva){ especialidad = nueva }
    method cocinar() = especialidad.cocinar()

}
class Pastelero {
    var nivelDulzorDeseado
    
    method catar(plato) = 10.min(5 * plato.azucar() / nivelDulzorDeseado)
    
    method cocinar(){
        const postrecito = new Postre(colores = (nivelDulzorDeseado / 50))
        return plato1
    }
}
class Chef {
    var maxCalorias
    
    method catar(plato) = if(self.expectativas(plato)) 10 else 0

    method expectativas(plato) = plato.bonito() and self.platoLight(plato)

    method platoLight(plato) = plato.calorias() <= maxCalorias

    method cocinar(){
        const principal = new Principal(azucar = maxCalorias, bonito = true)
        return principal
    }
}
class Souschef inherits Chef{
    override method catar(plato) 
    = if(not self.expectativas(plato)) 6.min(plato.calorias() / 100) 
        else super(plato)
    
    override method cocinar(){
        const entradita = new Entrada()
        return entradita
    }
    override method participar(){
        self.cocinar()

    }
}
class Torneo{
    const catadores = #{}
    const participantes = #{}
    
    method cocineroGanador(cocineros) = cocineros.all()
}