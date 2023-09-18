object registroAbatidosCOD {
	const property registroDias = []
	const property registroAbatidos = []
	
	method agregarAbatidosDia(cantidad, dia) {
		//var aux
		//const listAux = []
		if (registroDias.contains(dia)) {
			self.error("Ya existe registro para el día indicado")
		} 
		else {
			/*
			aux = registroDias.count({dias=> dias<dia})
			listAux.addAll( registroDias.filter({ dias => dias< registroDias.get(aux)}))
			listAux.add(dia)
			listAux.addAll(registroDias.filter({dias=>dias>registroDias.get(aux-1)}))
			registroDias.clear()
			registroDias.addAll(listAux)
			listAux.clear()
			listAux.addAll((0..aux-1).map({ dias => registroAbatidos.get(dias)}))
			listAux.add(cantidad)
			listAux.addAll((aux..registroAbatidos.size()-1).map({ dias => registroAbatidos.get(dias)}))
			registroAbatidos.clear()
			registroAbatidos.addAll(listAux)
			listAux.clear()
			*/
			registroDias.add(dia)
			registroAbatidos.add(cantidad)
			self.ordenarRegistro()
		}	
	}
	
	method estanLosDiasOrdenados(){
		var crack = true
		if (registroDias.size() > 1){
			crack = (0..registroDias.size()-2).all({k => registroDias.get(k)<registroDias.get(k+1)})
		}
		return crack
	}
	
	method ordenarRegistro(){
		var diasOrdenados
		var indicesMutados
		var abatidosOrdenados 
		
		if (not self.estanLosDiasOrdenados()){
			diasOrdenados = registroDias.sortedBy({ m, n => m <= n})
 			indicesMutados = (0..registroDias.size()-1).map({k=> self.obtenerIndice(registroDias,diasOrdenados.get(k))})
 			abatidosOrdenados = indicesMutados.map({k => registroAbatidos.get(k)}) 
 		  //abatidosOrdenados = (0..listaDia.size()-1).sortedBy({k,n => listaDia.get(k)<listaDia.get(n)}).map({k=>listaCantidad.get(k)})
 			registroDias.clear()
			registroDias.addAll(diasOrdenados)
 			registroAbatidos.clear()
 			registroAbatidos.addAll(abatidosOrdenados)
		}
	}
	
	method agregarAbatidosVariosDias(listaCantidad,listaDia){
		// Esta version elimina de las listas a ingresar pares ya considerados.
		const diasRepetidos = []
		var indicesRepetidos
		const indicesPermitidos = []
		const listaDiasDef = listaDia
		const listaCantDef = []
		diasRepetidos.addAll(registroDias.filter({dias => listaDia.contains(dias)}))
		indicesRepetidos = diasRepetidos.asSet().map({ dias => self.obtenerIndicesDe(listaDia,dias)})
		listaDiasDef.removeAll(diasRepetidos)
		indicesPermitidos.addAll((0..listaCantidad.size()-1))
		indicesRepetidos.forEach({ box => indicesPermitidos.removeAll(box)})
		listaCantDef.addAll(indicesPermitidos.map({i=>listaCantidad.get(i)}))
		registroDias.addAll(listaDiasDef)
		registroAbatidos.addAll(listaCantDef)
		self.ordenarRegistro()
		/* 
		const diasOrdenados = listaDia.sortedBy({ m, n => m <= n})
 		const indicesMutados = (0..listaDia.size()-1).map({k=> self.obtenerIndice(listaDia,diasOrdenados.get(k))})
 		const abatidosOrdenados = indicesMutados.map({k => listaCantidad.get(k)}) 
// 		const abatidosOrdenados = (0..listaDia.size()-1).sortedBy({k,n => listaDia.get(k)<listaDia.get(n)}).map({k=>listaCantidad.get(k)})
 		var indicesRepetidos = []
 		var aux1
 		var aux2
 		//const indicesMutadosRepetidos = (0..listaDia.size()-1).map({k=> self.obtenerIndice(abatidosOrdenados,diasOrdenados.get(k))})
		aux1 = registroDias.asSet()
		aux2 = diasOrdenados.asSet()
		if (not aux1.intersection(aux2).isEmpty()){
			indicesRepetidos = diasOrdenados.filter({dia => registroDias.contains(dia)}).map({d=>self.obtenerListaDiasRepetidos (diasOrdenados,d)})
			indicesRepetidos.forEach({ind=> ind.forEach({ind2=> diasOrdenados.remove(diasOrdenados.get(ind2))})})
		} 
		registroDias.addAll(diasOrdenados)
		registroAbatidos.addAll(abatidosOrdenados)	
		*/
	}
	
	method obtenerListaDiasRepetidos (lista,dia){
		return (0..lista.size()-1).filter({ k => lista.get(k)==dia})
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

object abatidosCOD {
	const property registroDias = []
	const property registroAbatidos = []
	
	method agregarAbatidosDia(cantidad, dia) {
		if (registroDias.contains(dia)) {
			self.sumarAbatidosParaDiaYaRegistrado(cantidad,dia)
		} 
		else{
			registroDias.add(dia)
			registroAbatidos.add(cantidad)
			self.ordenarRegistro()
		}	
	}
	
	method estanLosDiasOrdenados(){
		var orden = true
		if (registroDias.size() > 1){
			orden = (0..registroDias.size()-2).all({k => registroDias.get(k)<registroDias.get(k+1)})
		}
		return orden
	}
	
	method ordenarRegistro(){
		var diasOrdenados
		var indicesMutados
		var abatidosOrdenados 
		if (not self.estanLosDiasOrdenados()){
			diasOrdenados = registroDias.sortedBy({ m, n => m <= n})
 			indicesMutados = (0..registroDias.size()-1).map({k=> self.obtenerIndice(registroDias,diasOrdenados.get(k))})
 			abatidosOrdenados = indicesMutados.map({k => registroAbatidos.get(k)}) 
 		  //abatidosOrdenados = (0..listaDia.size()-1).sortedBy({k,n => listaDia.get(k)<listaDia.get(n)}).map({k=>listaCantidad.get(k)})
 			registroDias.clear()
			registroDias.addAll(diasOrdenados)
 			registroAbatidos.clear()
 			registroAbatidos.addAll(abatidosOrdenados)
		}
	}

	method sumarAbatidosParaDiaYaRegistrado(cantidad,dia){
		var aux
		const listAux = []
		aux = self.obtenerIndice(registroDias,dia)
		if (aux>0){
			listAux.addAll((0..aux-1).map({i=>registroAbatidos.get(i)}))
		}
		//listAux.removeAll((aux..listAux.size()-1).map({i=>listAux.get(i)}))
		listAux.add(registroAbatidos.get(aux)+cantidad)
		if(aux< registroAbatidos.size()-1){
			listAux.addAll((aux+1..registroAbatidos.size()-1).map({i=>registroAbatidos.get(i)}))
		}
		registroAbatidos.clear()
		registroAbatidos.addAll(listAux)
		listAux.clear()
	}
	
	method normalizarListas(listaCant,listaDia){
		const indices = listaDia.asSet().map({dias => self.obtenerIndicesDe(listaDia,dias)})
		const newDias = []
		const newAbatidos = []
		newDias.addAll(indices.map({ ind => listaDia.get(ind.first())}))
		newAbatidos.addAll(indices.map({ind => ind.sum({ k=> listaCant.get(k)})}))
		//listaCant.clear()
		//listaDia.clear()
		//listaDia.addAll(newDias)
		//listaCant.addAll(newAbatidos)
		return([newAbatidos,newDias])
	}
	
	method sumarAbatidosVariosDias(listaCantidad,listaDia){
		const diasRepetidos = []
		const indicesRepetidos = []
		const listaDiasDef = []
		const listaCantDef = []
		const newList = []
		
		newList.addAll(self.normalizarListas(listaCantidad,listaDia))
		listaDiasDef.addAll(newList.get(1))
		listaCantDef.addAll(newList.get(0))
		
		diasRepetidos.addAll(registroDias.filter({dias => listaDiasDef.contains(dias)}))
		indicesRepetidos.addAll(diasRepetidos.asSet().map({ dias => self.obtenerIndice(listaDiasDef,dias)}))
		indicesRepetidos.forEach({ i=> self.sumarAbatidosParaDiaYaRegistrado(newList.get(0).get(i),newList.get(1).get(i))})
		listaDiasDef.removeAll(diasRepetidos)
		//indicesRepetidos.forEach({index => listaCantDef.remove(listaCantDef.get(index))})
		listaCantDef.removeAll(indicesRepetidos.map({i=>listaCantDef.get(i)}))
		return([listaCantDef,listaDiasDef])
		}
	
	method agregarAbatidosVariosDias(listaCantidad,listaDia){
		// Esta version suma los abatidos de las lista cantidad a los de la misma fecha ya ingresados al registro.
		const newList = self.sumarAbatidosVariosDias(listaCantidad,listaDia)
		
		//self.sumarAbatidosVariosDias(listaCantidad,listaDia)
		
		registroDias.addAll(newList.get(1))
		registroAbatidos.addAll(newList.get(0))
		self.ordenarRegistro()
		/* 
		const diasOrdenados = listaDia.sortedBy({ m, n => m <= n})
 		const indicesMutados = (0..listaDia.size()-1).map({k=> self.obtenerIndice(listaDia,diasOrdenados.get(k))})
 		const abatidosOrdenados = indicesMutados.map({k => listaCantidad.get(k)}) 
// 		const abatidosOrdenados = (0..listaDia.size()-1).sortedBy({k,n => listaDia.get(k)<listaDia.get(n)}).map({k=>listaCantidad.get(k)})
 		var indicesRepetidos = []
 		var aux1
 		var aux2
 		//const indicesMutadosRepetidos = (0..listaDia.size()-1).map({k=> self.obtenerIndice(abatidosOrdenados,diasOrdenados.get(k))})
		aux1 = registroDias.asSet()
		aux2 = diasOrdenados.asSet()
		if (not aux1.intersection(aux2).isEmpty()){
			indicesRepetidos = diasOrdenados.filter({dia => registroDias.contains(dia)}).map({d=>self.obtenerListaDiasRepetidos (diasOrdenados,d)})
			indicesRepetidos.forEach({ind=> ind.forEach({ind2=> diasOrdenados.remove(diasOrdenados.get(ind2))})})
		} 
		registroDias.addAll(diasOrdenados)
		registroAbatidos.addAll(abatidosOrdenados)	
		*/
	}
	
	method obtenerListaDiasRepetidos (lista,dia){
		return (0..lista.size()-1).filter({ k => lista.get(k)==dia})
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

object registroCOD {
	const registro = []
	
	method registroAbatidos() = registro.get(0)
	method registroDias() = registro.get(1)
	
	method yaEstaDia(dia) = registro.any({ par => par.get(1)==dia})
	
	method agregarAbatidosDia(cantidad, dia) {
		if (self.yaEstaDia(dia)) {
			self.sumarAbatidosParaDiaYaRegistrado(cantidad,dia)
		} 
		else{
			registro.add([cantidad,dia])
		}	
		self.ordenarRegistro()
	}
	
	method sumarAbatidosParaDiaYaRegistrado(cantidad,dia){
		registro.add([registro.find({ par => par.get(1) == dia}).get(0) + cantidad,dia])
		registro.remove(registro.find({ par => par.get(1) == dia}))
	}
	
	method estanLosDiasOrdenados(){
		var orden = true
		if (registro.size() > 1){
			orden = (0..registro.size()-2).all({k => registro.get(k).get(1)<registro.get(k+1).get(1)})
		}
		return orden
	}
	
	method obtenerIndice(lista,valor){
		return (0..lista.size()-1).find({k => lista.get(k)==valor})
	}
	
	method ordenarRegistro(){
		if (not self.estanLosDiasOrdenados()){
			registro.sortedBy({ m, n => m.get(1) <= n.get(1)})
		}
	}
	
	method agregarAbatidosVariosDias(listaCantidad,listaDia){
		(0..listaDia.size()-1).forEach({ index => self.agregarAbatidosDia(listaCantidad.get(index),listaDia.get(index))})
	}
	
	method abatidos(dia) = registro.find({ par => par.get(1) == dia}).get(0)
	
	method eliminarElRegistroDelDia(dia){
		if (self.yaEstaDia(dia)){registro.remove(registro.find({par=>par.get(1)==dia}))} else {self.error("El dia no esta registrado")}
	}
	
	method eliminarLosRegistrosDeDias(listaDeDias){
		listaDeDias.forEach({ dia => self.eliminarElRegistroDelDia(dia)})
	}
	
	method cantidadDeDiasRegistrados() = registro.size()
	method estaVacioElRegistro() = registro.isEmpty()
	method algunDiaAbatio(cantidad) = registro.find({par=> par.get(0) == cantidad})
	method primerValorDeAbatidos() = registro.first().first()
	method ultimoValorDeAbatidos() = registro.last().first()
	method maximoValorDeAbatidos() = registro.max({par=> par.get(0)})
	method totalAbatidos() = registro.sum({par=> par.get(0)})
	method cantidadDeAbatidosElDia(dia){
		if (not self.yaEstaDia(dia)) {
			self.error("El dia no esta registrado")
			//self.abatidos(dia)
		}
		return registro.find({par => par.get(1)==dia})
	} 
	method ultimoValorDeAbatidosConSize() = registro.get(registro.size()-1).get(0)
	method diasConAbatidosSuperioresA(cuanto) = registro.count({ par => par.get(0)>cuanto})
	method valoresDeAbatidosPares() = registro.count({ par => par.get(0) % 2 == 0})
	method elValorDeAbatidos(cantidad) = registro.find({par => par.get(0) == cantidad})
	method abatidosSumando(cantidad) = registro.map({par => [cantidad+par.get(0),par.get(1)]})
	method abatidosEsAcotada(n1,n2) = registro.all({par => par.get(0).between(n1,n2)})
	method algunDiaAbatioMasDe(cantidad) = registro.any({par => par.get(0)> cantidad})
	method todosLosDiasAbatioMasDe(cantidad) = registro.all({par => par.get(0) > cantidad})
	method cantidadAbatidosMayorALaPrimera() = registro.count({par => par.get(0)>self.primerValorDeAbatidos()})
	method esCrack(){
		var crack = true
		if (registro.size() > 1){
			crack = (0..registro.size()-2).all({k => registro.get(k).get(0)<registro.get(k+1).get(0)})
		}
		return crack
	}
	
}