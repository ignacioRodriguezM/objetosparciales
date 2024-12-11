class Alma{
    const dineroAlMorir
    const cantAccionesBuenas
    
    method cantAccionesBuenas() = cantAccionesBuenas

    method capital() = dineroAlMorir + cantAccionesBuenas

    method puedeCostear(paquete) = self.capital() >= paquete.costoParaAlma(self)
}
class Venta{
    var paquete
    var alma

    method costo() = paquete.costoParaAlma(alma)
}
class Agente{
    const deudaInicial

    method dineroGanado() = ventas.sum{venta => venta.paquete().costo()}
    
    method deudaActual() = deudaInicial - self.dineroGanado()
    
    method cantidadPaquetesVendidos() = ventas.size()
    
    var estrategia = clasica
    
    const ventas = []
    
    method vender(paquete,alma) = if(alma.capital() < paquete.costoParaAlma(alma)) self.error('No se puede realizar la venta por falta de capital')
    else ventas.add(new Venta(paquete = paquete, alma = alma))

    method modificarDeuda(monto) {self.deudaActual() = self.deudaActual() + monto}
    
    method noTieneDeuda() = self.deudaActual() < 0

    method atenderAlma(alma) = self.vender(estrategia.atender(alma), alma)


    method cambiarEstrategia(nueva){ estrategia = nueva }
    
    }

object clasica{
    method paquetesQuePuedeCostear(alma) = departamento.paquetePredefinidos().filter{paquete => alma.puedeCostear(paquete)}
    method elMaximo(alma) = self.paquetesQuePuedeCostear(alma).max{paquete => paquete.costoParaAlma(alma)}

    method atender(alma) = self.elMaximo(alma)
}
object navegante{
    method atender(alma){
        if(alma.cantAccionesBuenas() >= 50){
            const crucerito = new PaqueteCrucero(valorBasico = 100)
            return crucerito
        }
        else {
            const botecito = new PaqueteBote(valorBasico = alma.cantAccionesBuenas())
            return botecito
        }
    }
}
object indiferente{
    method atender(alma){
        const paloConBrujula = new PaquetePaloConBrujula(valorBasico = 1.randomUpTo(300))
    }
}

class Paquete{
    method costoParaAlma(alma) = 350.min(valorBasico * self.cuantoReduceAAlma(alma))
    const valorBasico
    method cuantoReduceAAlma(alma)
}

class PaqueteTren inherits Paquete{
    override method cuantoReduceAAlma(alma) = 4
}
class PaqueteBote inherits Paquete{
    override method cuantoReduceAAlma(alma) = 2.min(alma.cantAccionesBuenas() / 50)
}
class PaqueteCrucero inherits PaqueteBote{
    override method cuantoReduceAAlma(alma) = super(alma) * 2
}
class PaquetePaloConBrujula inherits Paquete{
    override method cuantoReduceAAlma(alma) = 0.05
    override method costoParaAlma(alma) = valorBasico
}

object departamento{
    var property paquetePredefinidos = []
    const agentes = []
    method mejorAgente() = agentes.max{agente => agente.cantidadPaquetesVendidos()}

    method diaDeLosMuertos(){
        self.mejorAgente().modificarDeuda(-50)
        self.liberarNoEndeudados()
        agentes.forEach{endeudado => endeudado.modificarDeuda(100)}

    }

    method liberarNoEndeudados(){
        agentes.removeAllSuchThat{agente => agente.noTieneDeuda()}
    }

}
