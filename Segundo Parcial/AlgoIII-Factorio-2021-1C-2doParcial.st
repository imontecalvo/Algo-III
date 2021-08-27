!classDefinition: #SeparadorDeMenasTest category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!
TestCase subclass: #SeparadorDeMenasTest
	instanceVariableNames: 'elDestinoPrimario elDestinoSecundario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:23:04'!
test01NoDespachaMenasSiNoLeLlegaNingunaMena

	|separadorDeMenas destinoPrimario destinoSecundario|
	
	destinoPrimario:= Caja new.
	destinoSecundario := Caja new.
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	
	separadorDeMenas separarMenas.
	
	self assert: destinoPrimario estaVacia. 
	self assert: destinoSecundario estaVacia.
	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:23:23'!
test02ArrancaEnModoNeutroDespachandoMenasEnDestinoPrimario

	|separadorDeMenas destinoPrimario destinoSecundario |
	
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.	
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (Array new: 20 withAll: MenaDeCarbon new). 
	
	separadorDeMenas separarMenas.
	
	self assert: 20 equals: destinoPrimario cantidadDeMenas.
	self assert: 0 equals: destinoSecundario cantidadDeMenas.
	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:15:15'!
test03EnModoFiltradoDeMenasDeCarbonDespachaMenaDeCarbonADestinoSecundario

	|separadorDeMenas destinoPrimario destinoSecundario |
	
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.	
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (OrderedCollection with: MenaDeCarbon new). 
	
	separadorDeMenas enModoFiltradoMenasDe: MenaDeCarbon.
	separadorDeMenas separarMenas.
	
	self assert: 0 equals: destinoPrimario cantidadDeMenas.
	self assert: 1 equals: destinoSecundario cantidadDeMenas.
	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:25:29'!
test04EnModoFiltradoDeMenasDeHierroDespachaMenaDeHierroADestinoSecundario
	
	"Al principio tenia subclases para cada tipo de filtrado por eso quedaron los test para Hierro y Carbon, luego al notar codigo repetido en modelo hice el refactor.
	Los test los dejo igualmente, pues forman la evolucion del modelo"

	|separadorDeMenas destinoPrimario destinoSecundario |
	
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.	
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (OrderedCollection with: MenaDeHierro new). 
	
	separadorDeMenas enModoFiltradoMenasDe: MenaDeHierro.
	separadorDeMenas separarMenas.
	
	self assert: 0 equals: destinoPrimario cantidadDeMenas.
	self assert: 1 equals: destinoSecundario cantidadDeMenas.
	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:14:49'!
test05EnModoFiltradoDeMenasDeCualquierTipoLasDespachaADestinoSecundarioYElRestoAlPrimario

	|separadorDeMenas destinoPrimario destinoSecundario|
	
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.	
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (OrderedCollection with: MenaDeHierro new with: MenaDeCarbon new with: MenaDeHierro new with: MenaDeCarbon new). 
	
	separadorDeMenas enModoFiltradoMenasDe: MenaDeHierro.
	separadorDeMenas separarMenas.
	
	self assert: 2 equals: (destinoPrimario cantidadDe: MenaDeCarbon).
	self assert: 2 equals: (destinoSecundario cantidadDe: MenaDeHierro).

	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:15:58'!
test06EnModoBalanceadoDespachaUnaPrimerMenaAlDestinoPrimarioYLaSegundaAlSecundario


	| destinoPrimario destinoSecundario separadorDeMenas |
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.	
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (Array new: 2 withAll: MenaDeCarbon new). 
	
	separadorDeMenas enModoBalanceado.
	separadorDeMenas separarMenas.
	
	self assert: 1 equals: destinoPrimario cantidadDeMenas.
	self assert: 1 equals: destinoSecundario cantidadDeMenas.
	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:16:38'!
test07EnModoBalanceadoDespachaMenasIntercalandoEntreDestinosPrimarioYSecundario


	| destinoPrimario destinoSecundario separadorDeMenas menasIntercaladas|
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.	
	menasIntercaladas := OrderedCollection with: (MenaDeHierro new) with: (MenaDeCarbon new) 
										 with: (MenaDeHierro new) with: (MenaDeCarbon new) 
										 with: (MenaDeHierro new) with: (MenaDeCarbon new).
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: menasIntercaladas. 
	
	separadorDeMenas enModoBalanceado.
	separadorDeMenas separarMenas.
	
	self assert: 3 equals: (destinoPrimario cantidadDe: MenaDeHierro).
	self assert: 3 equals: (destinoSecundario cantidadDe: MenaDeCarbon).
	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:17:31'!
