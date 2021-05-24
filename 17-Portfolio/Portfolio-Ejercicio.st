!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'depositOf100 depositOf150'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:50:26'!
setUp

	depositOf100 := Deposit for: 100.
	depositOf150 := Deposit for: 150.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/17/2021 21:51:06'!
test01

	| portfolio |
	
	portfolio := Portfolio create.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:50:42'!
test02

	| portfolio account |
	
	portfolio := Portfolio create.
	
	account := ReceptiveAccount new.	
	account register: depositOf100 .
	portfolio register: account.
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:51:00'!
test03

	| portfolio accountA accountB |
	
	portfolio := Portfolio create.
	
	accountA := ReceptiveAccount new.	
	accountA register: depositOf100.
	portfolio register: accountA.

	accountB := ReceptiveAccount new.	
	Deposit register: 150 on: accountB.
	portfolio register: accountB.	
	
	self assert: 250 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:50:12'!
test04

	| portfolio |
	
	portfolio := Portfolio create.
	
	self deny: (portfolio hasRegistered: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:50:12'!
test05

	| portfolio account |
	
	portfolio := Portfolio create.
	
	account := ReceptiveAccount new.	
	account register: depositOf100.
	portfolio register: account.
	
	self assert: (portfolio hasRegistered: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/19/2021 23:38:32'!
test06

	| portfolio |
	
	portfolio := Portfolio create.
	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:50:12'!
test07

	| portfolio account |
	
	portfolio := Portfolio create.
	
	account := ReceptiveAccount new.	
	account register: depositOf100.
	portfolio register: account.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:35:06'!
test08

	| portfolio subportfolio account |
	
	portfolio := Portfolio create.
	
	subportfolio := Portfolio create.
	account := ReceptiveAccount new.	
	Deposit register: 100 on: account.
	subportfolio register: account.
	
	portfolio register: subportfolio.
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:50:12'!
test09

	| portfolio subportfolio account |
	
	portfolio := Portfolio create.
	
	subportfolio := Portfolio create.
	account := ReceptiveAccount new.	
	account register: depositOf100.
	subportfolio register: account.
	
	portfolio register: subportfolio.
	
	self assert: (portfolio hasRegistered: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:50:12'!
test10

	| portfolio subportfolio account |
	
	portfolio := Portfolio create.
	
	subportfolio := Portfolio create.
	account := ReceptiveAccount new.	
	account register: depositOf100.
	subportfolio register: account.
	
	portfolio register: subportfolio.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:50:12'!
test11

	| portfolio account |
	
	portfolio := Portfolio create.
	
	account := ReceptiveAccount new.	
	account register: depositOf100.
	portfolio register: account.
	
	self
		should: [ portfolio register: account. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio errorAlreadyRegistered ].! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'ENC 5/17/2021 22:00:29'!
xxx: partialBalance

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'ENC 5/17/2021 22:00:47'!
xxx: partialBalance

	^ partialBalance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'ENC 5/17/2021 22:00:54'!
xxx: partialBalance

	^ partialBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'xxx'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'ENC 5/20/2021 20:32:57'!
balance
	
	^ xxx sum: [ :anXXX | anXXX balance ] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'initialization' stamp: 'ENC 5/20/2021 20:32:33'!
initialize
	
	xxx := 	OrderedCollection new.! !


!Portfolio methodsFor: 'xxxs' stamp: 'ENC 5/20/2021 21:00:29'!
hasAssociated: anYYY
	
	xxx detect: [ :anXXX | anXXX hasAssociated: anYYY ] ifFound: [ ^true ] ifNone: [ ^false ].! !

!Portfolio methodsFor: 'xxxs' stamp: 'ENC 5/20/2021 20:31:48'!
hasRegistered: aTransaction
	
	xxx detect: [ :anXXX | anXXX hasRegistered: aTransaction ] 
	ifFound: [ :foundTransaction | ^ true ] 
	ifNone: [ ^false ].! !

!Portfolio methodsFor: 'xxxs' stamp: 'ENC 5/20/2021 20:56:26'!
register: anXXX "es una cuenta o un portfolio"

	xxx add: anXXX.! !

!Portfolio methodsFor: 'xxxs' stamp: 'ENC 5/20/2021 20:32:11'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.	
	
	xxx do: [ :anXXX | transactions := transactions, anXXX transactions ].
	
	^ transactions .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'ENC 5/20/2021 20:47:57'!
errorAlreadyRegistered

	^ 'Ya se encuentra registrado en el portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'ENC 5/17/2021 21:49:36'!
create

	^ self new initialize.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ENC 5/17/2021 22:00:09'!
balance

	| partialBalance |
	
	partialBalance := 0.
	
	transactions do: [ :aTransaction | 
		partialBalance := aTransaction xxx: partialBalance.
	 ].
	
	^ partialBalance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'ENC 5/20/2021 21:01:23'!
hasAssociated: anYYY

	^ self = anYYY ! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
