object knightRider {

	method peso() { return 500 }

	method nivelPeligrosidad() { return 10 }

	method modificacionCarga() {
	  
	}

	method bultos() {
	  return 1
	}
}

object bumblebee {
	var transformadoEnAuto = true
	
	method peso() { return 800 }

	method nivelPeligrosidad() { return if (transformadoEnAuto) { 15 } else { 30 }  }

	method transformar() { transformadoEnAuto = not transformadoEnAuto }

	method modificacionCarga() {
	  self.transformar()
	}

	method bultos() {
	  return 2
	}
}

object paqueteLadrillos {
	var property cantLadrillos = 0

	method peso() { 
		return 2 * self.cantLadrillos() + 10 * self.cantRefuerzos()
	}

	method cantRefuerzos() {
		return if (self.cantLadrillos() <= 1000) {
					(self.cantLadrillos() / 100).roundUp(0)
				} 
				else {
					(self.cantLadrillos() / 50).roundUp(0)
				}
	}

	method nivelPeligrosidad() { 
		return if (self.cantRefuerzos() > 50) 0 else 50 - self.cantRefuerzos()
	}

	method modificacionCarga() {
	  cantLadrillos -= 12
	}

	method bultos() {
	  return if (self.cantLadrillos() <= 100) 1 
	  	else if (self.cantLadrillos() > 100 && self.cantLadrillos() <= 300) 2
		else 3
	}
}

object arenaGranel {
	var property peso = 0

	method nivelPeligrosidad() {
		return 1
	}

	method modificacionCarga() {
	  peso -= 15
	}

	method bultos() {
	  return 1
	}
}

object bateriaAntiaerea {
	var misilesCargados = false
	
	method peso() { return if (misilesCargados) { 300 } else { 200 } }

	method nivelPeligrosidad() { return if (misilesCargados) { 100 } else { 0 }  }

	method cargarMisiles() { misilesCargados = not misilesCargados }

	method modificacionCarga() {
	  self.cargarMisiles()
	}

	method misilesCargados() {
	  return misilesCargados
	}

	method bultos() {
	  return if (not misilesCargados) 1 else 2
	}
}

object contenedorPortuario {
	const property cosasAdentro = []

	method meterCosa(cosa) {
		cosasAdentro.add(cosa)
	}

	method peso() {
		return 100 + self.pesoCosas()
	}

	method pesoCosas() {
		return cosasAdentro.sum({ cosa => cosa.peso() })
	}

	method nivelPeligrosidad() {
		return if (cosasAdentro.isEmpty()) {
				0
		}
		else {
			self.peligrosidadConCarga()
		}
	}

	method peligrosidadConCarga() {
		return self.objetoMasPeligroso().nivelPeligrosidad()
	}

	method objetoMasPeligroso() {
		return cosasAdentro.max({ cosa => cosa.nivelPeligrosidad()})
	}

	method modificacionCarga() {
	  cosasAdentro.forEach({ cosa => cosa.modificacionCarga()})
	}

	method bultos() {
	  return 1 + self.cantBultos()
	}

	method cantBultos() {
	  return cosasAdentro.sum({ cosa => cosa.bultos() })
	}
}

object residuosRadioactivos {
	var property peso = 0

	method nivelPeligrosidad() {
		return 200
	}

	method modificacionCarga() {
	  peso += 15
	}

	method bultos() {
	  return 1
	}
}

object embalajeSeguridad {
	var property cosaEmbalada = bumblebee

	method peso() {
		return cosaEmbalada.peso()
	}

	method nivelPeligrosidad() {
		return cosaEmbalada.nivelPeligrosidad() / 2
	}

	method modificacionCarga() {
	  
	}

	method bultos() {
	  return 2
	}
}