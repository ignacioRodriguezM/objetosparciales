class Noticia{
    const fecha
    const autor
    const importancia
    const titulo = []
    const desarrollo
    method desarrollo() = desarrollo
    const tipo
    method copada() = self.importante() and self.reciente()
    method importante() = importancia >= 8
    method reciente() = fechaActual - fecha < 3
    method tienePalabras(palabras) = palabras.any{palabra => titulo.contains(palabra)}
    method bienEscrita() = titulo.size() >= 2 and desarrollo > 0
}
class Comun inherits Noticia{
    const links
    override method copada() = super() and self.masDeXLinks(2)
    method masDeXLinks(numero) = links > numero
}
class PublicidadEncubierta inherits Noticia{
    const producto
    const pauta
    override method copada() = super() and self.pautaMayorA(2000000)
    method pautaMayorA(numero) = pauta > numero
}
class Reportaje inherits Noticia{
    const artista
    override method copada() = super() and not artista.length().even()
    method reportajeA() = artista
}
class Cobertura inherits Noticia{
    const noticiasRelacionadas = []
    override method copada() = super() and self.otrasCopadas(noticiasRelacionadas)
    method otrasCopadas(noticias) = noticias.all{noticia => noticia.copada()}
}
class Autor{
    const fechaIngreso
    const preferencia
    var forzadas
    method forzadas() = forzadas
    method aumentarForzadas(){forzadas = forzadas + 1}
    
    method publicar(noticia) = 
    if(not preferencia.cumple(noticia)) self.aumentarForzadas()
    else if(self.forzadas() > 2) self.error('No se puede publicar la noticia')
    else self.darNoticia(noticia)
    
    method darNoticia(noticia)
}
object noticiasCopadas{
    method cumple(noticia) = noticia.copada()
}
class Sensacionalista{
    const palabras = []
    method cumple(noticia) = if(noticia.tipo() == 'reportaje') (noticia.reportajeA() == 'Dibu Martinez' and noticia.tienePalabras(palabras))
    else noticia.tienePalabras(palabras)
}
class Vagos{
    method cumple(noticia) = noticia.tipo() == 'chivo' or noticia.desarrollo() < 100
}
class PreferenciasJoseDeZer{
    method cumple(noticia) = noticia.titulo().first().first() == 'T' //tomo la primera letra de la primera palabra del string titulo
}
class BienEscrita{
    method cumple(noticia) = noticia.bienEscrita()
}
object medio{
    const periodistas = #{}
    method periodistasRecientes() = periodistas.filter{periodista => fechaActual - periodista.fechaIngreso() <= 365}
}