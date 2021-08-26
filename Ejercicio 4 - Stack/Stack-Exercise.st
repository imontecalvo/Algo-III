!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'f 6/7/2021 00:33:43'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack notEmptyStack sentenceFinderByPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'NM 6/10/2021 03:08:20'!
setUp
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	
	emptyStack := OOStack new.
	
	notEmptyStack := OOStack new.
	notEmptyStack push: 'winter is coming'.
	notEmptyStack push: 'winning is everything'.
	notEmptyStack push: 'The winds of Winter'.
	notEmptyStack push: 'Winter is here'.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NM 6/10/2021 03:08:36'!
test01PrefixCannotBeEmpty
	
	self 
		should: [ sentenceFinderByPrefix findSentencesWith: '' in: emptyStack ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixIsInvalidErrorMessage ]
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NM 6/10/2021 03:08:48'!
test02PrefixCannotContainABlankSpace
	
	self 
		should: [ sentenceFinderByPrefix findSentencesWith: 'Winter ' in: notEmptyStack  ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixIsInvalidErrorMessage ]
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NM 6/10/2021 03:17:46'!
test03StackCannotBeEmpty
	
	self 
		should: [ sentenceFinderByPrefix findSentencesWith: 'Winter' in: emptyStack  ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: OOStack stackEmptyErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NM 6/10/2021 17:13:42'!
test04PrefixWithOneMatch

	|newCollection expectedCollection|
	
	newCollection  := sentenceFinderByPrefix findSentencesWith: 'Win' in: notEmptyStack.
	
	expectedCollection := OrderedCollection new.
	expectedCollection add: 'Winter is here'.
	
	self assert: newCollection = expectedCollection.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NM 6/10/2021 17:13:55'!
test05PrefixWithMultipleMatches

	|newCollection expectedCollection|
	
	newCollection  := sentenceFinderByPrefix findSentencesWith: 'win' in: notEmptyStack.
	
	expectedCollection := OrderedCollection new.
	expectedCollection add: 'winning is everything'.
	expectedCollection add: 'winter is coming'.
	
	self assert: newCollection = expectedCollection.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NM 6/10/2021 17:14:07'!
test06PrefixWithNoMatches

	|newCollection expectedCollection|
	
	newCollection  := sentenceFinderByPrefix findSentencesWith: 'Summer' in: notEmptyStack.
	
	expectedCollection := OrderedCollection new.

	self assert: newCollection = expectedCollection.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NM 6/10/2021 04:04:03'!
test07StackMustBeStackObject
	
	self 
		should: [ sentenceFinderByPrefix findSentencesWith: 'win' in: 'hola' ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix stackIsNotStackObjectErrorMessage ]
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NM 6/10/2021 14:38:23'!
test08FindDoesNotChangeOriginalStack
	
	
	|newStack stackIsCorrectlyOrdered|
	
	stackIsCorrectlyOrdered := true.
	newStack := notEmptyStack.
	sentenceFinderByPrefix findSentencesWith: 'win' in: notEmptyStack.
	
	[newStack isEmpty] whileFalse: [(notEmptyStack pop = newStack pop) ifFalse: [stackIsCorrectlyOrdered = false] ].
	
	self assert: notEmptyStack isEmpty.
	self assert: stackIsCorrectlyOrdered.
	

	
	
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'NM 6/10/2021 00:32:48'!
getLastElement

	^content last.! !


!OOStack methodsFor: 'functions' stamp: 'f 6/7/2021 00:08:09'!
isEmpty

	^content size = 0.! !

!OOStack methodsFor: 'functions' stamp: 'NM 6/9/2021 23:12:31'!
pop

	|top|
	top := self top.
	content removeLast.
	
	^top.! !

!OOStack methodsFor: 'functions' stamp: 'f 6/7/2021 00:17:18'!
push: aSomething

	^content addLast: aSomething.! !

!OOStack methodsFor: 'functions' stamp: 'f 6/7/2021 00:24:02'!
size

	^content size.! !

!OOStack methodsFor: 'functions' stamp: 'NM 6/10/2021 14:35:47'!
top
	
	^(StackContent allSubclasses detect:[:aClass | aClass canHandle: self size]) top: self.! !


!OOStack methodsFor: 'initialization' stamp: 'f 6/7/2021 00:00:10'!
initialize

	content := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'find' stamp: 'NM 6/10/2021 17:11:51'!
findSentencesWith: aPrefix in: aStack
	
	|collectionWithMatches secondaryStack|
	
	self checkPrefixValue: aPrefix andStack: aStack.
	
	collectionWithMatches := OrderedCollection new.
	secondaryStack  := OOStack new.
	
	self insertIn: collectionWithMatches elementsWhichBeginsWith: aPrefix from: aStack andPushItsAllElementsTo: secondaryStack.
	
	self popAllElementsFrom: secondaryStack andPushThemIn: aStack.
	
	^collectionWithMatches .
	
	
		

	
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'NM 6/10/2021 16:48:34'!
checkPrefixValue: aPrefix andStack: aStack

	(self prefixIsInvalid: aPrefix) ifTrue: [self error: self class prefixIsInvalidErrorMessage ].
	
	(aStack isKindOf: OOStack) ifFalse:[self error: self class stackIsNotStackObjectErrorMessage].
	
	(aStack isEmpty) ifTrue: [self error: OOStack stackEmptyErrorDescription ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'NM 6/10/2021 17:06:31'!
insertIn: aCollection elementsWhichBeginsWith: aPrefix from: aStack andPushItsAllElementsTo: anEmptyStack
	
	[aStack isEmpty] whileFalse: [|anElement| 
		anElement:= aStack pop.
		(anElement beginsWith: aPrefix) ifTrue: [aCollection addLast: anElement].
		anEmptyStack push: anElement ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'NM 6/10/2021 15:26:57'!
popAllElementsFrom: aNotEmptyStack andPushThemIn: anEmptyStack

	[aNotEmptyStack isEmpty] whileFalse: [anEmptyStack push: (aNotEmptyStack pop)].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'NM 6/10/2021 15:03:53'!
prefixIsInvalid: aPrefix

	^(aPrefix = '') or: [aPrefix includesSubString: ' '].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 02:38:26'!
prefixIsInvalidErrorMessage

	^'The prefix cannot be empty nor contain blank spaces'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 03:52:40'!
stackIsNotStackObjectErrorMessage

	^'The stack is not an stack object'.! !


!classDefinition: #StackContent category: 'Stack-Exercise'!
Object subclass: #StackContent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #EmptyStackContent category: 'Stack-Exercise'!
StackContent subclass: #EmptyStackContent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyStackContent class' category: 'Stack-Exercise'!
EmptyStackContent class
	instanceVariableNames: ''!

!EmptyStackContent class methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 00:36:50'!
canHandle: aStackSize

	^ aStackSize = 0.! !

!EmptyStackContent class methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 02:01:01'!
top: aStack

	^aStack error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #NotEmptyStackContent category: 'Stack-Exercise'!
StackContent subclass: #NotEmptyStackContent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyStackContent class' category: 'Stack-Exercise'!
NotEmptyStackContent class
	instanceVariableNames: ''!

!NotEmptyStackContent class methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 00:37:05'!
canHandle: aStackSize

	^ aStackSize > 0! !

!NotEmptyStackContent class methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 01:11:17'!
top: aStack

	^aStack getLastElement.
	! !
