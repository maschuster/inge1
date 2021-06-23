!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InnerUserInterfaceTest category: 'TusLibros'!
TestCase subclass: #InnerUserInterfaceTest
	instanceVariableNames: 'credentialValidatorValid credentialValidatorInvalid testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/22/2021 23:44:50'!
setUp

	credentialValidatorValid := CredentialValidatorSimulatorValidCredentials new.
	credentialValidatorInvalid := CredentialValidatorSimulatorInvalidCredentials new.
	testObjectsFactory := StoreTestObjectsFactory new.! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/22/2021 23:45:44'!
test01cannotCreateACartWithInvalidCredentials

	| interface userID userPassword catalog time |

	catalog := testObjectsFactory defaultCatalog.
	time := testObjectsFactory dateTimeToday.
	
	interface := InnerUserInterface with: credentialValidatorInvalid acceptingItemsOf: catalog.
	userID := 'invalidUser'.
	userPassword := 'password'.

	self 
		should: [ interface createCartForUser: userID withPassword: userPassword at: time] 
		raise: Error 
		withMessageText: CredentialValidatorSimulator errorInvalidUsernameOrPassword.! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/22/2021 23:46:09'!
test02createdCartWithValidCredentialsIsEmpty

	| interface userID userPassword cartID catalog time |

	catalog := testObjectsFactory defaultCatalog.
	time := testObjectsFactory dateTimeToday.
	
	interface := InnerUserInterface with: credentialValidatorValid acceptingItemsOf: catalog.
	userID := 'validUser'.
	userPassword := 'validPassword'.

	cartID := interface createCartForUser: userID withPassword: userPassword at: time.
	
	self assert: (interface listCart: cartID at: time) isEmpty.! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/22/2021 23:49:12'!
