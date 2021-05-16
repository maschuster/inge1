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
	instanceVariableNames: 'emptyStack emptySentenceFinder sentenceFinder sentenceFinderStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing - private' stamp: 'MS 4/29/2021 15:12:50'!
assert: aStack containsSameElementsThan: anotherStack

	(aStack size) timesRepeat: [
		self assert: (aStack pop = anotherStack pop).
	].! !

!SentenceFinderByPrefixTest methodsFor: 'testing - private' stamp: 'MS 4/29/2021 15:12:28'!
assert: aStack hasTheSameSizeThan: anotherStack

	self assert: (aStack size = anotherStack size).	! !

!SentenceFinderByPrefixTest methodsFor: 'testing - private' stamp: 'MS 4/29/2021 15:17:38'!
assert: aStack isEssentiallyEqualTo: anotherStack

	self assert: aStack hasTheSameSizeThan: anotherStack.
	self assert: aStack containsSameElementsThan: anotherStack.! !

!SentenceFinderByPrefixTest methodsFor: 'testing - private' stamp: 'ENC 4/27/2021 22:52:13'!
generateTestStack

	| newStack |
	
	newStack := OOStack new.
	newStack push: 'something'.
	newStack push: 'elsewhere'.
	newStack push: 'else'.
	newStack push: 'winter'.
	newStack push: 'is not winter'.	
	
	^ newStack! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 22:46:57'!
setUp

	emptyStack := OOStack new.
	sentenceFinderStack := self generateTestStack.
		
	emptySentenceFinder := SentenceFinderByPrefix with: emptyStack.
	sentenceFinder := SentenceFinderByPrefix with: sentenceFinderStack.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 22:53:13'!
test01NoMatchesInEmptyStackSentenceFinder

	| prefix |
	
	prefix := 'pepe'.
	
	self assert: ((emptySentenceFinder find: prefix) = OrderedCollection new).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 22:53:31'!
test02NoMatchesInNotEmptySentenceFinder

	| prefix |
	
	prefix := 'pepe'.
	
	self assert: ((sentenceFinder find: prefix) = OrderedCollection new).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 23:04:06'!
test03OnePrefixMatchInNotEmptySentenceFinder

	| prefix result |
	
	prefix := 'some'.
	
	result := OrderedCollection new.
	result add: 'something'.
	
	self assert: ((sentenceFinder find: prefix) = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 23:04:15'!
test04OneFullMatchInNotEmptySentenceFinder

	| prefix result |
	
	prefix := 'something'.
	
	result := OrderedCollection new.
	result add: 'something'.
	
	self assert: ((sentenceFinder find: prefix) = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 23:05:12'!
test05NoMatchCaseSensitivePrefix

	| prefix result |
	
	prefix := 'Something'.
	
	result := OrderedCollection new.
	
	self assert: ((sentenceFinder find: prefix) = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 22:30:38'!
test06CanNotFindEmptyPrefix

	| prefix |
	
	prefix := ''.

	self
		should: [ sentenceFinder find: prefix]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription]

	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 22:30:43'!
test07CanNotFindPrefixWithSpaces

	| prefix |
	
	prefix := 'some thing'.

	self
		should: [ sentenceFinder find: prefix]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix spacePrefixErrorDescription]

	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 23:05:43'!
test08MultiplesMatchesInNotEmptySentenceFinder

	| prefix result |
	
	prefix := 'else'.
	
	result := OrderedCollection new.
	result add: 'else'.
	result add: 'elsewhere'.
	
	self assert: ((sentenceFinder find: prefix) = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 23:06:42'!
test09NoMatchMiddleOfSentenceSubstring

	| prefix result |
	
	prefix := 'wint'.
	
	result := OrderedCollection new.
	result add: 'winter'.
	
	self assert: ((sentenceFinder find: prefix) = result).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 23:07:18'!
test10CheckStackIntegrityWithMatches

	|  prefix anStack originalStack testSentenceFinder |
	
	originalStack := self generateTestStack.
	anStack := self generateTestStack.
	testSentenceFinder := SentenceFinderByPrefix with: anStack.
	
	prefix := 'some'.
	testSentenceFinder find: prefix.
		
	self assert: originalStack isEssentiallyEqualTo: anStack.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ENC 4/27/2021 23:07:38'!
test11CheckStackIntegrityWithNoMatches

	|  prefix anStack originalStack testSentenceFinder |
	
	originalStack := self generateTestStack.
	anStack := self generateTestStack.
	testSentenceFinder := SentenceFinderByPrefix with: anStack.
	
	prefix := 'pepe'.
	testSentenceFinder find: prefix.
		
	self assert: originalStack isEssentiallyEqualTo: anStack.
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


!OOStack methodsFor: 'operations' stamp: 'ENC 4/27/2021 23:09:42'!
isEmpty

	^ memory first isKindOf: Base.! !

!OOStack methodsFor: 'operations' stamp: 'ENC 4/27/2021 23:09:48'!
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
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'ENC 4/27/2021 23:08:29'!
initializeWith: aStack

	stack := aStack
	
	! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'MS 4/29/2021 15:07:25'!
find: aPrefix

	| coincidences auxStack |
	
	(aPrefix = '') ifTrue: [^ self error: self class emptyPrefixErrorDescription ].
	(aPrefix includesSubString: ' ') ifTrue: [^ self error: self class spacePrefixErrorDescription ].
		
	coincidences := OrderedCollection new.
	auxStack := OOStack new.
		
	(stack size) timesRepeat: [ | sentence |
		sentence := stack pop.
		(sentence beginsWith: aPrefix) ifTrue: [coincidences add: sentence].
		auxStack push: sentence.
		].
	
	(auxStack size) timesRepeat: [
		stack push: (auxStack pop)
		].
	
	^coincidences! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'ENC 4/27/2021 23:08:23'!
emptyPrefixErrorDescription

	^ 'Prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'ENC 4/27/2021 23:08:20'!
spacePrefixErrorDescription

	^ 'Prefix cannot have spaces'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'ENC 4/27/2021 23:08:12'!
with: aStack

	^ self new initializeWith: aStack.! !


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

!RegularSlot class methodsFor: 'instance creation' stamp: 'ENC 4/25/2021 13:07:52'!
with: aContent

	^ self new initializeWith: aContent.! !