test08NoPuedePasarDeModoBalanceadoAModoFiltradoDeCarbon


	| destinoPrimario destinoSecundario separadorDeMenas|
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (OrderedCollection with: MenaDeHierro new with: MenaDeCarbon new with: MenaDeHierro new with: MenaDeCarbon new). 
	
	separadorDeMenas enModoBalanceado.
	
	self should: [ separadorDeMenas enModoFiltradoMenasDe: MenaDeCarbon] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: separadorDeMenas noSePuedeHacerLaTransicionAlNuevoModo.
		].
	

	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 12:52:38'!
test09NoPuedePasarDeBalanceadoAFiltradoDeHierro


	| destinoPrimario destinoSecundario separadorDeMenas|
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (OrderedCollection with: MenaDeHierro new with: MenaDeCarbon new with: MenaDeHierro new with: MenaDeCarbon new). 
	
	separadorDeMenas enModoBalanceado.
	
	self should: [ separadorDeMenas enModoFiltradoMenasDe: MenaDeHierro ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: separadorDeMenas noSePuedeHacerLaTransicionAlNuevoModo.
		].
	

	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:17:40'!
test10NoPuedePasarDeModoFiltradoDeCarbonABalanceado


	| destinoPrimario destinoSecundario separadorDeMenas|
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (OrderedCollection with: MenaDeHierro new with: MenaDeCarbon new with: MenaDeHierro new with: MenaDeCarbon new). 
	
	separadorDeMenas enModoFiltradoMenasDe: MenaDeCarbon .
	
	self should: [ separadorDeMenas enModoBalanceado ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: separadorDeMenas noSePuedeHacerLaTransicionAlNuevoModo.
		].
	

	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:17:49'!
test11NoPuedePasarDeModoFiltradoDeHierroABalanceado


	| destinoPrimario destinoSecundario separadorDeMenas|
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (OrderedCollection with: MenaDeHierro new with: MenaDeCarbon new with: MenaDeHierro new with: MenaDeCarbon new). 
	
	separadorDeMenas enModoFiltradoMenasDe: MenaDeHierro.
	
	self should: [ separadorDeMenas enModoBalanceado ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: separadorDeMenas noSePuedeHacerLaTransicionAlNuevoModo.
		].
	

	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 13:18:45'!
test12AlPasarDeModoBalanceadoAModoBalanceadoNoTieneImpactoEnElProximoDestino

	| destinoPrimario destinoSecundario separadorDeMenas|
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (OrderedCollection with: MenaDeHierro new with: MenaDeCarbon new with: MenaDeHierro new). 
	
	separadorDeMenas enModoBalanceado.
	separadorDeMenas separarMenas.
	
	separadorDeMenas agregarMenas: (OrderedCollection with: MenaDeCarbon new).
	separadorDeMenas enModoBalanceado.
	separadorDeMenas separarMenas.
	
	self assert: 2 equals: (destinoPrimario cantidadDe: MenaDeHierro).
	self assert: 2 equals: (destinoSecundario cantidadDe: MenaDeCarbon).
	

	

	! !

!SeparadorDeMenasTest methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 12:38:18'!
test13ElSeparadorDeMenasQuedaVacioLuegoDeDespachar

	|separadorDeMenas destinoPrimario destinoSecundario |
	
	destinoPrimario := Caja new.
	destinoSecundario := Caja new.	
	
	separadorDeMenas := SeparadorDeMenas conDestinoPrimario: destinoPrimario yDestinoSecundario: destinoSecundario.
	separadorDeMenas agregarMenas: (Array new: 20 withAll: MenaDeCarbon new). 
	
	separadorDeMenas separarMenas.
	
	self assert: separadorDeMenas estaVacio.
	

	

	! !


!classDefinition: #ModoDeFuncionamientoSeparadorDeMenas category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!
Object subclass: #ModoDeFuncionamientoSeparadorDeMenas
	instanceVariableNames: 'separadorDeMenas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!

!ModoDeFuncionamientoSeparadorDeMenas methodsFor: 'initialization' stamp: 'nacho 7/24/2021 12:18:26'!
inicializarPara: unSeparadorDeMenas

	separadorDeMenas := unSeparadorDeMenas.! !


!ModoDeFuncionamientoSeparadorDeMenas methodsFor: 'separar menas' stamp: 'nacho 7/24/2021 10:24:09'!
separarMenas

	^self subclassResponsibility.! !


!ModoDeFuncionamientoSeparadorDeMenas methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 12:31:30'!
enModoBalanceado
	
	^self subclassResponsibility.! !

!ModoDeFuncionamientoSeparadorDeMenas methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 13:04:15'!
enModoFiltradoMenasDe: unMaterial
	
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ModoDeFuncionamientoSeparadorDeMenas class' category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!
ModoDeFuncionamientoSeparadorDeMenas class
	instanceVariableNames: ''!

