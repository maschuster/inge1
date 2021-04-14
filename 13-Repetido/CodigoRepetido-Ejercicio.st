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

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 18:31:34'!
do: anAction inLessThan: aTimeThresholdInMiliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning | 
		
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
       anAction value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aTimeThresholdInMiliseconds! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 18:29:30'!
newCustomerBookWith: aCustomer

	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomer.
	
	^ customerBook.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 23:41:34'!
on: customerBook checkExpectedNumberOfCustomersWith: aNumberOfCustomersSuspended

	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: aNumberOfCustomersSuspended equals: customerBook numberOfSuspendedCustomers.
	self assert: aNumberOfCustomersSuspended equals: customerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 23:28:57'!
on: customerBook try: anAction withExpected: error

	[ anAction value.
	self fail ]
		on: error 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 18:35:47'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |
	
	customerBook := CustomerBook new.
	self do: [ customerBook addCustomerNamed: 'John Lennon' ] inLessThan: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 18:35:41'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWith: paulMcCartney.
	  
	self do: [ customerBook removeCustomerNamed: paulMcCartney ] inLessThan: 100*millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 23:31:51'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWith: johnLennon.
	
	self  on: customerBook 
		try: [customerBook removeCustomerNamed: 'Paul McCartney']  
		withExpected: NotFound.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 23:42:11'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self on: customerBook checkExpectedNumberOfCustomersWith: 1. 
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 23:41:51'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self on: customerBook checkExpectedNumberOfCustomersWith: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 23:30:15'!
test07CanNotSuspendAnInvalidCustomer	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWith: johnLennon.
	
	self  on: customerBook 
		try: [customerBook suspendCustomerNamed: 'George Harrison'] 
		withExpected: CantSuspend. ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ENC 4/13/2021 23:30:59'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWith: johnLennon.
	
	customerBook suspendCustomerNamed: johnLennon.
	
	self  on: customerBook 
		try: [customerBook suspendCustomerNamed: johnLennon] 
		withExpected: CantSuspend.
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'ENC 4/13/2021 23:51:27'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ENC 4/13/2021 23:43:59'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ENC 4/14/2021 00:00:02'!
removeCustomer: aName from: aGroupOfCustomers
	
	1 to: aGroupOfCustomers size do: 
	[ :index |
		aName = (aGroupOfCustomers at: index)
			ifTrue: [
				aGroupOfCustomers removeAt: index.
				^ aName 
			] 
	]! !

!CustomerBook methodsFor: 'customer management' stamp: 'ENC 4/14/2021 00:03:50'!
removeCustomerNamed: aName 
 
	(self includesCustomerNamed: aName) 
		ifTrue: [
			self removeCustomer: aName from: active. 
			self removeCustomer: aName from: suspended.
		] 
		ifFalse: [ ^ NotFound signal ]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
