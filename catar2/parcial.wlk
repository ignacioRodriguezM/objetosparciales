class Plato{
    method cantidadDeAzucar()
    const base = 100
    method calorias() = 3 * self.cantidadDeAzucar() + base
    method bonita()
}
class Entrada inherits Plato{
    override method cantidadDeAzucar() = 100
    override method bonita() = true
}
class Principal inherits Plato{

}
class Postre inherits Plato{
    const colores = 4
    override method cantidadDeAzucar() = 120
    override method bonita() = colores > 3
}
class Cocinero{
    var rol = Chef
    method catar(plato)

    method cambiarEspecialidad(especialidad){rol = especialidad}
}
class Chef{
    const limiteCalorias
    method catar(plato) = if(plato.bonita() and (plato.calorias() <= limiteCalorias)) 10 else 0
}

class Souschef inherits Chef{
    override method catar(plato) = 
        if(not self.bonitoYLight(plato)) 6.min(plato.calorias() / 100) 
        else super(plato)
            
    }
}
class Pastelero{
    const nivelDeDulzor
    method catar(plato) = 10.min(5 * plato.azucar() / nivelDulzorDeseado)
}

