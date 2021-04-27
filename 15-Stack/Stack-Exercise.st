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

!OOStackTest methodsFor: 'test' stamp: 'NR 4/22/2021 17:25:26'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstObject'.
	secondPushedObject := 'secondObject'.
	
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

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 17:46:47'!
test01EmptyStack

	| stack prefix |
	
	stack := OOStack new.
	prefix := 'pepe'.
	
	self assert: (stack find: prefix = OrderedCollection new).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 17:49:58'!
test02NoCoincidences

	| stack prefix |
	
	stack := OOStack new.
	stack push: 'something'.
	
	prefix := 'pepe'.
	
	self assert: (stack find: prefix = OrderedCollection new).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 17:53:39'!
test03UniquePrefixCoincidence

	| stack prefix result coincidence |
	
	stack := OOStack new.
	
	coincidence := 'something'.
	stack push: coincidence.
	
	prefix := 'some'.
	
	result := OrderedCollection new.
	result add: coincidence.
	
	self assert: (stack find: prefix = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 17:54:04'!
test04UniqueFullWordCoincidence

	| stack prefix result coincidence |
	
	stack := OOStack new.
	
	coincidence := 'something'.
	stack push: coincidence.
	
	prefix := 'something'.
	
	result := OrderedCollection new.
	result add: coincidence.
	
	self assert: (stack find: prefix = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 17:54:43'!
test05NoCoincidenceCaseSensitivePrefix

	| stack prefix result coincidence |
	
	stack := OOStack new.
	
	coincidence := 'something'.
	stack push: coincidence.
	
	prefix := 'Something'.
	
	result := OrderedCollection new.
	result add: coincidence.
	
	self assert: (stack find: prefix = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 18:03:16'!
test06CanNotFindEmptyPrefix

	| stack prefix |
	
	stack := OOStack new.
	
	prefix := ''.

		self
		should: [ SentenceFinderByPrefix find: prefix in: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription]

	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 18:03:59'!
test07CanNotFindPrefixWithSpaces

	| stack prefix |
	
	stack := OOStack new.
	
	prefix := 'some thing'.

		self
		should: [ SentenceFinderByPrefix find: prefix in: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix spacePrefixErrorDescription]

	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 18:08:11'!
test08MultipleCoincidences

	| stack prefix result coincidence1 coincidence2 |
	
	stack := OOStack new.
	
	coincidence1 := 'something'.
	coincidence2 := 'somewhere'.
	
	stack push: 'me gustan lo jueguito'.
	stack push: coincidence1.
	stack push: 'casa'.
	stack push: coincidence2.
	
	prefix := 'some'.
	
	result := OrderedCollection new.
	result add: coincidence1.
	result add: coincidence2.
	
	self assert: (stack find: prefix = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 18:10:20'!
test09CoincidenceInMiddleOfSentenceNotFound

	| stack prefix result coincidence |
	
	stack := OOStack new.
	
	coincidence := 'something'.
	
	stack push: 'me gustan lo jueguito'.
	stack push: coincidence.
	stack push: 'casa'.
	stack push: 'he is somewhere'.
	
	prefix := 'some'.
	
	result := OrderedCollection new.
	result add: coincidence.
	
	self assert: (stack find: prefix = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 18:14:57'!
test10checkStackIntegrityWithCoincidence

	| stack prefix result coincidence originalStack |
	
	stack := OOStack new.
	
	coincidence := 'something'.
	
	stack push: 'me gustan lo jueguito'.
	stack push: coincidence.
	stack push: 'casa'.
	stack push: 'he is somewhere'.
	
	originalStack := stack copy.
		
	prefix := 'some'.
	stack find: prefix.
		
	self assert: (originalStack = stack).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'MS 4/26/2021 18:16:10'!
test11checkStackIntegrityWithNoCoincidences

	| stack prefix result coincidence originalStack |
	
	stack := OOStack new.
	
	stack push: 'me gustan lo jueguito'.
	stack push: 'pepe'.
	stack push: 'casa'.
	stack push: 'he is somewhere'.
	
	originalStack := stack copy.
		
	prefix := 'some'.
	stack find: prefix.
		
	self assert: (originalStack = stack).
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'memory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'ENC 4/25/2021 12:58:34'!
initializeNew

	memory := OrderedCollection new.
	memory addFirst: Base new.! !



!OOStack methodsFor: 'operations' stamp: 'ENC 4/25/2021 13:19:02'!
isEmpty

	"
		Tenemos dos opciones. O verificamos que el elemento de la pila sea la Base o vemos que size = 1. ¿Qué nos gusta más?
	"

	^ memory first isKindOf: Base.! !

!OOStack methodsFor: 'operations' stamp: 'MS 4/26/2021 17:36:11'!
pop
	|top|
	top := self top.
	memory removeFirst	.
	
	^ top! !

!OOStack methodsFor: 'operations' stamp: 'ENC 4/25/2021 13:02:56'!
push: anElement	

	memory addFirst: (RegularSlot with: anElement). ! !

!OOStack methodsFor: 'operations' stamp: 'ENC 4/25/2021 13:06:15'!
size

	^ memory size - 1.! !

!OOStack methodsFor: 'operations' stamp: 'ENC 4/25/2021 12:57:35'!
top

	^ memory first content.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 4/22/2021 17:22:41'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!!!!!'! !


!OOStack class methodsFor: 'instance creation' stamp: 'ENC 4/25/2021 12:58:46'!
new

	^ OOStack basicNew initializeNew.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'MS 4/26/2021 18:21:02'!
emptyPrefixErrorDescription
	^ 'Prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'MS 4/26/2021 18:20:54'!
spacePrefixErrorDescription
	^ 'Prefix cannot have spaces'! !


!classDefinition: #StackSlot category: 'Stack-Exercise'!
Object subclass: #StackSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackSlot methodsFor: 'operations' stamp: 'ENC 4/24/2021 22:31:18'!
content

	self subclassResponsibility.! !


!classDefinition: #Base category: 'Stack-Exercise'!
StackSlot subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'operations' stamp: 'ENC 4/24/2021 22:30:39'!
content

	^ self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #RegularSlot category: 'Stack-Exercise'!
StackSlot subclass: #RegularSlot
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RegularSlot methodsFor: 'initialization' stamp: 'ENC 4/25/2021 13:08:17'!
initializeWith: aContent

	content := aContent. ! !


!RegularSlot methodsFor: 'operations' stamp: 'ENC 4/24/2021 22:30:51'!
content

	^ content.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RegularSlot class' category: 'Stack-Exercise'!
RegularSlot class
	instanceVariableNames: ''!

!RegularSlot class methodsFor: 'as yet unclassified' stamp: 'ENC 4/25/2021 13:07:52'!
with: aContent

	^ self new initializeWith: aContent.! !
