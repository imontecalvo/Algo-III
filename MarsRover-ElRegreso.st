!classDefinition: #TestMarsRover category: 'MarsRover-Solucion'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:42:57'!
test01MarsRoverDoestNotMoveWhenNoCommandsAreSent

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: '' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:05'!
test02RoverFacingNorthCanMoveForward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'f' endsAt: 0@1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:13'!
test03RoverFacingNorthCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'b' endsAt: 0@-1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:24'!
test04RoverFacingNorthHeadsEastAfterTurningRight

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'r' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:55'!
test05RoverFacingNorthHeadsWestAfterTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'l' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:26'!
test06RoverFacingEastHeadsSouthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'r' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:43'!
test07RoverFacingSouthHeadsWestWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'r' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:00'!
test08RoverFacingWestHeadsNorthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'r' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:20'!
test09RoverFacingEastHeadsNorthWhenTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'l' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:52'!
test10RoverFacingSouthHeadsEastWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'l' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:46:17'!
test11RoverFacingWestHeadsSouthWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'l' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:36'!
test12RoverFacingEastCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'f' endsAt: 1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:55'!
test13RoverFacingEastCanMoveBackwards

	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'b' endsAt: -1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:20'!
test14RoverFacingSouthCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'f' endsAt: 0@-1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:38'!
test15RoverFacingSouthCanMoveBackward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'b' endsAt: 0@1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:10'!
test16RoverFacingWestCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'f' endsAt: -1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:46'!
test17RoverFacingWestCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'b' endsAt: 1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:50:56'!
test18RoverCanProcessMultipleCommands

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'ff' endsAt: 0@2 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 6/30/2021 16:05:43'!
test19RoverStopsWhenProcessingAnInvalidCommand

	| marsRover |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	
	self should: [ marsRover processCommands: 'fxf' ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: marsRover invalidCommandErrorMessage.
			self assert: (marsRover isAt: 0@1 heading: #North).
		].
	
	! !


!TestMarsRover methodsFor: 'assertions' stamp: 'LL 7/1/2021 00:42:36'!
assertRoverStartingAt: aPosition heading: aCardinalPoint afterProcessing: aStringOfCommands endsAt: aFinalPosition heading: aFinalCardinalPoint

	| marsRover |
	marsRover := MarsRover startingAt: aPosition heading: aCardinalPoint.
	
	marsRover processCommands: aStringOfCommands.
	
	self assert: (marsRover isAt: aFinalPosition heading: aFinalCardinalPoint)! !


!classDefinition: #TestMarsRoverLog category: 'MarsRover-Solucion'!
TestCase subclass: #TestMarsRoverLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:08:38'!
test01TheLogIsInitiallyEmpty

	|marsRover marsRoverLog|
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverLog := MarsRoverLog new.
	marsRover addPositionObserver: marsRoverLog.
	marsRover addHeadingObserver: marsRoverLog.
	
	self assert: marsRoverLog log isEmpty.
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:11:33'!
test02LogsPositionWhenMarsRoverMovesUp

	|marsRover marsRoverLog|
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverLog := MarsRoverLog new.
	marsRover addPositionObserver: marsRoverLog.
	marsRover processCommands: 'f'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: '0@1').
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:11:51'!
test03LogsPositionWhenMarsRoverMovesDown

	|marsRover marsRoverLog |
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverLog := MarsRoverLog new.
	marsRover addPositionObserver: marsRoverLog.
	marsRover processCommands: 'b'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: '0@-1').
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:12:44'!
test04LogsPositionWhenMarsRoverMovesRight

	|marsRover marsRoverLog |
	
	marsRover := MarsRover startingAt: 0@0 heading: #East.
	marsRoverLog := MarsRoverLog new.
	marsRover addPositionObserver: marsRoverLog.
	marsRover processCommands: 'f'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: '1@0').
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:12:53'!
test05LogsPositionWhenMarsRoverMovesLeft

	|marsRover marsRoverLog |
	
	marsRover := MarsRover startingAt: 0@0 heading: #East.
	marsRoverLog := MarsRoverLog new.
	marsRover addPositionObserver: marsRoverLog.
	marsRover processCommands: 'b'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: '-1@0').
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:13:51'!
test06LogsMultipleMovements

	|marsRover marsRoverLog |
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverLog := MarsRoverLog new.
	marsRover addPositionObserver: marsRoverLog.
	marsRover processCommands: 'frb'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: '0@1' with: '-1@1').
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:14:56'!
test07LogsHeadingWhenMarsRoverRotatesEast

	|marsRover marsRoverLog |
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverLog := MarsRoverLog new.
	marsRover addHeadingObserver: marsRoverLog.
	marsRover processCommands: 'r'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: 'Facing East').
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:15:12'!
test08LogsHeadingWhenMarsRoverRotatesWest

	|marsRover marsRoverLog |
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverLog := MarsRoverLog new.
	marsRover addHeadingObserver: marsRoverLog.
	marsRover processCommands: 'l'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: 'Facing West').
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:15:24'!
test09LogsHeadingWhenMarsRoverRotatesNorth

	|marsRover marsRoverLog |
	
	marsRover := MarsRover startingAt: 0@0 heading: #West.
	marsRoverLog := MarsRoverLog new.
	marsRover addHeadingObserver: marsRoverLog.
	marsRover processCommands: 'r'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: 'Facing North').
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:15:33'!
test10LogsHeadingWhenMarsRoverRotatesSouth

	|marsRover marsRoverLog |
	
	marsRover := MarsRover startingAt: 0@0 heading: #West.
	marsRoverLog := MarsRoverLog new.
	marsRover addHeadingObserver: marsRoverLog.
	marsRover processCommands: 'l'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: 'Facing South').
	
	
	! !