!ModoDeFuncionamientoSeparadorDeMenas class methodsFor: 'instance creation' stamp: 'nacho 7/24/2021 10:23:45'!
para: unSeparadorDeMenas

	^self new inicializarPara: unSeparadorDeMenas.! !


!classDefinition: #ModoBalanceado category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!
ModoDeFuncionamientoSeparadorDeMenas subclass: #ModoBalanceado
	instanceVariableNames: 'destinoActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!

!ModoBalanceado methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 11:59:39'!
enModoBalanceado! !

!ModoBalanceado methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 12:51:12'!
enModoFiltradoMenasDe: unMaterial

	^self error: separadorDeMenas noSePuedeHacerLaTransicionAlNuevoModo.! !


!ModoBalanceado methodsFor: 'separar menas' stamp: 'nacho 7/24/2021 12:28:42'!
separarMenas

	separadorDeMenas separarSegunModoBalanceado.! !


!ModoBalanceado methodsFor: 'destino' stamp: 'nacho 7/24/2021 12:24:16'!
actualizarDestinoActual

	(destinoActual = separadorDeMenas destinoPrimario) ifTrue: [^destinoActual := separadorDeMenas destinoSecundario]
												ifFalse: [^destinoActual := separadorDeMenas destinoPrimario].! !

!ModoBalanceado methodsFor: 'destino' stamp: 'nacho 7/24/2021 12:22:15'!
destinoActual

	^destinoActual.! !


!ModoBalanceado methodsFor: 'initialization' stamp: 'nacho 7/24/2021 12:18:35'!
inicializarPara: unSeparadorDeMenas
	
	separadorDeMenas := unSeparadorDeMenas.
	destinoActual := unSeparadorDeMenas destinoPrimario.! !


!classDefinition: #ModoFiltrado category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!
ModoDeFuncionamientoSeparadorDeMenas subclass: #ModoFiltrado
	instanceVariableNames: 'materialAFiltrar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!

!ModoFiltrado methodsFor: 'separar menas' stamp: 'nacho 7/24/2021 12:44:41'!
separarMenas

	separadorDeMenas separarSegunModoFiltradoDe: materialAFiltrar.! !


!ModoFiltrado methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 12:48:36'!
enModoBalanceado

	^self error: separadorDeMenas noSePuedeHacerLaTransicionAlNuevoModo.! !

!ModoFiltrado methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 12:51:47'!
enModoFiltradoMenasDe: unMaterial

	^separadorDeMenas cambiarAModoFiltradoMenasDe: unMaterial.! !


!ModoFiltrado methodsFor: 'initialization' stamp: 'nacho 7/24/2021 12:43:59'!
inicializarDe: unMaterial para: unSeparadorDeMenas

	separadorDeMenas := unSeparadorDeMenas.
	materialAFiltrar := unMaterial.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ModoFiltrado class' category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!
ModoFiltrado class
	instanceVariableNames: ''!

!ModoFiltrado class methodsFor: 'instance creation' stamp: 'nacho 7/24/2021 12:43:20'!
de: unMaterial para: unSeparadorDeMenas.

	^self new inicializarDe: unMaterial para: unSeparadorDeMenas.! !


!classDefinition: #ModoNeutro category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!
ModoDeFuncionamientoSeparadorDeMenas subclass: #ModoNeutro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!

!ModoNeutro methodsFor: 'separar menas' stamp: 'nacho 7/24/2021 11:49:58'!
separarMenas

	^separadorDeMenas separarSegunModoNeutro.! !


!ModoNeutro methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 12:00:03'!
enModoBalanceado

	^separadorDeMenas cambiarAModoBalanceado.! !

!ModoNeutro methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 12:51:47'!
enModoFiltradoMenasDe: unMaterial

	^separadorDeMenas cambiarAModoFiltradoMenasDe: unMaterial.! !


!classDefinition: #SeparadorDeMenas category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!
Object subclass: #SeparadorDeMenas
	instanceVariableNames: 'contenido destinoPrimario destinoSecundario modoDeFuncionamiento'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!

!SeparadorDeMenas methodsFor: 'initialization' stamp: 'nacho 7/24/2021 10:15:33'!
inicializarConDestinoPrimario: unDestinoPrimario yDestinoSecundario: unDestinoSecundario
	
	destinoPrimario := unDestinoPrimario.
	destinoSecundario := unDestinoSecundario.
	contenido := OrderedCollection new.
	modoDeFuncionamiento := ModoNeutro para: self.! !


