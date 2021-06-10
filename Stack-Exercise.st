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

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 03:08:20'!
setUp
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	
	emptyStack := OOStack new.
	
	notEmptyStack := OOStack new.
	notEmptyStack push: 'winter is coming'.
	notEmptyStack push: 'winning is everything'.
	notEmptyStack push: 'The winds of Winter'.
	notEmptyStack push: 'Winter is here'.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 03:08:36'!
test01PrefixCannotBeEmpty
	
	self 
		should: [ sentenceFinderByPrefix findSentencesWith: '' in: emptyStack ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixIsInvalidErrorMessage ]
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 03:08:48'!
test02PrefixCannotContainABlankSpace
	
	self 
		should: [ sentenceFinderByPrefix findSentencesWith: 'Winter ' in: notEmptyStack  ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixIsInvalidErrorMessage ]
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 03:17:46'!
test03StackCannotBeEmpty
	
	self 
		should: [ sentenceFinderByPrefix findSentencesWith: 'Winter' in: emptyStack  ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: OOStack stackEmptyErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 03:47:20'!
test04PrefixWithOneAppearance

	|newCollection expectedCollection|
	
	newCollection  := sentenceFinderByPrefix findSentencesWith: 'Win' in: notEmptyStack.
	
	expectedCollection := OrderedCollection new.
	expectedCollection add: 'Winter is here'.
	
	self assert: newCollection = expectedCollection.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 03:45:58'!
test05PrefixWithMultipleAppearances

	|newCollection expectedCollection|
	
	newCollection  := sentenceFinderByPrefix findSentencesWith: 'win' in: notEmptyStack.
	
	expectedCollection := OrderedCollection new.
	expectedCollection add: 'winning is everything'.
	expectedCollection add: 'winter is coming'.
	
	self assert: newCollection = expectedCollection.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 03:48:40'!
test06PrefixWithNoAppearances

	|newCollection expectedCollection|
	
	newCollection  := sentenceFinderByPrefix findSentencesWith: 'Summer' in: notEmptyStack.
	
	expectedCollection := OrderedCollection new.

	self assert: newCollection = expectedCollection.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 04:04:03'!
test07StackMustBeStackObject
	
	self 
		should: [ sentenceFinderByPrefix findSentencesWith: 'win' in: 'hola' ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix stackIsNotStackObjectErrorMessage ]
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'a 6/10/2021 14:15:37'!
test08FindDoesNotChangeOriginalStack
	
	
	|newStack stackIsCorrectlyOrdered|
	
	stackIsCorrectlyOrdered := true.
	newStack := notEmptyStack.
	sentenceFinderByPrefix findSentencesWith: 'win' in: notEmptyStack.
	
	[newStack isEmpty] whileFalse: [(notEmptyStack pop = newStack pop) ifFalse: [stackIsCorrectlyOrdered = false] ].
	
	self assert: notEmptyStack isEmpty.
	self assert: stackIsCorrectlyOrdered.
	

	
	
	! !


!classDefinition: #Content category: 'Stack-Exercise'!
Object subclass: #Content
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #EmptyStackContent category: 'Stack-Exercise'!
Content subclass: #EmptyStackContent
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
Content subclass: #NotEmptyStackContent
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


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'NM 6/10/2021 00:32:48'!
getLastElement

	^content last.! !


!OOStack methodsFor: 'as yet unclassified' stamp: 'f 6/7/2021 00:00:10'!
initialize

	content := OrderedCollection new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'f 6/7/2021 00:08:09'!
isEmpty

	^content size = 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NM 6/9/2021 23:12:31'!
pop

	|top|
	top := self top.
	content removeLast.
	
	^top.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'f 6/7/2021 00:17:18'!
push: aSomething

	^content addLast: aSomething.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'f 6/7/2021 00:24:02'!
size

	^content size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 01:11:10'!
top
	
	^(Content allSubclasses detect:[:aClass | aClass canHandle: self size]) top: self.! !

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

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 02:42:25'!
PrefixIsInvalid: aPrefix

	^(aPrefix = '') or: [aPrefix includesSubString: ' '].! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'NM 6/10/2021 04:24:42'!
findSentencesWith: aPrefix in: aStack
	
	|newCollection secondaryStack|
	
	(self PrefixIsInvalid: aPrefix) ifTrue: [self error: self class prefixIsInvalidErrorMessage ].
	(aStack isKindOf: OOStack) ifFalse:[self error: self class stackIsNotStackObjectErrorMessage].
	(aStack isEmpty) ifTrue: [self error: OOStack stackEmptyErrorDescription ].
	
	newCollection := OrderedCollection new.
	secondaryStack  := OOStack new.
	[aStack isEmpty] whileFalse: [|anElement| 
		anElement:= aStack pop.
		(anElement beginsWith: aPrefix) ifTrue: [newCollection addLast: anElement].
		secondaryStack push: anElement ].
	
		[secondaryStack isEmpty] whileFalse: [aStack push: secondaryStack pop].

	^newCollection.
	
	
		

	
	! !

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
