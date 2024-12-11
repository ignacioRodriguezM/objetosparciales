class Linea {
  var numeroDeTelefono
  const packsActivos = []
  const consumos = []

  method consumoDeInternet()
  method consumoDeLlamadas()

}
class Packs{
  method beneficio()
}
class CreditoDisponible inherits Packs {
  var creditoDisponible = 25
  override beneficio() = 
}
class MBLibresParaNavegar inherits Packs{
  var megasParaNavegar = 
  override method() = 
}