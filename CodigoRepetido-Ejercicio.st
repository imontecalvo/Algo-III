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

!CustomerBookTest methodsFor: 'tests' stamp: 'NM 5/17/2021 03:23:26'!
assertEnElBook: unCustomerBook elNumeroDeClientesActivosEs: clientesActivos elNumeroDeClientesSuspendidosEs: clientesSuspendidos elNumeroTotalDeClientesEs: clientesTotales

	
	self assert: clientesActivos equals: unCustomerBook numberOfActiveCustomers.
	self assert: clientesSuspendidos equals: unCustomerBook numberOfSuspendedCustomers.
	self assert: clientesTotales equals: unCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NM 5/17/2021 13:34:39'!
assertHacer: unaTarea NoDemoraMasDe: unaCantidadDeMilisegundos

	|millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	unaTarea.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (unaCantidadDeMilisegundos ).! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NM 5/17/2021 13:57:16'!
enElBook: unBookDeClientes NoSePuedeSuspenderA: unClienteASuspender
	
	[ unBookDeClientes suspendCustomerNamed: unClienteASuspender.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: (unBookDeClientes includesCustomerNamed: unClienteASuspender) 
			]
		
		! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NM 5/17/2021 02:17:23'!
m:task

	| customerBook |
			
	customerBook := CustomerBook new.

	[ task .
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NM 5/17/2021 13:35:27'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertHacer: [customerBook addCustomerNamed: 'John Lennon'.] NoDemoraMasDe: 50*millisecond.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NM 5/17/2021 13:35:58'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	  
	self assertHacer: [customerBook removeCustomerNamed: paulMcCartney.] NoDemoraMasDe: 100*millisecond.
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'HAW 8/28/2017 08:57:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NM 5/17/2021 13:36:57'!
test05Modificado

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertEnElBook: customerBook elNumeroDeClientesActivosEs: 0 elNumeroDeClientesSuspendidosEs: 1 elNumeroTotalDeClientesEs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NR 4/3/2019 10:50:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NM 5/17/2021 13:36:50'!
test06Modificado

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertEnElBook: customerBook elNumeroDeClientesActivosEs: 0 elNumeroDeClientesSuspendidosEs: 0 elNumeroTotalDeClientesEs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NR 4/3/2019 10:50:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NR 4/30/2020 09:08:46'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'NR 9/19/2018 17:57:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
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


!CustomerBook methodsFor: 'customer management' stamp: 'a 5/17/2021 17:15:53'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'a 5/17/2021 18:22:49'!
removeCustomerNamed: aName 
 
	|removedCustomer|
	removedCustomer := self remove: aName From: active.
	(removedCustomer isNil) ifTrue: [removedCustomer := self remove: aName From: suspended].
    	(removedCustomer isNil) ifTrue: [^NotFound signal].
	^removedCustomer.
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'as yet unclassified' stamp: 'a 5/17/2021 18:22:13'!
remove: aName From: aList

	1 to: aList size do: 
	[ :index |
		aName = (aList at: index)
			ifTrue: [
				aList removeAt: index.
				^ aName 
			] 
	].
	^nil.


! !

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
