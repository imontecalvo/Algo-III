!classDefinition: #NumeroTest category: 'Numeros-Parte1-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:40'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:53'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:15:37'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Numero with: (Numero with: 7) over: (Numero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:16:19'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Numero with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:44:24'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: (Numero with: negativeOne over: two)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:29:45'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Numero with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:30:07'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Numero with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/8/2019 21:09:34'!
setUp

	zero := Numero with: 0.
	one := Numero with: 1.
	two := Numero with: 2.
	three:= Numero with: 3.
	four := Numero with: 4.
	five := Numero with: 5.
	eight := Numero with: 8.
	negativeOne := Numero with: -1.
	negativeTwo := Numero with: -2.
	
	oneHalf := Numero with: one over: two.
	oneFifth := Numero with: one over: five.
	twoFifth := Numero with: two over: five.
	twoTwentyfifth := Numero with: two over: (Numero with: 25).
	fiveHalfs := Numero with: five over: two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte1-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: 'type value numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'a 5/20/2021 21:15:38'!
* aMultiplier 

	"type = #Entero ifTrue:	
		[ ^self class with: value * aMultiplier integerValue ].
		
	type = #Fraccion ifTrue:
		[ ^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) ]."
	self subclassResponsibility.
		
	self error: 'Tipo de número no soportado'
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'a 5/20/2021 21:17:31'!
+ anAdder 
	
	"type = #Entero ifTrue:
		[ ^self class with: value + anAdder integerValue ].
	
	type = #Fraccion ifTrue:
		[ | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator ]."
	self subclassResponsibility.
	
	self error: 'Tipo de número no soportado'
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'a 5/20/2021 21:21:12'!
negated
	
	"type = #Entero ifTrue:
		[ ^self * (self class with: -1) ].
		
	type = #Fraccion ifTrue:
		[ ^self class with: numerator * (self class with: -1) over: denominator ]."
	self subclassResponsibility.! !


!Numero methodsFor: 'testing' stamp: 'a 5/20/2021 20:37:00'!
isNegative
	
	self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'a 5/20/2021 20:51:45'!
isOne

	self subclassResponsibility! !

!Numero methodsFor: 'testing' stamp: 'a 5/20/2021 21:04:52'!
isZero

	self subclassResponsibility! !


!Numero methodsFor: 'initialization' stamp: 'NR 9/8/2019 20:40:14'!
initializeWith: aValue
	
	type := #Entero.
	value := aValue! !

!Numero methodsFor: 'initialization' stamp: 'NR 9/8/2019 20:40:23'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	type:=#Fraccion.
	numerator := aNumerator.
	denominator := aDenominator ! !


!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:46'!
denominator

	^denominator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:33:53'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:52'!
numerator

	^numerator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 21:55:04'!
type
	
	^type! !


!Numero methodsFor: 'printing' stamp: 'a 5/20/2021 23:07:13'!
printOn: aStream
	
	"type = #Entero ifTrue:
		[ aStream print: value ].
	
	type = #Fraccion ifTrue:
		[ aStream 
			print: numerator;
			nextPut: $/;
			print: denominator ]."
	self subclassResponsibility.! !


!Numero methodsFor: 'comparing' stamp: 'a 5/20/2021 21:32:02'!
= anObject

	"((anObject isKindOf: self class) and: [ type = anObject type ]) ifTrue: [
		type = #Entero ifTrue: [ ^value = anObject integerValue ].
		type = #Fraccion ifTrue: [ ^(numerator * anObject denominator) = (denominator * anObject numerator) ].
		^false
	]."
	^self subclassResponsibility.

	
! !

!Numero methodsFor: 'comparing' stamp: 'a 5/20/2021 23:03:41'!
hash
	
	self subclassResponsibility.! !


!Numero methodsFor: 'arithmetic operations - private' stamp: 'a 5/20/2021 21:23:31'!
// aDivisor 
	
	"type = #Entero ifTrue:
		[ ^self class with: value // aDivisor integerValue ]."
	self subclassResponsibility.
		
	self error: 'Tipo de número no soportado'! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'a 5/20/2021 23:04:17'!
greatestCommonDivisorWith: anEntero 
	
	"type = #Entero ifTrue:
		[ ^self class with: (value gcd: anEntero integerValue) ]."
	self subclassResponsibility.
		
	self error: 'Tipo de número no soportado'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte1-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !


!Numero class methodsFor: 'instance creation' stamp: 'a 5/20/2021 20:40:23'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^Entero new initializeWith: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'a 5/20/2021 21:06:05'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^Fraccion new initializeWith: numerator over: denominator! !


!classDefinition: #Entero category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Entero methodsFor: 'testing' stamp: 'a 5/20/2021 20:51:09'!
isNegative
	^value < 0.! !

!Entero methodsFor: 'testing' stamp: 'a 5/20/2021 20:51:18'!
isOne
	^value = 1.! !

!Entero methodsFor: 'testing' stamp: 'a 5/20/2021 21:03:31'!
isZero
	^value = 0.! !


!Entero methodsFor: 'arithmetic operations' stamp: 'a 5/20/2021 21:13:15'!
* aMultiplier
	^self class with: value * aMultiplier integerValue.	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 5/20/2021 21:16:36'!
+ anAdder
	^self class with: value + anAdder integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 5/20/2021 21:19:29'!
negated
	^self * (self class with: -1).! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'a 5/20/2021 21:23:06'!
// aDivisor
	^self class with: value // aDivisor integerValue.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'a 5/20/2021 23:01:39'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue).! !


!Entero methodsFor: 'comparing' stamp: 'a 5/20/2021 21:28:46'!
= anObject

	((anObject isKindOf: self class) and: [ type = anObject type ]) ifTrue: [^value = anObject integerValue ].
	^false.! !

!Entero methodsFor: 'comparing' stamp: 'a 5/20/2021 23:02:15'!
hash
	
	^value hash.! !


!Entero methodsFor: 'printing' stamp: 'a 5/20/2021 23:05:30'!
printOn: aStream
	
	aStream print: value.
	! !


!classDefinition: #Fraccion category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Fraccion methodsFor: 'testing' stamp: 'a 5/20/2021 20:50:56'!
isNegative
	^denominator < 0.! !

!Fraccion methodsFor: 'testing' stamp: 'a 5/20/2021 20:50:46'!
isOne
	^false.! !

!Fraccion methodsFor: 'testing' stamp: 'a 5/20/2021 21:04:06'!
isZero
	^false.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 5/20/2021 21:14:06'!
* aMultiplier
	^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 5/20/2021 21:17:03'!
+ anAdder
	| newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 5/20/2021 21:20:42'!
negated
	^self class with: numerator * (self class with: -1) over: denominator.! !


!Fraccion methodsFor: 'comparing' stamp: 'a 5/20/2021 21:30:32'!
= anObject

	((anObject isKindOf: self class) and: [ type = anObject type ]) ifTrue: [ ^(numerator * anObject denominator) = (denominator * anObject numerator) ].
	^false.
! !

!Fraccion methodsFor: 'comparing' stamp: 'a 5/20/2021 23:03:25'!
hash
	
	^(numerator hash / denominator hash) hash.! !


!Fraccion methodsFor: 'printing' stamp: 'a 5/20/2021 23:06:40'!
printOn: aStream
	
	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator .! !
