class Mensaje{
    const emisor
    const datosFijos
    var tipoContenido
    method pesoContenido() = tipoContenido.pesoCont() //me lo devuelve en kb
    const factorRed = 1.3
    method peso() = 5 * datosFijos + self.pesoContenido() * factorRed

}
object texto{
    method pesoCont() = 1
}
class Audio {
    const duracion
    method pesoCont() = 1.2 * duracion
}
class Imagen {
    const alto
    const ancho
    method alto() = alto
    method ancho() = ancho
    // const porcentaje
    // method porcentaje() = porcentaje
    method tamanioEnPixeles() = self.alto() * self.ancho()
    var tipoDeCompresion
    method pesoCont() = tipoDeCompresion.comprimido(self) * 2 //kb
}
object compresionOriginal{
    method comprimido(imagen) = imagen.tamanioEnPixeles()
}
class CompresionVariable{
    const porcentaje
    method comprimido(imagen) = (imagen.tamanioEnPixeles()) * (porcentaje/100)
}
object compresionMaxima{
    method comprimido(imagen) = 10000.min(imagen.tamanioEnPixeles())
}
class Gif inherits Imagen{
    const cuadros
    override method pesoCont() = super() * cuadros
}
class ChatClasico{
    const participantes = #{}
    const creador
    method agregarIntegrante(persona) = participantes.add(persona)
    method eliminarIntegrante(persona) = participantes.remove(persona)
    method enviarMensaje(usuario, mensaje){
        if(not participantes.contains(usuario)){self.error('El usuario no pertenece al grupo')}
        else if(participantes.all{participante => participante.espacioLibre() >= mensaje.peso()}){
            self.error('Hay participantes que no pueden recibir tu mensaje')}
        else{self.guardarEnMemoriaDeTodos(mensaje)}    
        }
    method guardarEnMemoriaDeTodos(mensaje) = participantes.forEach{participante => participante.sumarAMemoria(mensaje)}
}
class ChatDifusion inherits ChatClasico{

}
class ChatRestringido inherits ChatClasico{

}
class ChatAhorro inherits ChatClasico{

}
class Usuario{
    const espacioLibre
    method espacioLibre() = espacioLibre
    const memoria = []

    method hablarEnElChat(chat, mensaje) = chat.enviarMensaje(self)
    method sumarAMemoria(mensaje) = memoria.add(mensaje)
}