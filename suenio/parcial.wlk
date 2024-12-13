class Persona{
    const suenios = []
    method sueniosPendientes() = suenios.filter{suenio => not suenio.estaCumplido()}
    const edad
    var carreras = []
    const plataQueDesea
    method plataQueDesea() = plataQueDesea
    const lugares = []
    var hijos
    method hijos() = hijos
    method tieneHijos() = hijos > 0
    method intentarCumplirSuenio(suenio){
        if(not self.sueniosPendientes().contains(suenio)) self.error('Este no es un suenio pendiente')
        else suenio.intentarCumlpir(self)
    }
    method viajarA(lugar){lugares.add(lugar)}
    method agregarHijos(x){hijos = hijos + x}
    method sumarTitulo(tituloNuevo){carreras = carreras + tituloNuevo}
    
    method cumplirSuenioMasPreciado()
}
class Realista inherits Persona{
    override method cumplirSuenioMasPreciado(){
        self.elMasImportante().intentarCumplir(self)
    }
method elMasImportante() = suenios.max{suenio => suenio.importancia()}
}
class Alocado inherits Persona{
    override method cumplirSuenioMasPreciado(){
        self.unSuenioRandom().intentarCumplir(self)
    }
method unSuenioRandom() = suenios.random()
}
class Obsesivos inherits Persona{
    override method cumplirSuenioMasPreciado(){
        self.elPrimeroDeLaLista().intentarCumplir(self)
    }
method elPrimeroDeLaLista() = suenios.first()
}
class Suenio{
    const importancia
    method importancia() = importancia
    var cumplido = false
    method estaCumplido() = cumplido
    method cambiarACumplido(){cumplido = true}
}
class RecibirseDeCarrera inherits Suenio{
    const carrera
    method intentarCumplir(persona){self.cumplir(persona)}
    method cumplir(persona){
        persona.sumarTitulo(carrera)
        self.cambiarACumplido()
    }
}
class ConseguirNuevoTrabajo inherits Suenio{
    const nuevoSueldo
    method intentarCumplir(persona){
        if(persona.plataQueDesea() > nuevoSueldo) self.error('Este nuevo trabajo no es para vos')
        else self.cumplir(persona)
    }
    method cumplir(persona){ ? }
}
class AdoptarHijo inherits Suenio{
    const cantidadHijos
    method intentarCumplir(persona){
        if(persona.tieneHijos()) self.error('Ya tenes un hijo, no podes adoptar otro')
        else self.cumplir(persona)
    }
    method cumplir(persona){

        persona.agregarHijos(cantidadHijos)
        self.cambiarACumplido()
    }
}
class ViajarAUnLugar inherits Suenio{
    const lugar
    method intentarCumplir(persona){self.cumplir(persona)}
    method cumplir(persona){
        persona.viajarA(lugar)
        self.cambiarACumplido()
    }
}
class SuenioMultiple{
    const suenios = #{}
}