!TestMarsRoverLog methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:16:35'!
test11LogsPositionAndHeadingAtTheSameTime

	|marsRover marsRoverLog |
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverLog := MarsRoverLog new.
	marsRover addPositionObserver: marsRoverLog.
	marsRover addHeadingObserver: marsRoverLog.
	marsRover processCommands: 'fl'.
	
	self assert: marsRoverLog log equals: (OrderedCollection with: '0@1' with: 'Facing West').
	
	
	! !


!classDefinition: #TestMarsRoverWindow category: 'MarsRover-Solucion'!
TestCase subclass: #TestMarsRoverWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestMarsRoverWindow methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:19:27'!
test01WindowInitiallyShowsNothing

	|marsRover marsRoverWindow|
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverWindow := MarsRoverWindow new.
	marsRover addPositionObserver: marsRoverWindow.
	marsRover addHeadingObserver: marsRoverWindow.
	
	self assert: marsRoverWindow showPosition equals: ''.
	self assert: marsRoverWindow showHeading equals: ''.

	
	! !

!TestMarsRoverWindow methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:20:45'!
test02WindowShowPositionWhenMarsRoverMoves

	|marsRover marsRoverWindow|
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverWindow := MarsRoverWindow new.
	marsRover addPositionObserver: marsRoverWindow.
	
	marsRover processCommands: 'f'.
	
	self assert: marsRoverWindow showPosition equals: '0@1'.
	
	! !

!TestMarsRoverWindow methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:21:20'!
test03WindowShowHeadingWhenMarsRoverRotatesEast

	|marsRover marsRoverWindow|
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverWindow := MarsRoverWindow new.
	marsRover addHeadingObserver: marsRoverWindow.
	
	marsRover processCommands: 'r'.
	
	self assert: marsRoverWindow showHeading equals: 'Facing East'.
	
	! !

!TestMarsRoverWindow methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:21:34'!
test04WindowShowHeadingWhenMarsRoverRotatesWest

	|marsRover marsRoverWindow|
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	marsRoverWindow := MarsRoverWindow new.
	marsRover addHeadingObserver: marsRoverWindow.
	
	marsRover processCommands: 'l'.
	
	self assert: marsRoverWindow showHeading equals: 'Facing West'.
	
	! !

!TestMarsRoverWindow methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:36:22'!
test05WindowShowHeadingWhenMarsRoverRotatesNorth

	|marsRover marsRoverWindow|
	
	marsRover := MarsRover startingAt: 0@0 heading: #West.
	marsRoverWindow := MarsRoverWindow new.
	marsRover addHeadingObserver: marsRoverWindow.
	
	marsRover processCommands: 'r'.
	
	self assert: marsRoverWindow showHeading equals: 'Facing North'.
	
	! !

