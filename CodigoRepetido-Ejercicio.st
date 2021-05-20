!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'a 5/18/2021 22:52:51'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self comprobarQueHacer: [customerBook addCustomerNamed: 'John Lennon'.] NoDemoraMasDe: 50*millisecond.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'a 5/18/2021 22:53:13'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	  
	self comprobarQueHacer: [customerBook removeCustomerNamed: paulMcCartney.] NoDemoraMasDe: 100*millisecond.
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'a 5/18/2021 22:48:19'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self comprobarQueElBloque: [ customerBook addCustomerNamed: ''.]
		lanzaElError: Error 
		yEnCasoDeErrorRealizaLaPrueba: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'a 5/18/2021 22:49:59'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self comprobarQueElBloque: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
		lanzaElError: NotFound 
		yEnCasoDeErrorRealizaLaPrueba: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'a 5/18/2021 22:57:49'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self comprobarQueEnElBook: customerBook elNumeroDeClientesActivosEs: 0 elNumeroDeClientesSuspendidosEs: 1 elNumeroTotalDeClientesEs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'a 5/18/2021 22:58:17'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self comprobarQueEnElBook: customerBook elNumeroDeClientesActivosEs: 0 elNumeroDeClientesSuspendidosEs: 0 elNumeroTotalDeClientesEs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'a 5/18/2021 22:55:47'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self comprobarQueElBloque: [ customerBook suspendCustomerNamed: 'Ringo Starr'.]
		lanzaElError: CantSuspend 
		yEnCasoDeErrorRealizaLaPrueba: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'a 5/18/2021 22:56:35'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self comprobarQueElBloque: [ customerBook suspendCustomerNamed: johnLennon.]
		lanzaElError: CantSuspend 
		yEnCasoDeErrorRealizaLaPrueba: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'ayudantes' stamp: 'a 5/18/2021 22:47:01'!
comprobarQueElBloque: unBloqueDeCodigo lanzaElError: unError yEnCasoDeErrorRealizaLaPrueba: unBloqueConComprobaciones
	[unBloqueDeCodigo value.
		self fail ]
			on: unError
			do: unBloqueConComprobaciones! !

!CustomerBookTest methodsFor: 'ayudantes' stamp: 'a 5/18/2021 22:51:23'!
comprobarQueEnElBook: unCustomerBook elNumeroDeClientesActivosEs: clientesActivos elNumeroDeClientesSuspendidosEs: clientesSuspendidos elNumeroTotalDeClientesEs: clientesTotales

	
	self assert: clientesActivos equals: unCustomerBook numberOfActiveCustomers.
	self assert: clientesSuspendidos equals: unCustomerBook numberOfSuspendedCustomers.
	self assert: clientesTotales equals: unCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'ayudantes' stamp: 'a 5/18/2021 22:51:04'!
comprobarQueHacer: unaTarea NoDemoraMasDe: unaCantidadDeMilisegundos

	|millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	unaTarea.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (unaCantidadDeMilisegundos ).! !

!CustomerBookTest methodsFor: 'ayudantes' stamp: 'NM 5/17/2021 13:57:16'!
enElBook: unBookDeClientes NoSePuedeSuspenderA: unClienteASuspender
	
	[ unBookDeClientes suspendCustomerNamed: unClienteASuspender.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: (unBookDeClientes includesCustomerNamed: unClienteASuspender) 
			]
		
		! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'a 5/18/2021 23:29:15'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [self signalCustomerNameCannotBeEmpty].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'a 5/18/2021 22:12:54'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [^ NotFound signal.].
		].! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'a 5/18/2021 22:15:28'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'a 5/20/2021 15:53:07'!
signalCustomerAlreadyExists 

	self lanzarSeñalDeError: self class customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'signal errors' stamp: 'a 5/20/2021 15:52:56'!
signalCustomerNameCannotBeEmpty 

	self lanzarSeñalDeError: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'ayudantes' stamp: 'a 5/20/2021 15:52:34'!
lanzarSeñalDeError: unMensajeDeError

	 self error: unMensajeDeError.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
