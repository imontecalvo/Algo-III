!classDefinition: #TestMarsRover category: 'Ejercicio - MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - MarsRover'!

!TestMarsRover methodsFor: 'helper' stamp: 'Nacho 7/1/2021 00:06:58'!
assertTheRover: aRover isAtPosition: aCoordinate andFacing: aCardinalPoint

	self assert: aRover position = aCoordinate.
	self assert: aRover orientation = aCardinalPoint.! !


!TestMarsRover methodsFor: 'multipleCommandsTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test07roverMovingForwardIncreasesMultiplePositionsInFacingOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: 'fff'.
	
	self assertTheRover: rover isAtPosition: (0@3) andFacing: 'N'.! !

!TestMarsRover methodsFor: 'multipleCommandsTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test08roverMovingBackwardsDecreasesMultiplePositionsInFacingOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: 'bbb'.
	
	self assertTheRover: rover isAtPosition: (0@-3) andFacing: 'N'.! !

!TestMarsRover methodsFor: 'multipleCommandsTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test09roverRotatingLeftMultipleTimesChangesOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: 'lll'.
	
	self assertTheRover: rover isAtPosition: (0@0) andFacing: 'E'.! !

!TestMarsRover methodsFor: 'multipleCommandsTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test10roverRotatingRightMultipleTimesChangesOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: 'rrr'.
	
	self assertTheRover: rover isAtPosition: (0@0) andFacing: 'O'.! !


!TestMarsRover methodsFor: 'singleCommandTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test03roverMovingForwardIncreasesOnePositionInFacingOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: 'f'.
	
	self assertTheRover: rover isAtPosition: (0@1) andFacing: 'N'.! !

!TestMarsRover methodsFor: 'singleCommandTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test04roverMovingBackwardsDecreasesOndPositionInFacingOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: 'b'.
	
	self assertTheRover: rover isAtPosition: (0@-1) andFacing: 'N'.! !

!TestMarsRover methodsFor: 'singleCommandTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test05roverRotatingLeftOnceChangesOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: 'l'.
	
	self assertTheRover: rover isAtPosition: (0@0) andFacing: 'O'.! !

!TestMarsRover methodsFor: 'singleCommandTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test06roverRotationRightOnceChangesOrientation

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: 'r'.
	
	self assertTheRover: rover isAtPosition: (0@0) andFacing: 'E'.! !


!TestMarsRover methodsFor: 'exceptionalCaseTest' stamp: 'Nacho 7/1/2021 00:47:40'!
test01roverMustBeCreatedWithValidPositionAndOrientation
	

	self
		should: [ |rover|.				rover := MarsRover newAt: 1 facing: 'G']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidPositionOrOrientationErrorMessage ].! !


!TestMarsRover methodsFor: 'boundaryCasesTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test02roverStaysStillAfterReceivingEmptyCommand
	
	| rover |
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: ''.
	
	self assertTheRover: rover isAtPosition: (0@0) andFacing: 'N'.! !

!TestMarsRover methodsFor: 'boundaryCasesTests' stamp: 'Nacho 7/1/2021 01:43:13'!
test11ProcessingStopsAfterReceivingACommandWithInvalidCharacter

	|rover|
	
	rover := MarsRover newAt: 0@0 facing: 'N'.
	
	rover receiveACommandSequence: 'flfxfff'.
	
	self assertTheRover: rover isAtPosition: (-1@1) andFacing: 'O'.
	! !


!classDefinition: #MarsRover category: 'Ejercicio - MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientationState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - MarsRover'!

!MarsRover methodsFor: 'rotation - private' stamp: 'Nacho 6/29/2021 02:09:12'!
changeOrientationEast

	^orientationState :=  FacingEast new.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'Nacho 6/29/2021 02:09:17'!
changeOrientationNorth

	^orientationState :=  FacingNorth new.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'Nacho 6/29/2021 02:09:24'!
changeOrientationSouth

	^orientationState :=  FacingSouth new.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'Nacho 6/29/2021 02:08:32'!
changeOrientationWest

	^orientationState :=  FacingWest new.! !


!MarsRover methodsFor: 'movement - private' stamp: 'Nacho 6/29/2021 00:57:03'!
moveOnePositionEast

	^position := position + (1@0)! !

!MarsRover methodsFor: 'movement - private' stamp: 'Nacho 6/29/2021 00:56:40'!
moveOnePositionNorth

	^position := position + (0@1)! !

!MarsRover methodsFor: 'movement - private' stamp: 'Nacho 6/29/2021 00:56:48'!
moveOnePositionSouth

	^position := position + (0@-1)! !

!MarsRover methodsFor: 'movement - private' stamp: 'Nacho 6/29/2021 00:56:57'!
moveOnePositionWest

	^position := position + (-1@0)! !


