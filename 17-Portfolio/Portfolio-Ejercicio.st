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

!PortfolioTest methodsFor: 'testing' stamp: 'MS 5/23/2021 23:39:20'!
test12

	| portfolio subportfolio account |
	
	portfolio := Portfolio create.
	
	subportfolio := Portfolio create.
	account := ReceptiveAccount new.	
	account register: depositOf100.
	subportfolio register: account.
	
	portfolio register: subportfolio.
	
	
	self
		should: [ portfolio register: account. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio errorAlreadyRegistered ].! !

!PortfolioTest methodsFor: 'testing' stamp: 'MS 5/24/2021 00:06:25'!
test13

	| portfolio subportfolio account subsubportfolio |
	
	portfolio := Portfolio create.
	
	subportfolio := Portfolio create.
	subsubportfolio := Portfolio create.
	
	account := ReceptiveAccount new.	
	account register: depositOf100.
	subsubportfolio register: account.
	subportfolio register: subsubportfolio.
	
	portfolio register: subportfolio.
	
	
	self
		should: [ portfolio register: subsubportfolio. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio errorAlreadyRegistered ].! !

!PortfolioTest methodsFor: 'testing' stamp: 'MS 5/24/2021 00:09:05'!
test14

	| portfolio subportfolio account |
	
	portfolio := Portfolio create.
	
	subportfolio := Portfolio create.
	
	account := ReceptiveAccount new.	
	account register: depositOf100.
	portfolio register: account.
	
	portfolio register: subportfolio.
	
	
	self
		should: [ subportfolio register: account. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio errorAlreadyRegistered ].! !

!PortfolioTest methodsFor: 'testing' stamp: 'MS 5/24/2021 16:03:13'!
test15

	| portfolio account subportfolioA subportfolioB |
	
	portfolio := Portfolio create.
	subportfolioA := Portfolio create.
	subportfolioB := Portfolio create.
	account := ReceptiveAccount new.	
	
	account register: depositOf100.
	subportfolioA register: account.
	subportfolioB register: account.
	portfolio register: subportfolioA .
	
	
	self
		should: [ portfolio register: subportfolioB. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio errorAlreadyRegistered ].! !

!PortfolioTest methodsFor: 'testing' stamp: 'MS 5/24/2021 16:54:55'!
test16

	| subportfolio account portfolioA portfolioB |
	
	subportfolio := Portfolio create.
	portfolioA := Portfolio create.
	portfolioB := Portfolio create.
	account := ReceptiveAccount new.	
	
	account register: depositOf100.
	portfolioA register: subportfolio.
	portfolioA register: account.
	portfolioB register: subportfolio.
	
	
	self
		should: [ subportfolio register: account. ]
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


!classDefinition: #FinantialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinantialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinantialAsset methodsFor: 'balance' stamp: 'MS 5/23/2021 23:32:12'!
balance
	self subclassResponsibility ! !


!FinantialAsset methodsFor: 'initialization' stamp: 'MS 5/23/2021 23:33:16'!
initialize
	self subclassResponsibility ! !

!FinantialAsset methodsFor: 'initialization' stamp: 'MS 5/24/2021 00:40:21'!
registerAsParent: aPortfolio
	self subclassResponsibility ! !


!FinantialAsset methodsFor: 'finantial assets' stamp: 'MS 5/23/2021 23:32:50'!
hasAssociated: aFinantialAsset
	self subclassResponsibility ! !

!FinantialAsset methodsFor: 'finantial assets' stamp: 'MS 5/23/2021 23:33:05'!
hasRegistered: aTransaction
	self subclassResponsibility ! !

!FinantialAsset methodsFor: 'finantial assets' stamp: 'MS 5/23/2021 23:33:27'!
register: aFinantialAsset
	self subclassResponsibility ! !

!FinantialAsset methodsFor: 'finantial assets' stamp: 'MS 5/23/2021 23:33:34'!
transactions
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinantialAsset subclass: #Portfolio
	instanceVariableNames: 'finantialAssets state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'MS 5/23/2021 23:17:21'!
balance
	
	^ finantialAssets sum: [ :aFinantialAsset | aFinantialAsset balance ] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'initialization' stamp: 'MS 5/24/2021 00:18:25'!
initialize
	
	finantialAssets := 	OrderedCollection new.
	state := PortfolioStateRoot new.! !

!Portfolio methodsFor: 'initialization' stamp: 'MS 5/24/2021 17:06:50'!
registerAsParent: aPortfolio
	state register: aPortfolio asNewParentOf: self.! !

!Portfolio methodsFor: 'initialization' stamp: 'MS 5/24/2021 17:05:23'!
subportfolioOf: aParentPortfolio
	state := PortfolioStateSubPortfolio withParent: aParentPortfolio.
	! !


!Portfolio methodsFor: 'finantial assets - private' stamp: 'MS 5/24/2021 16:58:26'!
hasAssociated: aFinantialAsset in: parents

	parents do: [ :aParent | (aParent hasParentAssociatedWith: aFinantialAsset) ifTrue: [^true]].
	
	^false
	! !