!SeparadorDeMenas methodsFor: 'separar menas segun modo' stamp: 'nacho 7/24/2021 13:01:20'!
separarHaciendo: closureConCriterioDeSeparacion

	contenido do: closureConCriterioDeSeparacion.! !

!SeparadorDeMenas methodsFor: 'separar menas segun modo' stamp: 'nacho 7/24/2021 13:01:49'!
separarSegunModoBalanceado
	
	self separarHaciendo: [:unaMena | (modoDeFuncionamiento  destinoActual) agregarMenas: (self menaListaParaAgregar: unaMena). 
						               modoDeFuncionamiento actualizarDestinoActual ].! !

!SeparadorDeMenas methodsFor: 'separar menas segun modo' stamp: 'nacho 7/24/2021 13:02:08'!
separarSegunModoFiltradoDe: unMaterial

	self separarHaciendo: [:unaMena | (unaMena esDeMaterial: unMaterial) ifTrue: [destinoSecundario agregarMenas: (self menaListaParaAgregar: unaMena) ]
													                  ifFalse: [destinoPrimario agregarMenas: (self menaListaParaAgregar: unaMena)]].! !

!SeparadorDeMenas methodsFor: 'separar menas segun modo' stamp: 'nacho 7/24/2021 13:02:25'!
separarSegunModoNeutro

	self separarHaciendo: [:unaMena | destinoPrimario agregarMenas: (self menaListaParaAgregar: unaMena) ].! !


!SeparadorDeMenas methodsFor: 'cambiar modo - private' stamp: 'nacho 7/24/2021 11:58:25'!
cambiarAModoBalanceado

	modoDeFuncionamiento := ModoBalanceado para: self.! !

!SeparadorDeMenas methodsFor: 'cambiar modo - private' stamp: 'nacho 7/24/2021 12:51:47'!
cambiarAModoFiltradoMenasDe: unMaterial

	modoDeFuncionamiento := ModoFiltrado de: unMaterial para: self.
	! !


!SeparadorDeMenas methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 11:58:36'!
enModoBalanceado

	modoDeFuncionamiento enModoBalanceado.! !

!SeparadorDeMenas methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 12:51:12'!
enModoFiltradoMenasDe: unMaterial

	modoDeFuncionamiento enModoFiltradoMenasDe: unMaterial.! !

!SeparadorDeMenas methodsFor: 'cambios de modo' stamp: 'nacho 7/24/2021 11:43:17'!
enModoNeutro

	modoDeFuncionamiento := ModoNeutro para: self.! !


!SeparadorDeMenas methodsFor: 'error cambio de modo' stamp: 'nacho 7/24/2021 11:41:28'!
noSePuedeHacerLaTransicionAlNuevoModo

	^'No está permitido hacer esta transición desde el modo de funcionamiento actual'.! !


!SeparadorDeMenas methodsFor: 'private' stamp: 'nacho 7/24/2021 12:19:06'!
destinoPrimario

	^destinoPrimario.! !

!SeparadorDeMenas methodsFor: 'private' stamp: 'nacho 7/24/2021 12:24:25'!
destinoSecundario

	^destinoSecundario.! !

!SeparadorDeMenas methodsFor: 'private' stamp: 'nacho 7/24/2021 12:58:21'!
menaListaParaAgregar: unaMena

	^OrderedCollection with: unaMena.! !

!SeparadorDeMenas methodsFor: 'private' stamp: 'nacho 7/24/2021 10:51:40'!
vaciar

	contenido := OrderedCollection new.! !


!SeparadorDeMenas methodsFor: 'testing' stamp: 'nacho 7/24/2021 12:38:54'!
estaVacio

	^contenido isEmpty.! !


!SeparadorDeMenas methodsFor: 'protocolo principal' stamp: 'nacho 7/24/2021 09:42:50'!
agregarMenas: unaColecccionDeMenas
	
	contenido addAll: unaColecccionDeMenas.! !

!SeparadorDeMenas methodsFor: 'protocolo principal' stamp: 'nacho 7/24/2021 10:51:27'!
separarMenas

	modoDeFuncionamiento separarMenas.
	self vaciar.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeparadorDeMenas class' category: 'AlgoIII-Factorio-2021-1C-2doParcial.'!
SeparadorDeMenas class
	instanceVariableNames: ''!

!SeparadorDeMenas class methodsFor: 'as yet unclassified' stamp: 'nacho 7/24/2021 10:14:58'!
conDestinoPrimario: unDestinoPrimario yDestinoSecundario: unDestinoSecundario

	^self new inicializarConDestinoPrimario: unDestinoPrimario yDestinoSecundario: unDestinoSecundario.! !
