object registroAbatidosCOD {
	const property registroDias = []
	const property registroAbatidos = []
	
	method agregarAbatidosDia(cantidad, dia) {
		if (registroDias.contains(dia)) {
			self.error("Ya existe registro para el día indicado")
		} 
		else {
			registroDias.add(dia)
			registroAbatidos.add(cantidad)
		}	
	}
	
	method agregarAbatidosVariosDias(listaCantidad,listaDia){
		const diasOrdenados = listaDia.sortedBy({ m, n => m < n})
 		const indicesMutados = (0..listaDia.size()-1).map({k=> self.obtenerIndice(listaDia,diasOrdenados.get(k))})
 		const abatidosOrdenados = indicesMutados.map({k => listaCantidad.get(k)}) 
// 		const abatidosOrdenados = (0..listaDia.size()-1).sortedBy({k,n => listaDia.get(k)<listaDia.get(n)}).map({k=>listaCantidad.get(k)})
 		
		registroDias.addAll(diasOrdenados)
		registroAbatidos.addAll(abatidosOrdenados)
	}
	
	method obtenerIndice(lista,valor){
		return (0..lista.size()-1).find({k => lista.get(k)==valor})
	}
	
	method eliminarElRegistroDelDia(dia){
		registroAbatidos.remove(registroAbatidos.get(self.obtenerIndice(registroDias,dia)))
		registroDias.remove(dia)
	}
	
	method eliminarLosRegistrosDeDias(listaDeDias){
		listaDeDias.forEach({ k => self.eliminarElRegistroDelDia(k)})
	}
	
	method cantidadDeDiasRegistrados() = registroDias.size()
	method estaVacioElRegistro() = registroDias.isEmpty()
	method algunDiaAbatio(cantidad) {
		return registroAbatidos.any({ k => k == cantidad})
	}
	method primerValorDeAbatidos() = registroAbatidos.first()
	method ultimoValorDeAbatidos() = registroAbatidos.last()
	method maximoValorDeAbatidos() = registroAbatidos.max()
	method totalAbatidos() = registroAbatidos.sum()
	method cantidadDeAbatidosElDia(dia) = registroAbatidos.get(self.obtenerIndice(registroDias,dia))
	method ultimoValorDeAbatidosConSize() = registroAbatidos.get(registroAbatidos.size()-1)
	
	
}