!MarsRover methodsFor: 'private' stamp: 'Nacho 6/29/2021 02:16:39'!
initializeAt: aCoordinate facing: initialOrientationState.

	position := aCoordinate.
	orientationState := initialOrientationState.! !

!MarsRover methodsFor: 'private' stamp: 'Nacho 7/1/2021 01:27:53'!
loopThroughString: aCommandSequence EvaluatingTheClosure: closureWithTasks untilClosureValueIsEqualTo: aStoppingValue
  
	|result stillAString value|
	
	result _ aCommandSequence species new: aCommandSequence size.
	stillAString _ true.
	
	1 to: aCommandSequence size do: [ :index |
		value _ closureWithTasks value: (aCommandSequence at: index).
		(value = aStoppingValue ) ifTrue: [^result].
		(stillAString and: [ (value is: #Character) not]) ifTrue: [
			result _ result asArray.
			stillAString _ false ].
		result at: index put: value].
	^ result.
! !

!MarsRover methodsFor: 'private' stamp: 'Nacho 7/1/2021 02:06:25'!
processCommand: aCommand
	
	^orientationState processCommand: aCommand forTheRover: self.! !


!MarsRover methodsFor: 'public' stamp: 'Nacho 6/29/2021 01:51:49'!
orientation

	^orientationState cardinalPoint.! !

!MarsRover methodsFor: 'public' stamp: 'Nacho 6/25/2021 00:42:08'!
position

	^position.! !

!MarsRover methodsFor: 'public' stamp: 'Nacho 7/1/2021 01:44:12'!
receiveACommandSequence: aCommandSequence

	|aCommandProcessingBlock|
	
	aCommandProcessingBlock := [:aCommand | self processCommand: (aCommand asString)  ].
	
	self loopThroughString: aCommandSequence  EvaluatingTheClosure: aCommandProcessingBlock untilClosureValueIsEqualTo: self class invalidCommandErrorMessage.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Ejercicio - MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error messages' stamp: 'Nacho 7/1/2021 00:58:52'!
invalidCommandErrorMessage

	^'The command is invalid'.! !

!MarsRover class methodsFor: 'error messages' stamp: 'Nacho 7/1/2021 00:39:45'!
invalidPositionOrOrientationErrorMessage

	^'The position or orientation is invalid'.! !


!MarsRover class methodsFor: 'instance creation' stamp: 'Nacho 7/1/2021 00:45:41'!
newAt: aCoordinate facing: aCardinalPoint
	
	|initialOrientation|
	
	(aCoordinate isKindOf: Point) ifFalse: [self error: self invalidPositionOrOrientationErrorMessage].
	
	initialOrientation := RoverOrientationState for: aCardinalPoint.

	^ self new initializeAt: aCoordinate facing: initialOrientation.! !


!classDefinition: #RoverOrientationState category: 'Ejercicio - MarsRover'!
Object subclass: #RoverOrientationState
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - MarsRover'!

!RoverOrientationState methodsFor: 'private' stamp: 'Nacho 7/1/2021 01:37:40'!
cardinalPoint

	self subclassResponsibility.! !

!RoverOrientationState methodsFor: 'private' stamp: 'Nacho 7/1/2021 02:15:42'!
processCommand: aCommand forTheRover: aRover

	self subclassResponsibility.
	
	" 
	Elegimos no reemplazar los IFs vinculados a los diferentes comandos por dos razones:
		
		- En primer lugar, consideramos que el modelo se volveria mas dificil de seguir ya que implica un mayor numero de intercambios
		de mensajes entre objetos como se ve en el caso de las orientaciones. Sumar una nueva subclasificacion haria que ese intercambio 
		se vuelva mas confuso y poco practico.
		
		- En segundo lugar, en caso de querer agregar nuevos comandos no se vuelve tedioso el proceso de modificacion del codigo existente 
		ya que solo habria que añadir cuatro IFs (uno para cada orientacion) pues el numero de orientaciones es finito y no puede aumentar en 
		un futuro."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverOrientationState class' category: 'Ejercicio - MarsRover'!
RoverOrientationState class
	instanceVariableNames: ''!

!RoverOrientationState class methodsFor: 'orientation state selection' stamp: 'Nacho 7/1/2021 02:19:28'!
canHandle: aCardinalPoint

	self subclassResponsibility.! !


!RoverOrientationState class methodsFor: 'instance creation' stamp: 'Nacho 7/1/2021 00:44:15'!
for: aCardinalPoint

	^ (self allSubclasses detect: [:aRoverOrientation | aRoverOrientation canHandle: aCardinalPoint ] 
					ifNone: [self error: MarsRover invalidPositionOrOrientationErrorMessage ])
					new.

! !


!classDefinition: #FacingEast category: 'Ejercicio - MarsRover'!
RoverOrientationState subclass: #FacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - MarsRover'!

!FacingEast methodsFor: 'private' stamp: 'Nacho 6/29/2021 01:51:01'!
cardinalPoint

	^'E'.! !

!FacingEast methodsFor: 'private' stamp: 'Nacho 7/1/2021 02:06:25'!
processCommand: aCommand forTheRover: aRover

	(aCommand = 'f') ifTrue: [^aRover moveOnePositionEast ]. 
	(aCommand = 'b') ifTrue: [^aRover moveOnePositionWest ]. 
	(aCommand = 'l') ifTrue: [^aRover changeOrientationNorth ].
	(aCommand = 'r') ifTrue: [^aRover changeOrientationSouth ].
	
	^MarsRover invalidCommandErrorMessage.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacingEast class' category: 'Ejercicio - MarsRover'!
FacingEast class
	instanceVariableNames: ''!

!FacingEast class methodsFor: 'orientation state selection' stamp: 'Nacho 6/29/2021 01:35:22'!
canHandle: aCardinalPoint

	^ aCardinalPoint = 'E'.! !


!classDefinition: #FacingNorth category: 'Ejercicio - MarsRover'!
RoverOrientationState subclass: #FacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - MarsRover'!

!FacingNorth methodsFor: 'private' stamp: 'Nacho 6/29/2021 01:51:10'!
cardinalPoint

	^'N'.! !

!FacingNorth methodsFor: 'private' stamp: 'Nacho 7/1/2021 02:06:25'!
processCommand: aCommand forTheRover: aRover

	(aCommand = 'f') ifTrue: [^aRover moveOnePositionNorth ]. 
	(aCommand = 'b') ifTrue: [^aRover moveOnePositionSouth ]. 
	(aCommand = 'l') ifTrue: [^aRover changeOrientationWest ].
	(aCommand = 'r') ifTrue: [^aRover changeOrientationEast ].
	
	^MarsRover invalidCommandErrorMessage.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacingNorth class' category: 'Ejercicio - MarsRover'!
FacingNorth class
	instanceVariableNames: ''!

!FacingNorth class methodsFor: 'orientation state selection' stamp: 'Nacho 6/29/2021 01:35:27'!
canHandle: aCardinalPoint

	^ aCardinalPoint = 'N'.! !


!classDefinition: #FacingSouth category: 'Ejercicio - MarsRover'!
RoverOrientationState subclass: #FacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - MarsRover'!

!FacingSouth methodsFor: 'private' stamp: 'Nacho 6/29/2021 01:51:18'!
cardinalPoint

	^'S'.! !

!FacingSouth methodsFor: 'private' stamp: 'Nacho 7/1/2021 02:06:25'!
processCommand: aCommand forTheRover: aRover

	(aCommand = 'f') ifTrue: [^aRover moveOnePositionSouth ]. 
	(aCommand = 'b') ifTrue: [^aRover moveOnePositionNorth ]. 
	(aCommand = 'l') ifTrue: [^aRover changeOrientationEast ].
	(aCommand = 'r') ifTrue: [^aRover changeOrientationWest ].
	
	^MarsRover invalidCommandErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacingSouth class' category: 'Ejercicio - MarsRover'!
FacingSouth class
	instanceVariableNames: ''!

!FacingSouth class methodsFor: 'orientation state selection' stamp: 'Nacho 6/29/2021 01:35:34'!
canHandle: aCardinalPoint

	^ aCardinalPoint = 'S'.! !


!classDefinition: #FacingWest category: 'Ejercicio - MarsRover'!
RoverOrientationState subclass: #FacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - MarsRover'!

!FacingWest methodsFor: 'private' stamp: 'Nacho 6/29/2021 01:51:27'!
cardinalPoint

	^'O'.! !

!FacingWest methodsFor: 'private' stamp: 'Nacho 7/1/2021 02:06:25'!
processCommand: aCommand forTheRover: aRover

	(aCommand = 'f') ifTrue: [^aRover moveOnePositionWest ]. 
	(aCommand = 'b') ifTrue: [^aRover moveOnePositionEast ]. 
	(aCommand = 'l') ifTrue: [^aRover changeOrientationSouth ].
	(aCommand = 'r') ifTrue: [^aRover changeOrientationNorth ].
	
	^MarsRover invalidCommandErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacingWest class' category: 'Ejercicio - MarsRover'!
FacingWest class
	instanceVariableNames: ''!

!FacingWest class methodsFor: 'orientation state selection' stamp: 'Nacho 6/29/2021 01:35:40'!
canHandle: aCardinalPoint

	^ aCardinalPoint = 'O'.! !