!TestMarsRoverWindow methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:21:50'!
test06WindowShowHeadingWhenMarsRoverRotatesSouth

	|marsRover marsRoverWindow|
	
	marsRover := MarsRover startingAt: 0@0 heading: #West.
	marsRoverWindow := MarsRoverWindow new.
	marsRover addHeadingObserver: marsRoverWindow.
	
	marsRover processCommands: 'l'.
	
	self assert: marsRoverWindow showHeading equals: 'Facing South'.
	
	! !

!TestMarsRoverWindow methodsFor: 'tests' stamp: 'Nacho 7/22/2021 17:22:26'!
test07WindowShowsCurrentPositionAndHeadingAtTheSameTime

	|marsRover marsRoverWindow|
	
	marsRover := MarsRover startingAt: 0@0 heading: #East.
	marsRoverWindow := MarsRoverWindow new.
	marsRover addPositionObserver: marsRoverWindow.
	marsRover addHeadingObserver: marsRoverWindow.
	
	marsRover processCommands: 'fl'.
	
	self assert: marsRoverWindow showPositionAndHeading equals: '1@0 and Facing North'.
	
	! !


!classDefinition: #MarsRover category: 'MarsRover-Solucion'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRover methodsFor: 'initialization' stamp: 'Nacho 8/26/2021 16:59:31'!
initializeStartingAt: aPosition heading: aCardinalPoint 
	
	position := RoverVariableProxy newWithInitialValue: 0@0 andUpdateMessage: #positionChangedTo:.
	head := RoverVariableProxy newWithInitialValue: (MarsRoverHead of: self facing: aCardinalPoint) andUpdateMessage: #headingChangedTo:.
	! !


!MarsRover methodsFor: 'process commands' stamp: 'LL 6/30/2021 15:54:14'!
processCommands: aStringWithCommands

	aStringWithCommands do: [ :aCommand | 
		self assertCommandIsValid: aCommand.
		self processCommand: aCommand.
	].
	
! !


!MarsRover methodsFor: 'testing' stamp: 'Nacho 7/22/2021 16:03:47'!
isAt: aPosition heading: aCardinalPoint

	^ ( (position value) = aPosition) and: [ (head value) isHeading: aCardinalPoint ]! !


!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:54:11'!
assertCommandIsValid: aCommand

	^ (self isInvalidCommand: aCommand) ifTrue: [ self error: self invalidCommandErrorMessage ]! !

!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:48:06'!
invalidCommandErrorMessage

	^'Invalid command'! !

!MarsRover methodsFor: 'private - process commands' stamp: 'Nacho 7/22/2021 16:04:48'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ (head value) movingForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ (head value) movingBackwards ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ (head value) rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ (head value) rotateLeft ].
! !


!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:42'!
isBackwardCommand: command

	^ command = $b! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:27'!
isForwardCommand: command

	^ command = $f! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:51:21'!
isInvalidCommand: aCommand
	^(self isForwardCommand: aCommand) not and: 
		[ (self isBackwardCommand: aCommand) not and: 
			[ (self isRotateRightCommand: aCommand) not and: 
				[ (self isRotateLeftCommand: aCommand) not ] ] ]! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:50:53'!
isRotateLeftCommand: command

	^ command = $l! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:27:33'!
isRotateRightCommand: command

	^ command = $r! !


!MarsRover methodsFor: 'dd - moving' stamp: 'Nacho 7/20/2021 01:26:10'!
moveDown
	
	self nextStep: (0@-1).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'Nacho 7/20/2021 01:29:57'!
moveLeft

	self nextStep: (-1@0).
	! !

!MarsRover methodsFor: 'dd - moving' stamp: 'Nacho 7/20/2021 01:30:13'!
moveRight

	self nextStep: (1@0).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'Nacho 7/20/2021 01:30:30'!
moveUp

	self nextStep: (0@1).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'Nacho 7/22/2021 18:25:50'!
nextStep: aStep

	position updateValue: (position value + aStep).
	position notifyChange.

	! !


!MarsRover methodsFor: 'add observers' stamp: 'Nacho 7/22/2021 15:48:47'!
addHeadingObserver: HeadingObserver

	head addObserver: HeadingObserver.! !

