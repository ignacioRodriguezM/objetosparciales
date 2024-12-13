class Mensaje{
    const autor
    const fijo
    const factorRed = 1.3
    const contenido
    method peso() = 5 * fijo + self.pesoContenido() * factorRed
    method pesoContenido()
}
class Texto inherits Mensaje{
    const caracteres
    override method pesoContenido() = caracteres
}
class Audio inherits Mensaje{
    const duracion
    override method pesoContenido() = duracion * 1.2
}
class Gif inherits Imagen{
    const cuadros
    override method pesoContenido() = super() * cuadros
}
class Contacto inherits Mensaje{
    const usuario
    override method pesoContenido() = 3
}
class Imagen inherits Mensaje{
    const alto
    const ancho
    const modo
    method pixeles() = alto * ancho
    override method pesoContenido() = modo.pesar(self.pixeles()) * 2
}
object original{
    method pesar(original) = original
}
class Variable{
    const porcentaje
    method pesar(original) = original * (porcentaje/100)
}
object maxima{
    method pesar(original) = 10000.min(original)
}

class Usuario{
    var espacioLibre
    method espacioLibre() = espacioLibre
    var chats = [] //dentro de cada chat estan los mensajes que tiene cada chat
    var notificaciones = []

    method notificacionesSinLeer() = notificaciones

    method enviarMensajeAUnChat(chat, mensaje) = chat.enviarMensaje(self, mensaje) //el usuario indica a que chat y que mensaje envia

    method tieneEspacio(mensaje) = self.espacioLibre() >= mensaje.peso()
    // method agregarAMemoria(mensaje){memoria.add(mensaje)}
    method quitarEspacioLibre(mensaje){espacioLibre -= mensaje.peso()}

    method busquedaDeTexto(texto) = chats.filter{chat => chat.tiene(texto)}

    method mensajesMasPesados() = chats.map{chat => chat.mensajeMasPesado()}

    method agregarNotificacion(nueva){notificaciones.add(nueva)}

    method leerChat(chat) = notificaciones.remove(self.notificacionesDeUnChat(chat))
    method notificacionesDeUnChat(chat) = notificaciones.filter{notificacion => notificacion.chatAsociado() == chat}

}
class Notificacion{
    const chatAsociado
    method chatAsociado() = chatAsociado
}
class Chat{
    const chat
    var mensajes = []
    var participantes = #{}
    const creador
    var cantidadMensajes
    method enviarMensaje(alguien,mensaje){ //el chat recibe el mensaje y quien lo quiere enviar
    if(self.estaEnElChat(alguien) and self.amigosTienenEspacio(mensaje)){
        // self.agregarAMemoriaDeTodos(mensaje)
        self.quitarEspacioLibreDeTodos(mensaje)
        cantidadMensajes = cantidadMensajes + 1
        mensajes.add(mensaje)
        const notificacion = new Notificacion(chatAsociado = chat)
        self.notificarATodos(notificacion)
    }
    }
    method estaEnElChat(alguien) = participantes.contains(alguien)
    method amigosTienenEspacio(mensaje) = participantes.all{participante => participante.tieneEspacio(mensaje)}
    // method agregarAMemoriaDeTodos(mensaje) = participantes.forEach{participante => participante.agregarAMemoria(mensaje)}
    method quitarEspacioLibreDeTodos(mensaje) = participantes.forEach{participante => participante.quitarEspacioLibre(mensaje)}
    method notificarATodos(notificacion) = participantes.forEach{participante => participante.sumarNotificacion(notificacion)}
    
    method tiene(texto) = mensajes.contains(texto)

    method espacioQueOcupa() = mensajes.sum{mensaje => mensaje.peso()} //punto 1

    method mensajeMasPesado() = mensajes.max{mensaje => mensaje.peso()}
}
class ChatDifusion inherits Chat{
    override method enviarMensaje(alguien, mensaje){
        if(alguien != creador){self.error('No puede enviar mensaje alguien que no sea admin')}
        else{super(alguien, mensaje)}
    }
}
class ChatRestringido inherits Chat{
    const limiteMensajes
    override method enviarMensaje(alguien, mensaje){
        if(cantidadMensajes >= limiteMensajes){self.error('Se ha llegado al limite de mensaje')}
        else {super(alguien, mensaje)}}
}
class ChatAhorrador inherits Chat{
    const pesoMaximo
    override method enviarMensaje(alguien, mensaje){
        if(mensaje.peso() > pesoMaximo){self.error('El mensaje es muy pesado')}
        else{super(alguien, mensaje)}
    }
}