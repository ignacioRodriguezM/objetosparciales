class Expedicion{
    const aldeas = []
    const capitales = []
    const vikingos = []
    method subirVikingo(vikingo){
        if(vikingo.productivo() and vikingo.chequearSeguridad()){
            vikingos.add(vikingo)
        }
        else{ self.error('El vikingo no puede subir a la mision')}
    }
    method valeLaPena() = aldeas.all{aldea => aldea.valeLaPena(vikingos)} and capitales.all{capital => capital.valeLaPena(vikingos)}
}
class Aldea{
    const iglesias = []
    method botin(_) = iglesias.sum{iglesia => iglesia.crucifijos()}
    method valeLaPena(_) = self.botin(_) > 15
}
class AldeaAmurallada inherits Aldea{
    const minimo
    override method valeLaPena(vikingos) = super(vikingos) and vikingos > minimo
}
class Iglesia{
    const crucifijos
    method crucifijos() = crucifijos
}
class Capital{
    const factorRiqueza
    method botin(vikingos) = vikingos * factorRiqueza
    method valeLaPena(atacantes) = self.botin(atacantes) > 3 * atacantes
}
class Soldado {
    const kills
    var armas //para mi pasara a ser lista luego
    method productivo() = self.masDeXKills(20) and self.tieneArmas()
    method masDeXKills(numero) = kills > numero
    method tieneArmas() = armas > 0
    method modificarArmas(numero){armas = armas + numero}
    method escalar() {self.modificarArmas(10)}
}
class Granjero{
    var hijos
    var hectareas
    method productivo() = hectareas >= 2 * hijos
    method tieneArmas() = false
    method modificarHijos(numero){hijos = hijos + numero}
    method modificarHectareas(numero){hectareas = hectareas + numero}
    method escalar(){self.modificarHijos(2) self.modificarHectareas(2)}
}
class Vikingo{
    var property tipoDeVikingo
    method esProductivo() = tipoDeVikingo.productivo()
    method chequearSeguridad() = true
    method ascender()
}
class Esclavo inherits Vikingo{
    override method chequearSeguridad() = not self.tipoDeVikingo().tieneArmas()
    override method ascender(){
        self.tipoDeVikingo(CastaMedia)
        tipoDeVikingo.escalar()
    }
}
class CastaMedia inherits Vikingo{
    override method ascender(){self.tipoDeVikingo(Noble)}
}
class Noble inherits Vikingo{
    override method ascender() {self.error('Esta clase de vikingos, no puede escalar mas socialmente')}
}