test03addingAnItemInCartIsListed

	| interface userID userPassword cartID isbn catalog time |

	catalog := testObjectsFactory defaultCatalog.
	time := testObjectsFactory dateTimeToday.
	
	interface := InnerUserInterface with: credentialValidatorValid acceptingItemsOf: catalog.
	userID := 'validUser'.
	userPassword := 'validPassword'.

	cartID := interface createCartForUser: userID withPassword: userPassword at: time.
	
	isbn := testObjectsFactory itemSellByTheStore.
	
	interface add: 1 of: isbn toCart: cartID at: time.
	
	self assert: ((interface listCart: cartID at: time) size) equals: 1.
	self assert: (interface listCart: cartID at: time) includes: isbn.
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/22/2021 23:49:34'!
test04cannotAddItemsToInvalidCart

	| interface catalog time |

	catalog := testObjectsFactory defaultCatalog.
	time := testObjectsFactory dateTimeToday.
	
	interface := InnerUserInterface with: credentialValidatorValid acceptingItemsOf: catalog.
	
	self should: [interface add: 1 of: 'isbn' toCart: 1 at: time]
	 raise: Error
	withMessageText: InnerUserInterface invalidCartId.
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/22/2021 23:49:51'!
test05cannotListItemsOfInvalidCart

	| interface catalog time |

	catalog := testObjectsFactory defaultCatalog.
	time := testObjectsFactory dateTimeToday.
	
	interface := InnerUserInterface with: credentialValidatorValid acceptingItemsOf: catalog.
	
	self should: [interface listCart: 1 at: time]
	 raise: Error
	withMessageText: InnerUserInterface invalidCartId.
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/23/2021 00:01:00'!
test06cannotAddItemsToExpiredCart

	| interface catalog time cartID userID userPassword creationTime isbn |

	catalog := testObjectsFactory defaultCatalog.
	creationTime := testObjectsFactory dateTimeToday.
	time := testObjectsFactory dateTimeTodayAfter30Minutes .
	
	interface := InnerUserInterface with: credentialValidatorValid acceptingItemsOf: catalog.
	
	userID := 'validUser'.
	userPassword := 'validPassword'.

	cartID := interface createCartForUser: userID withPassword: userPassword at: creationTime.
	
	isbn := testObjectsFactory itemSellByTheStore.
	
	self should: [interface add: 1 of: isbn toCart: cartID at: time.]
	 raise: Error
	withMessageText: InnerUserInterface invalidCartId.
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/23/2021 00:01:40'!
test07cannotListItemsOfExpiredCart

	| interface catalog time cartID userID userPassword creationTime |

	catalog := testObjectsFactory defaultCatalog.
	creationTime := testObjectsFactory dateTimeToday.
	time := testObjectsFactory dateTimeTodayAfter30Minutes .
	
	interface := InnerUserInterface with: credentialValidatorValid acceptingItemsOf: catalog.
	
	userID := 'validUser'.
	userPassword := 'validPassword'.

	cartID := interface createCartForUser: userID withPassword: userPassword at: creationTime.
	
	self should: [interface listCart: cartID at: time]
	 raise: Error
	withMessageText: InnerUserInterface invalidCartId.
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/23/2021 01:12:02'!
test08cannotCheckoutACartWithInvalidCard

	| interface catalog time cartID userID userPassword |

	catalog := testObjectsFactory defaultCatalog.
	time := testObjectsFactory dateTimeToday.

	
	interface := InnerUserInterface with: credentialValidatorValid acceptingItemsOf: catalog.
	
	userID := 'validUser'.
	userPassword := 'validPassword'.

	cartID := interface createCartForUser: userID withPassword: userPassword at: time.
	
	self should: [interface checkout: cartID at: time withCard: 0 from: '' expiringOn: '']
	 raise: Error
	withMessageText: CreditCard invalidCreditCard.
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/23/2021 01:15:10'!
test09cannotCheckoutAnInvalidCart

	| interface catalog time|

	catalog := testObjectsFactory defaultCatalog.
	time := testObjectsFactory dateTimeToday.
	
	interface := InnerUserInterface with: credentialValidatorValid acceptingItemsOf: catalog.
	
	self should: [ interface checkout: 1 at: time withCard: 1234567812345678 from: 'donpepegrillo' expiringOn: '072021']
	 raise: Error
	withMessageText: InnerUserInterface invalidCartId.! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'MS 6/23/2021 01:41:11'!
test10checkoutACartIsListedInPurchases

	| interface catalog time cartID isbn userID userPassword expectedList |

	catalog := testObjectsFactory defaultCatalog.
	time := testObjectsFactory dateTimeToday.
	
	interface := InnerUserInterface with: credentialValidatorValid acceptingItemsOf: catalog.
	userID := 'validUser'.
	userPassword := 'validPassword'.

	cartID := interface createCartForUser: userID withPassword: userPassword at: time.
	
	isbn := testObjectsFactory itemSellByTheStore.
	
	interface add: 1 of: isbn toCart: cartID at: time.
	interface checkout: 1 at: time withCard: 1234567812345678 from: 'donpepegrillo' expiringOn: '072021'.
	
	expectedList := OrderedCollection with: {isbn . 1} with: testObjectsFactory itemSellByTheStorePrice.
	
	self assert: (interface listPurchasesOf: userID withPassword: userPassword) equals: expectedList.
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'MS 6/19/2021 23:29:10'!
listItems
	^items copy.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MS 6/23/2021 02:14:21'!
createSale

	^ Sale of: total for: cart listItems.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CredentialValidatorSimulator category: 'TusLibros'!
Object subclass: #CredentialValidatorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CredentialValidatorSimulator methodsFor: 'log' stamp: 'ENC 6/17/2021 21:15:51'!
logWith: aUsername and: aPassword

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CredentialValidatorSimulator class' category: 'TusLibros'!
CredentialValidatorSimulator class
	instanceVariableNames: ''!

