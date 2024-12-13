//punto 1) a) que se puede ejecutar agente.vender(paquete,alma)
class Alma{
    const dineroAlMorir
    const accionesBuenas
    method accionesBuenas() = accionesBuenas
    method capital() = dineroAlMorir + accionesBuenas
    method puedeCostear(monto) = self.capital() >= monto
}
object deptoMuerte{
    const paquetesPredefinidos = []
    method paquetesPredefinidos() = paquetesPredefinidos
    var agentes = #{}
    method mejorAgente() = agentes.max{agente => agente.cantidadPaquetesVendidos()}

    method diaMuertos(){
        self.mejorAgente().modificarDeuda(-50)
        self.liberarNoEndeudados()
        self.castigar()
    }
    method liberarNoEndeudados(){agentes = agentes.filter{agente => agente.deudaActual() > 0}}
    method castigar(){agentes.forEach{agente => agente.modificarDeuda(100)}}
}
class Agente{
    var ventas = []
    var deuda
    method cantidadPaquetesVendidos() = ventas.size()
    method modificarDeuda(monto) {deuda += monto}
    method dineroTotal() = ventas.sum{venta => venta.costo()}

    method deudaActual() = 0.max(deuda - self.dineroTotal()) //para que no tenga deuda negativa

    method vender(paquete, alma){
        if (not alma.puedeCostear(paquete.costoPara(alma))){self.error('El alma no posee suficiente capital para comprar el paquete')}
        else{const nuevaVenta = new Venta(alma = alma, paquete = paquete)
        ventas.add(nuevaVenta)
        }
    }
    var estrategia
    method atender(alma) = self.vender(estrategia.asignarPaquete(alma), alma)
    }
    method cambiarEstrategia(nueva){estrategia = nueva}
}
object clasica{
    method asignarPaquete(alma) = self.elMasCaroDeLosQuePuedeCostear(alma)
    method todosLosQuePuedeCostear(alma) = deptoMuerte.paquetesPredefinidos().filter{paquete => alma.puedeCostear(paquete)}
    method elMasCaroDeLosQuePuedeCostear(alma) = todosLosQuePuedeCostear().max{paquete => paquete.costoPara(alma)}
        }
}
object navegante{
    method asignarPaquete(alma){if(alma.accionesBuenas() >= 50){
        const cruceroTop = new PaqueteCrucero(valorBasico = alma.accionesBuenas())
        return cruceroTop
    }else{
        const botecitoTranquilo = new PaqueteBote(valorBasico = alma.accionesBuenas())
        return botecitoTranquilo
    }
    }
}
object indiferente{
    method asignarPaquete(alma){
    const naufrago = new PaquetePaloConBrujula(valorBasico = 1.randomUpTo(300))
    return naufrago
    }
}
class Paquete{
    const valorBasico
    method aniosQueReduce(alma)
    method costoPara(alma) = 350.min(valorBasico * self.aniosQueReduce(alma))
}
class PaqueteTren inherits Paquete{
    override method anioQueReduce(_) = 4
}
class PaqueteBote inherits Paquete{
    override method aniosQueReduce(alma) = 2.min(alma.accionesBuenas()/50)
}
class PaqueteCrucero inherits PaqueteBote{
    override method aniosQueReduce(alma) = super(alma) * 2
}
class PaquetePaloConBrujula inherits Paquete{
    method aniosQueReduce(alma) = 0.05
    override method costoPara(alma) = valorBasico
}

class Venta{
    const alma
    const paquete
    method paquete() = paquete

    method costo() = paquete.costoPara(alma)
}