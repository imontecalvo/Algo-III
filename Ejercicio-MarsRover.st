!classDefinition: #TestMarsRover category: 'Ejercicio - MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - MarsRover'!

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 01:52:58'!
test01roverMovingForwardIncreasesOnePositionInFacingOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveCommand: 'f'.
	
	self assert: rover position = (0@1).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 01:54:26'!
test02roverMovingBackwardsDecreasesOndPositionInFacingOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveCommand: 'b'.
	
	self assert: rover position = (0@-1).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 01:55:15'!
test03roverLeftRotationChangesOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveCommand: 'l'.
	
	self assert: rover orientation = 'O'.! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 01:55:50'!
test04roverRightRotationChangesOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveCommand: 'r'.
	
	self assert: rover orientation = 'E'.! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 01:57:01'!
test05roverCanReceiveAndProcessMultipleCommands

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveCommand: 'flf'.
	
	self assert: rover position = (-1@1).
	! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 02:00:20'!
test06ProcessingStopsAfterReceivingACommandWithInvalidCharacter

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveCommand: 'flfxfff'.
	
	self assert: rover position = (-1@1).
	! !


!classDefinition: #MarsRover category: 'Ejercicio - MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 00:38:19'!
initializeAt: aCoordinate facing: aCardinalPoint.

	position := aCoordinate.
	orientation := aCardinalPoint.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 00:46:43'!
orientation

	^orientation.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 00:42:08'!
position

	^position.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 01:48:07'!
processCommand: aCommand

	(aCommand = 'f') ifTrue: [ (orientation = 'N') ifTrue: [^position := position + (0@1)]. 
						   (orientation = 'S') ifTrue: [^position := position + (0@-1)]. 
						   (orientation = 'E') ifTrue: [^position := position + (1@0)].
						   (orientation = 'O') ifTrue: [^position := position + (-1@0)].
						  ].
					
	(aCommand = 'b') ifTrue: [ (orientation = 'N') ifTrue: [^position := position + (0@-1)]. 
						   (orientation = 'S') ifTrue: [^position := position + (0@1)]. 
						   (orientation = 'E') ifTrue: [^position := position + (-1@0)].
						   (orientation = 'O') ifTrue: [^position := position + (1@0)].
						  ].
					
	(aCommand = 'l' ) ifTrue: [(orientation = 'N') ifTrue: [^orientation := 'O'].
						  (orientation = 'S') ifTrue: [^orientation := 'E'].
						  (orientation = 'E') ifTrue: [^orientation := 'N'].
						  (orientation = 'O') ifTrue: [^orientation := 'S'].
						  ].
					
	(aCommand = 'r' ) ifTrue: [(orientation = 'N') ifTrue: [^orientation := 'E'].
						  (orientation = 'S') ifTrue: [^orientation := 'O'].
						  (orientation = 'E') ifTrue: [^orientation := 'S'].
						  (orientation = 'O') ifTrue: [^orientation := 'N']..
						].
	
	^false.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 01:47:17'!
receiveCommand: aCommand

	"aCommand collect: [:aCharacter | self processCommand: (aCharacter asString)  ]."
	|aBlock result value stillAString|
	
	aBlock := [:aCharacter | self processCommand: (aCharacter asString)  ].
	
	result _ aCommand species new: aCommand size.
	stillAString _ true.
	1 to: aCommand size do: [ :index |
		value _ aBlock value: (aCommand at: index).
		(value = false) ifTrue: [^result].
		(stillAString and: [ (value is: #Character) not]) ifTrue: [
			result _ result asArray.
			stillAString _ false ].
		result at: index put: value].
	^ result! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Ejercicio - MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'Nacho 6/25/2021 00:39:30'!
newAt: aCoordinate facing: aCardinalPoint

	^ self new initializeAt: aCoordinate facing: aCardinalPoint.! !