!CredentialValidatorSimulator class methodsFor: 'error description' stamp: 'ENC 6/17/2021 21:18:49'!
errorInvalidUsernameOrPassword

	^ 'El usuario o contraseña ingresados son inválidos'! !


!classDefinition: #CredentialValidatorSimulatorInvalidCredentials category: 'TusLibros'!
CredentialValidatorSimulator subclass: #CredentialValidatorSimulatorInvalidCredentials
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CredentialValidatorSimulatorInvalidCredentials methodsFor: 'log' stamp: 'ENC 6/17/2021 21:17:30'!
logWith: aUsername and: aPassword

	self error: self class errorInvalidUsernameOrPassword ! !


!classDefinition: #CredentialValidatorSimulatorValidCredentials category: 'TusLibros'!
CredentialValidatorSimulator subclass: #CredentialValidatorSimulatorValidCredentials
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CredentialValidatorSimulatorValidCredentials methodsFor: 'log' stamp: 'ENC 6/17/2021 21:19:45'!
logWith: aUsername and: aPassword

	! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'signaling' stamp: 'MS 6/23/2021 00:49:18'!
signalInvalidCreditCard

	^ self error: self class invalidCreditCard.! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'MS 6/23/2021 01:18:41'!
initializeWith: aCardNumber from: anOwnerName expiringOn: anExpirationDate
.

	(anOwnerName withBlanksTrimmed isEmpty) ifTrue: [ self signalInvalidCreditCard ].
	((aCardNumber numberOfDigitsInBase: 10) = 16) ifFalse: [ self signalInvalidCreditCard ].
	(anExpirationDate size = 6) ifFalse: [ self signalInvalidCreditCard ].

	owner := anOwnerName.
	number := aCardNumber.
	expiration := Month month: ((anExpirationDate first: 2) asNumber) year: ((anExpirationDate last: 4) asNumber).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error' stamp: 'MS 6/23/2021 00:37:06'!
invalidCreditCard
	^ 'No se puede comprar con una tarjeta inválida.'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 6/23/2021 01:03:16'!
number: aCardNumber from: anOwnerName expiringOn: anExpirationDate 
	
	^self new initializeWith: aCardNumber from: anOwnerName expiringOn: anExpirationDate.! !


!classDefinition: #InnerUserInterface category: 'TusLibros'!
Object subclass: #InnerUserInterface
	instanceVariableNames: 'credentialValidator carts cartsLastTimeUsed cartsUserID merchantProcessor salesBooks catalog lastId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerUserInterface methodsFor: 'checkout' stamp: 'MS 6/23/2021 02:15:09'!
checkout: aCartID at: aTime withCard: aCardNumber from: aCardOwner expiringOn: aDate
	
	| creditCard salesBook userID cart cashier |
	
	creditCard := CreditCard number: aCardNumber from: aCardOwner expiringOn: aDate.
	
	self assertCartID: aCartID isValidAt: aTime.
	
	cartsLastTimeUsed at: aCartID put: aTime.
	
	userID := cartsUserID at: aCartID.
	salesBook := salesBooks at: userID.
	cart := carts at: aCartID .
	
	cashier := Cashier toCheckout: cart charging: creditCard throught: merchantProcessor on: aTime registeringOn: salesBook.
	
	cashier checkOut.! !

!InnerUserInterface methodsFor: 'checkout' stamp: 'MS 6/23/2021 02:07:24'!
listPurchasesOf: anUserID withPassword: anUserPassword

	| sales purchases total |
	
	credentialValidator logWith: anUserID and: anUserPassword.
	
	sales := salesBooks at: anUserID.
	
	purchases := sales inject: OrderedCollection new addingAll: [ :aSale | aSale purchase].
	total := sales inject: 0 into: [ :totalAmount :aSale | totalAmount + aSale total].
	
	^ OrderedCollection with: purchases with: total.! !


