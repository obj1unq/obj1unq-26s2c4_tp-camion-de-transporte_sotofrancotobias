import cosas.*

object camion {
	const property cosas = []

	const property maxPeso = 2500 
	
	method cargar(cosa) {
		self.validarPeso(cosa)
		cosas.add(cosa)
	}

	method descargar(cosa) {
		self.validarCargado(cosa)
		cosas.remove(cosa)
	}

	method validarCargado(cosa) {
		if (not self.estaCargado(cosa)) {
			self.error("No está cargado " + cosa)
		}
	}

	method estaCargado(cosa) {
		return cosas.contains(cosa)
	}

	method validarPeso(cosa) {
		if ((self.pesoTotal() + cosa.peso()) > maxPeso) {
			self.error("Excede el peso maximo")
		}
	}

	method pesoEnCamion() {
		return cosas.sum({ cosa => cosa.peso() })
	}

	method pesoTotal() {
		return 1000 + self.pesoEnCamion()
	}

	method excedidoDePeso() {
	  return (self.pesoTotal() > maxPeso)
	}

	method objetosPeligrosos(nivel) {
		return cosas.filter({ cosa => (cosa.nivelPeligrosidad() > nivel) })
	}

	method objetosMasPeligrososQue(cosa) {
		return cosas.filter({ objeto => (objeto.nivelPeligrosidad() > cosa.nivelPeligrosidad()) })
	}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
		return not cosas.any({ cosa => (cosa.nivelPeligrosidad() > nivelMaximoPeligrosidad) })
	}
}
