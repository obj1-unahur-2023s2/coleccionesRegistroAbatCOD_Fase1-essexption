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
		const diasOrdenados = listaDia.sortedBy({ m, n => m <= n})
 		const indicesMutados = (0..listaDia.size()-1).map({k=> self.obtenerIndice(listaDia,diasOrdenados.get(k))})
 		const abatidosOrdenados = indicesMutados.map({k => listaCantidad.get(k)}) 
// 		const abatidosOrdenados = (0..listaDia.size()-1).sortedBy({k,n => listaDia.get(k)<listaDia.get(n)}).map({k=>listaCantidad.get(k)})
 		var indicesRepetidos = []
 		//const indicesMutadosRepetidos = (0..listaDia.size()-1).map({k=> self.obtenerIndice(abatidosOrdenados,diasOrdenados.get(k))})
		
		if (not registroDias.asSet().intersection(diasOrdenados.asSet()).isEmpty()){
			indicesRepetidos = diasOrdenados.map({dia => self.obtenerListaDiasRepetidos(dia)})
			indicesRepetidos.forEach({ind=> ind.forEach({ind2=> diasOrdenados.remove(diasOrdenados.get(ind2));abatidosOrdenados.remove(abatidosOrdenados.get(ind2))})})
		} 
		registroDias.addAll(diasOrdenados)
		registroAbatidos.addAll(abatidosOrdenados)	
	}
	method obtenerListaDiasRepetidos (dia){
		return (0..registroDias.size()-1).filter({ k => registroDias.get(k)==dia})
	}
	
	method obtenerIndicesDe(lista,valor){
		return (0..lista.size()-1).filter({k => lista.get(k)==valor})
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
	method algunDiaAbatio(cantidad) = registroAbatidos.contains(cantidad)
	method primerValorDeAbatidos() = registroAbatidos.first()
	method ultimoValorDeAbatidos() = registroAbatidos.last()
	method maximoValorDeAbatidos() = registroAbatidos.max()
	method totalAbatidos() = registroAbatidos.sum()
	method cantidadDeAbatidosElDia(dia) = registroAbatidos.get(self.obtenerIndice(registroDias,dia))
	method ultimoValorDeAbatidosConSize() = registroAbatidos.get(registroAbatidos.size()-1)
	method diasConAbatidosSuperioresA(cuanto) = registroAbatidos.count({ abatidos => abatidos>cuanto})
	method valoresDeAbatidosPares() = registroAbatidos.count({ abatidos=>abatidos%2 ==0})
	method elValorDeAbatidos(cantidad) = registroAbatidos.find({ab => ab == cantidad})
	method abatidosSumando(cantidad) = registroAbatidos.map({a=> a+cantidad})
	method abatidosEsAcotada(n1,n2) = registroAbatidos.all({a => a.between(n1,n2)})
	method algunDiaAbatioMasDe(cantidad) = registroAbatidos.any({aba=> aba> cantidad})
	method todosLosDiasAbatioMasDe(cantidad) = registroAbatidos.all({aba=> aba> cantidad})
	method cantidadAbatidosMayorALaPrimera() = registroAbatidos.count({aba => aba>registroAbatidos.first()})
	method esCrack(){
		var crack = true
		if (registroAbatidos.size() > 1){
			crack = (0..registroAbatidos.size()-2).all({k => registroAbatidos.get(k)<registroAbatidos.get(k+1)})
		}
		return crack
	}
}