!InnerUserInterface methodsFor: 'cart' stamp: 'MS 6/23/2021 01:30:35'!
add: amountOfItems of: item toCart: aCartID at: aTime
	
	| cart |
	
	self assertCartID: aCartID isValidAt: aTime.
	
	cartsLastTimeUsed at: aCartID put: aTime.
	
	cart := carts at: aCartID.
	cart add: amountOfItems of: item.
	! !

!InnerUserInterface methodsFor: 'cart' stamp: 'MS 6/23/2021 01:30:35'!
createCartForUser: userID withPassword: userPassword at: aTime

	| cart cartID |
	credentialValidator logWith: userID and: userPassword.
	
	cart := Cart acceptingItemsOf: catalog.
	
	cartID := self generateCartID.
	
	carts at: cartID put: cart.
	cartsLastTimeUsed at: cartID put: aTime.
	
	^ cartID
	
	! !

!InnerUserInterface methodsFor: 'cart' stamp: 'MS 6/23/2021 01:30:35'!
listCart: aCartID at: aTime
	
	self assertCartID: aCartID isValidAt: aTime.
	
	cartsLastTimeUsed at: aCartID put: aTime.
	
	^ (carts at: aCartID) listItems.! !


!InnerUserInterface methodsFor: 'initialization' stamp: 'MS 6/19/2021 23:19:24'!
generateCartID
	lastId := lastId + 1.
	
	^ lastId.! !

!InnerUserInterface methodsFor: 'initialization' stamp: 'MS 6/23/2021 01:30:35'!
initializeWith: aCredentialValidator acceptingItemsOf: aCatalog

	credentialValidator := aCredentialValidator.
	catalog := aCatalog.
	carts := Dictionary new.
	cartsLastTimeUsed := Dictionary new.
	lastId := 0.! !


!InnerUserInterface methodsFor: 'signaling' stamp: 'MS 6/19/2021 23:39:18'!
signalInvalidCartId
	^ self error: self class invalidCartId.! !


!InnerUserInterface methodsFor: 'asserting' stamp: 'MS 6/23/2021 01:30:35'!
assertCartID: aCartID isValidAt: aTime

	(cartsLastTimeUsed includesKey: aCartID) ifFalse: [^ self signalInvalidCartId ].
	(self assertCartIsTimedOut: (cartsLastTimeUsed at: aCartID) at: aTime) ifTrue: [^ self signalInvalidCartId ].
	! !

!InnerUserInterface methodsFor: 'asserting' stamp: 'MS 6/22/2021 23:59:24'!
assertCartIsTimedOut: aCartTime at: aTime

	^ (aTime - aCartTime) totalMinutes > 30! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InnerUserInterface class' category: 'TusLibros'!
InnerUserInterface class
	instanceVariableNames: ''!

!InnerUserInterface class methodsFor: 'instance creation' stamp: 'MS 6/19/2021 23:15:40'!
with: aCredentialValidator acceptingItemsOf: aCatalog

	^ self new initializeWith: aCredentialValidator acceptingItemsOf: aCatalog.! !


!InnerUserInterface class methodsFor: 'error description' stamp: 'MS 6/19/2021 23:38:43'!
invalidCartId
	^ 'El Id no corresponde a un carrito válido.'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'purchase' stamp: 'MS 6/23/2021 02:10:42'!
purchase
	^ items! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'MS 6/23/2021 02:12:16'!
initializeTotal: aTotal for: aListOfItems

	total := aTotal .
	items := aListOfItems .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'MS 6/23/2021 02:11:48'!
of: aTotal for: aListOfItems

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal for: aListOfItems.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'MS 6/22/2021 23:39:56'!
dateTimeToday
	
	^ DateAndTime date: today time: (Time hour: 19 minute: 00 second: 00).! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'MS 6/22/2021 23:41:04'!
dateTimeTodayAfter30Minutes
	
	^ DateAndTime date: today time: (Time hour: 19 minute: 31 second: 00).! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
