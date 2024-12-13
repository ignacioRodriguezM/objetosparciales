class Plato{
    const base = 100
    const cocinero
    method cocinero() = cocinero // para el torneo
    method calorias() = 3 * self.azucar() + base
    method azucar()
    method bonito()
}
class Entrada inherits Plato{
    override method azucar() = 0
    override method bonito() = true
}
class Principal inherits Plato{
    const azucar
    const esBonito
    override method azucar() = azucar
    override method bonito() = esBonito
}
class Postre inherits Plato{
    const azucar = 120
    const colores
    override method azucar() = azucar
    override method bonito() = colores > 3
}
class Cocinero{
    var empleo
    method catar(plato) = empleo.catar(plato)

    method cocinar() = empleo.cocinar()
    
    method cambiarEspecialidad(nueva){empleo = nueva}

    
    method participarEn(torneo) = self.cocinar()

}
class Pastelero{
    const nivelDeseadoAzucar
    method catar(plato) = 10.min(5 * plato.azucar() / nivelDeseadoAzucar)
    method cocinar(){
        const postre = new Postre(cocinero = self, colores = nivelDeseadoAzucar / 50)
        return postre
    }
}
class Chef{
    const cantCalorias
    method catar(plato) = 
    if (self.bonitoYLight(plato)) 10
    else 0
    method bonitoYLight(plato) = plato.bonito() and plato.calorias() < cantCalorias

    method cocinar(){
        const principal = new Principal(cocinero = self, azucar = cantCalorias, esBonito = true)
        return principal
    }

}
class Souschef inherits Chef{
    override method catar(plato) = if (not self.bonitoYLight(plato)) (6.min(plato.calorias()/100))
    else super(plato)

    override method cocinar(){
        const entrada = new Entrada(cocinero = self)
        return entrada
    }
}
class Torneo{
    const catadores = #{}
    const cocineros = #{}
    method cocineroGanador(){
        if(cocineros.isEmpty()){self.error('No se puede establecer al ganador')}
        self.elMejorPlato().cocinero()
    }
    method platosDeTodosLosCocineros() = cocineros.map{cocinero => cocinero.cocinar()}
    
    method elMejorPlato() = self.platosDeTodosLosCocineros().max{plato => self.puntuacionTotal(plato)}

    method puntuacionTotal(plato) = catadores.sum{catador => catador.catar(plato)}
}