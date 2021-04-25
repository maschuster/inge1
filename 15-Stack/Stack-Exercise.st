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


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'memory stacker'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'ENC 4/25/2021 12:58:34'!
initializeNew

	memory := OrderedCollection new.
	memory addFirst: Base new.! !


!OOStack methodsFor: 'operations - private' stamp: 'ENC 4/25/2021 13:02:09'!
popBaseSlot

	^ self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'operations - private' stamp: 'ENC 4/25/2021 13:01:47'!
popRegularSlot

	^ memory removeFirst content.! !


!OOStack methodsFor: 'operations' stamp: 'ENC 4/25/2021 13:19:02'!
isEmpty

	"
		Tenemos dos opciones. O verificamos que el elemento de la pila sea la Base o vemos que size = 1. ¿Qué nos gusta más?
	"

	^ memory first isKindOf: Base.! !

!OOStack methodsFor: 'operations' stamp: 'ENC 4/25/2021 13:13:37'!
pop

	^ memory first poppedFrom: self.! !

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


!classDefinition: #StackSlot category: 'Stack-Exercise'!
Object subclass: #StackSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackSlot methodsFor: 'operations' stamp: 'ENC 4/24/2021 22:31:18'!
content

	self subclassResponsibility.! !

!StackSlot methodsFor: 'operations' stamp: 'ENC 4/25/2021 13:15:59'!
poppedFrom: aStack

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

!Base methodsFor: 'operations' stamp: 'ENC 4/25/2021 13:04:25'!
poppedFrom: aStack

	^ aStack popBaseSlot.! !


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

!RegularSlot methodsFor: 'operations' stamp: 'ENC 4/25/2021 13:04:51'!
poppedFrom: aStack

	^ aStack popRegularSlot.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RegularSlot class' category: 'Stack-Exercise'!
RegularSlot class
	instanceVariableNames: ''!

!RegularSlot class methodsFor: 'as yet unclassified' stamp: 'ENC 4/25/2021 13:07:52'!
with: aContent

	^ self new initializeWith: aContent.! !
