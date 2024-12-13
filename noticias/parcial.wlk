class Noticia{ //clase abstracta, no tendria sentido instanciar esta clase
    const fecha
    const autor
    const importancia
    const titulo = []
    const desarrollo = []
    const tipo
    method copada() = self.esImportante() and self.esReciente()
    method esImportante() = importancia >= 8
    method esReciente() = date.today() - fecha < 3
    method tituloContiene(palabra) = titulo.contains(palabra)
    method tieneMenosDeXPalabras(numero) = desarrollo.size() < numero
    method tituloComienzaConLetra(letra) = titulo.first().first() == letra //la primer letra de la primera palabra
    method bienEscrita() = titulo.size() > 2 and not desarrollo.isEmpty()
}
class Comun inherits Noticia{
    const links = []
    override method copada() = super() and links.size() > 2 
}
class Chivo inherits Noticia{
    const plata
    override method copada() = super() and plata > 2000000
}
class Reportaje inherits Noticia{
    const artista
    method artista() = artista
    override method copada() = super() and not artista.length().even()
    method reportajeA(persona) = persona == artista
}
class Cobertura inherits Noticia{
    const noticiasRelacionadas = []
    override method copada() = noticiasRelacionadas.all{noticia => noticia.super()}
}
class Periodista{
    const fechaIngreso
    const preferencia
    method esDeSuPreferencia(noticia) = preferencia.gusta(noticia)
    method publicar(noticia){
        if(not noticia.bienEscrita()){self.error('No esta bien escrita la noticia')}
        
    }
}
object copadas{
    method gusta(noticia) = noticia.copada()
}
class Sensacionalista{
    const palabraDeseada
    method gusta(noticia) =
    if (noticia.tipo() != 'reportaje') noticia.tituloContiene(palabraDeseada)
    else noticia.reportajeA('Dibu Martinez') and noticia.tituloContiene(palabraDeseada)
}
class Vagos{
    const maxPalabras
    method gusta(noticia) = noticia.tipo() == 'chivo' or noticia.tieneMenosDeXPalabras(maxPalabras)
}
object JoseDeZer{
    const letra = 't'
    method gusta(noticia) = noticia.tituloComienzaConLetra(letra)
}
