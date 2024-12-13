class Propiedad{
    const tamanio
    method tamanio() = tamanio

    const ambientes
    method ambientes() = ambientes

    var tipoDePublicacion

    var tipoPropiedad

    method valor() = tipoPropiedad.valor(self) + self.plusPorZona()

    const zona
    const reservaAsociada

    method reservada() = reservaAsociada.estado()

    method plusPorZona() = zona.plus()

    method reservar()
}
class Casa inherits Propiedad{
    const valorParticular
    method valor(_) = valorParticular + self.plusPorZona()
}
class PH inherits Propiedad{
    method valor(propiedad) = 500000.max(14000*propiedad.tamanio()) + self.plusPorZona()
}
class Depto inherits Propiedad{
    method valor(propiedad) = 350000 * propiedad.abientes() + self.plusPorZona()
}
class Zona{
    const plus
    method plus() = plus
}
class Alquiler{
    const meses
    method comision(propiedad) = meses * propiedad.valor() / 50000
}
class Venta{
    var porcentaje
    method modificarPorcentaje(numero){porcentaje = numero}
    method comision(propiedad) = propiedad.valor() * (porcentaje/100)
}
class Empleado{
    const operacionesCerradas = #{}
    method intentarReservarPropiedad(propiedad){

    } 
    method intentarConcretar(propiedad)
}
class OperacionCerrada{
    const empleado
}
class Cliente{
}
class Reserva{
    const estado
    method estado() = estado
    var cliente
    const empleado
    const propiedad
}
object inmobiliaria{
    
}