!Portfolio methodsFor: 'finantial assets - private' stamp: 'MS 5/24/2021 15:48:03'!
hasParentAssociatedWith: aFinantialAsset

	^ state parentOf: self hasAssociated: aFinantialAsset.! !


!Portfolio methodsFor: 'finantial assets' stamp: 'MS 5/24/2021 16:49:48'!
checkInnerFinantialAssetsAssociatedWith: aPortfolio
	
	^ finantialAssets do: [ :aFinantialAsset | aPortfolio hasAssociated: aFinantialAsset].! !

!Portfolio methodsFor: 'finantial assets' stamp: 'MS 5/24/2021 16:49:21'!
hasAssociated: anotherFinantialAsset

	anotherFinantialAsset checkInnerFinantialAssetsAssociatedWith: self.
	
	(finantialAssets includes: anotherFinantialAsset) ifTrue: [^ self error: self class errorAlreadyRegistered ].
	
	finantialAssets detect: [ :aFinantialAsset | aFinantialAsset hasAssociated: anotherFinantialAsset ] ifFound: [ :foundAsset | ^ true ] ifNone: [ ^false ].! !

!Portfolio methodsFor: 'finantial assets' stamp: 'MS 5/23/2021 23:18:09'!
hasRegistered: aTransaction
	
	finantialAssets detect: [ :aFinantialAsset | aFinantialAsset hasRegistered: aTransaction ] 
	ifFound: [ :foundTransaction | ^ true ] 
	ifNone: [ ^false ].! !

!Portfolio methodsFor: 'finantial assets' stamp: 'MS 5/24/2021 16:50:17'!
register: aFinantialAsset 

	state parentOf: self hasAssociated: aFinantialAsset.
	
	aFinantialAsset registerAsParent: self.
	finantialAssets add: aFinantialAsset.! !

!Portfolio methodsFor: 'finantial assets' stamp: 'MS 5/23/2021 23:18:26'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.	
	
	finantialAssets do: [ :aFinantialAsset | transactions := transactions, aFinantialAsset transactions ].
	
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
FinantialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MS 5/24/2021 00:40:11'!
registerAsParent: aPortfolio
! !


!ReceptiveAccount methodsFor: 'finantial assets' stamp: 'MS 5/24/2021 16:49:56'!
checkInnerFinantialAssetsAssociatedWith: aPortfolio! !

!ReceptiveAccount methodsFor: 'finantial assets' stamp: 'MS 5/24/2021 00:00:01'!
hasAssociated: aReceptiveAccount

	^ self = aReceptiveAccount ! !

!ReceptiveAccount methodsFor: 'finantial assets' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'finantial assets' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'finantial assets' stamp: 'HernanWilkinson 7/13/2011 18:37'!
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


!classDefinition: #PortfolioState category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioState methodsFor: 'as yet unclassified' stamp: 'MS 5/24/2021 00:55:40'!
parentOf: aPortfolio hasAssociated: aFinantialAsset

	self subclassResponsibility ! !


!classDefinition: #PortfolioStateRoot category: 'Portfolio-Ejercicio'!
PortfolioState subclass: #PortfolioStateRoot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioStateRoot methodsFor: 'as yet unclassified' stamp: 'MS 5/24/2021 00:44:14'!
parentOf: aPortfolio hasAssociated: aFinantialAsset

	^ aPortfolio hasAssociated: aFinantialAsset.! !

!PortfolioStateRoot methodsFor: 'as yet unclassified' stamp: 'MS 5/24/2021 17:04:46'!
register: aParentPortfolio asNewParentOf: aPortfolio
	aPortfolio subportfolioOf: aParentPortfolio! !


!classDefinition: #PortfolioStateSubPortfolio category: 'Portfolio-Ejercicio'!
PortfolioState subclass: #PortfolioStateSubPortfolio
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioStateSubPortfolio methodsFor: 'initialization' stamp: 'MS 5/24/2021 16:55:51'!
initializeWithParent: aPortfolio

	parents := OrderedCollection new.
	parents add: aPortfolio.! !


!PortfolioStateSubPortfolio methodsFor: 'as yet unclassified' stamp: 'MS 5/24/2021 16:55:30'!
parentOf: aPortfolio hasAssociated: aFinantialAsset

	^ aPortfolio hasAssociated: aFinantialAsset in: parents.! !

!PortfolioStateSubPortfolio methodsFor: 'as yet unclassified' stamp: 'MS 5/24/2021 17:06:19'!
register: aParentPortfolio asNewParentOf: aPortfolio
	parents add: aParentPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStateSubPortfolio class' category: 'Portfolio-Ejercicio'!
PortfolioStateSubPortfolio class
	instanceVariableNames: ''!

!PortfolioStateSubPortfolio class methodsFor: 'as yet unclassified' stamp: 'MS 5/24/2021 15:58:02'!
withParent: aPortfolio
	^ self new initializeWithParent: aPortfolio.! !