!MarsRover methodsFor: 'add observers' stamp: 'Nacho 7/22/2021 16:05:46'!
addPositionObserver: aPositionObserver

	position addObserver: aPositionObserver.! !


!MarsRover methodsFor: 'dd - heading' stamp: 'Nacho 7/20/2021 01:38:27'!
headEast
	
	self nextHead: (MarsRoverHeadFacingEast of: self).
	! !

!MarsRover methodsFor: 'dd - heading' stamp: 'Nacho 7/20/2021 01:38:52'!
headNorth

	self nextHead: (MarsRoverHeadFacingNorth of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'Nacho 7/20/2021 01:39:19'!
headSouth

	self nextHead: (MarsRoverHeadFacingSouth of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'Nacho 7/20/2021 01:39:39'!
headWest

	self nextHead: (MarsRoverHeadFacingWest of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'Nacho 7/22/2021 16:46:53'!
nextHead: aHead
	
	head updateValue: aHead.
	head notifyChange.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Solucion'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 13:30:13'!
startingAt: aPoint heading: aCardinalPoint 
	
	^self new initializeStartingAt: aPoint heading: aCardinalPoint ! !


!classDefinition: #MarsRoverHead category: 'MarsRover-Solucion'!
Object subclass: #MarsRoverHead
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'Nacho 8/26/2021 17:00:40'!
accept: anObserver

	^self subclassResponsibility.! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:17:57'!
initializeOf: aMarsRover

	marsRover := aMarsRover! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
isHeading: aCardinalPoint

	^self class whenFacing: aCardinalPoint

	! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:36:46'!
rotateLeft

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:36:43'!
rotateRight

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHead class' category: 'MarsRover-Solucion'!
MarsRoverHead class
	instanceVariableNames: ''!

!MarsRoverHead class methodsFor: 'testing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	self subclassResponsibility.! !


!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 16:16:27'!
of: aMarsRover

	^self new initializeOf: aMarsRover! !

!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 19:46:37'!
of: aMarsRover facing: aCardinalPoint
	
	| headingSubclass |
	headingSubclass := self subclasses detect: [ :aHeadingSubclass | aHeadingSubclass whenFacing: aCardinalPoint ].
	
	^headingSubclass of: aMarsRover.! !


!classDefinition: #MarsRoverHeadFacingEast category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'Nacho 8/26/2021 17:02:36'!
accept: aVisitor

	aVisitor visitHeadFacingEast.! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveLeft.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveRight.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:22'!
rotateLeft

	^marsRover headNorth.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:10:14'!
rotateRight

	^marsRover headSouth.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingEast class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingEast class
	instanceVariableNames: ''!

!MarsRoverHeadFacingEast class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #East! !


!classDefinition: #MarsRoverHeadFacingNorth category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'Nacho 8/26/2021 17:02:44'!
accept: aVisitor

	aVisitor visitHeadFacingNorth.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveDown.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveUp.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:33'!
rotateLeft

	^marsRover headWest.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:10:58'!
rotateRight

	^marsRover headEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingNorth class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingNorth class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #North! !


!classDefinition: #MarsRoverHeadFacingSouth category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'Nacho 8/26/2021 17:02:50'!
accept: aVisitor

	aVisitor visitHeadFacingSouth.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveUp.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveDown! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:43'!
rotateLeft

	^marsRover headEast.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:12:30'!
rotateRight

	^marsRover headWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingSouth class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingSouth class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #South! !


!classDefinition: #MarsRoverHeadFacingWest category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'Nacho 8/26/2021 17:02:55'!
accept: aVisitor

	aVisitor visitHeadFacingWest.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveRight.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveLeft.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:52'!
rotateLeft

	^marsRover headSouth.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:12:44'!
rotateRight

	^marsRover headNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingWest class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingWest class
	instanceVariableNames: ''!

!MarsRoverHeadFacingWest class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #West! !


!classDefinition: #MarsRoverLog category: 'MarsRover-Solucion'!
Object subclass: #MarsRoverLog
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverLog methodsFor: 'main protocol' stamp: 'Nacho 7/22/2021 17:26:45'!
log

	^log.! !


!MarsRoverLog methodsFor: 'initialization' stamp: 'Nacho 7/22/2021 17:26:51'!
initialize

	log := OrderedCollection new.! !


!MarsRoverLog methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:00:40'!
headingChangedTo: aHead
	
	aHead accept: self.! !

!MarsRoverLog methodsFor: 'changes' stamp: 'Nacho 7/22/2021 17:27:07'!
positionChangedTo: aPosition

	^log add: aPosition asString! !

!MarsRoverLog methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:01:32'!
visitHeadFacingEast

	log add: 'Facing East'.! !

!MarsRoverLog methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:01:42'!
visitHeadFacingNorth

	log add: 'Facing North'.! !

!MarsRoverLog methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:01:54'!
visitHeadFacingSouth

	log add: 'Facing South'.! !

!MarsRoverLog methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:02:03'!
visitHeadFacingWest

	log add: 'Facing West'.! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-Solucion'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'positionText headingText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverWindow methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:00:40'!
headingChangedTo: aHead
	
	aHead accept: self.! !

!MarsRoverWindow methodsFor: 'changes' stamp: 'Nacho 7/22/2021 17:27:55'!
positionChangedTo: aPosition

	positionText := aPosition asString.! !

!MarsRoverWindow methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:01:32'!
visitHeadFacingEast

	headingText := 'Facing East'.! !

!MarsRoverWindow methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:01:42'!
visitHeadFacingNorth

	headingText := 'Facing North'.! !

!MarsRoverWindow methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:01:55'!
visitHeadFacingSouth

	headingText := 'Facing South'.! !

!MarsRoverWindow methodsFor: 'changes' stamp: 'Nacho 8/26/2021 17:02:03'!
visitHeadFacingWest

	headingText := 'Facing West'.! !


!MarsRoverWindow methodsFor: 'main protocol' stamp: 'Nacho 7/22/2021 17:28:02'!
showHeading

	^headingText.! !

!MarsRoverWindow methodsFor: 'main protocol' stamp: 'Nacho 7/22/2021 17:28:07'!
showPosition

	^positionText.! !

!MarsRoverWindow methodsFor: 'main protocol' stamp: 'Nacho 7/22/2021 17:29:07'!
showPositionAndHeading

	^self showPosition, ' and ', self showHeading.! !


!MarsRoverWindow methodsFor: 'initialization' stamp: 'Nacho 7/22/2021 17:29:19'!
initialize

	positionText:= ''.
	headingText := ''.! !


!classDefinition: #RoverVariableProxy category: 'MarsRover-Solucion'!
Object subclass: #RoverVariableProxy
	instanceVariableNames: 'currentValue observers updateMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!RoverVariableProxy methodsFor: 'private protocol' stamp: 'Nacho 7/22/2021 15:49:19'!
addObserver: anObserver

	observers add: anObserver.
! !

!RoverVariableProxy methodsFor: 'private protocol' stamp: 'Nacho 7/22/2021 18:36:22'!
doesNotUnderstand: aMessage

	^aMessage sendTo: currentValue.! !

!RoverVariableProxy methodsFor: 'private protocol' stamp: 'Nacho 7/22/2021 16:43:28'!
notifyChange

	observers do: [:anObserver | updateMessage sendTo: anObserver with: currentValue].

! !

!RoverVariableProxy methodsFor: 'private protocol' stamp: 'Nacho 7/22/2021 15:52:42'!
updateValue: newValue

	currentValue := newValue.

! !

!RoverVariableProxy methodsFor: 'private protocol' stamp: 'Nacho 7/22/2021 15:52:20'!
value

	^currentValue.

! !


!RoverVariableProxy methodsFor: 'initialization' stamp: 'Nacho 7/22/2021 16:44:00'!
initializeWithInitialValue: aValue andUpdateMessage: aMessage

	currentValue := aValue.
	observers := OrderedCollection new.
	updateMessage := aMessage.

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverVariableProxy class' category: 'MarsRover-Solucion'!
RoverVariableProxy class
	instanceVariableNames: ''!

!RoverVariableProxy class methodsFor: 'as yet unclassified' stamp: 'Nacho 7/22/2021 18:33:58'!
newWithInitialValue: aValue andUpdateMessage: aMessage

	^self new initializeWithInitialValue: aValue andUpdateMessage: aMessage.! !
