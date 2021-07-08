!classDefinition: #TusLibrosServerServices category: 'TusLibrosServicesServer'!
Object subclass: #TusLibrosServerServices
	instanceVariableNames: 'portNumber port webServer facade factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosServicesServer'!

!TusLibrosServerServices methodsFor: 'initialization' stamp: 'ENC 6/28/2021 16:34:11'!
initializeFacade
	factory := StoreTestObjectsFactory new.

	facade := TusLibrosSystemFacade
		authenticatingWith: (Dictionary with: (Association key: 'user' value: 'pass')) 
		acceptingItemsOf: factory defaultCatalog 
		registeringOn: OrderedCollection new
		debitingThrought: TusLibrosSystemFacadeTest new
		measuringTimeWith: DateAndTime
! !

!TusLibrosServerServices methodsFor: 'initialization' stamp: 'ENC 7/8/2021 16:17:19'!
initializeWithPort: aPortNumber 

	self initializeFacade.

	port := aPortNumber.
	webServer := WebServer new listenOn: port.

	self addService: '/addToCart' action: self addToCartHandler.
	self addService: '/catalog' action: self catalogHandler.
	self addService: '/checkOut' action: self checkOutHandler.
	self addService: '/createCart' action: self createCartHandler.
	self addService: '/listCart' action: self listCartHandler.
	self addService: '/listPurchases' action: self listPurchasesHandler.
	self addService: '/removeFromCart' action: self removeFromCartHandler.
	! !


!TusLibrosServerServices methodsFor: 'service handler' stamp: 'ENC 7/8/2021 15:08:56'!
addToCartHandler

	^ [ :request | | idCart isbn quantity |
		isbn := (request fields at:'isbn').
		quantity := (request fields at:'quantity').
		idCart := (request fields at:'id').
		
		facade add: (quantity asNumber) of: isbn toCartIdentifiedAs: (idCart asNumber).
		
		'OK'.
	]! !

!TusLibrosServerServices methodsFor: 'service handler' stamp: 'ENC 7/8/2021 15:08:13'!
catalogHandler

	^ [ :request | | titles prices catalog |
		prices := facade catalog.
		titles := factory defaultTitlesCatalog.
		catalog := Dictionary new.
				
		prices keysDo: [ :isbn | | value |
			value := (Dictionary new 
				at: 'price'  put: (prices at: isbn);
				at: 'title'  put: (titles at: isbn);
				yourself).
			
			catalog at: isbn put: value
		].
		
		catalog.
	]! !

!TusLibrosServerServices methodsFor: 'service handler' stamp: 'ENC 7/6/2021 20:18:22'!
checkOutHandler

	^ [ :request | | idCart ticket |
		idCart := (request fields at:'id').
		
		ticket := facade checkOutCartIdentifiedAs: (idCart asNumber)
			withCreditCardNumbered: factory notExpiredCreditCardNumber
			ownedBy: factory notExpiredCreditCardOwner
			expiringOn: factory notExpiredMonthOfYear.
		
		ticket
	]! !

!TusLibrosServerServices methodsFor: 'service handler' stamp: 'ENC 7/8/2021 16:07:03'!
createCartHandler

	^ [ :request | | username password idCart |
		username := (request fields at:'username').
		password := (request fields at:'password').
		
		idCart := facade createCartFor: username  authenticatedWith: password.
		
		idCart
	]! !

!TusLibrosServerServices methodsFor: 'service handler' stamp: 'ENC 7/8/2021 15:08:30'!
listCartHandler

	^ [ :request | | idCart listCart |
		idCart := (request fields at: 'id').
		
		listCart := facade listCartIdentifiedAs: (idCart asNumber).
		
		listCart asArray 
	]! !

!TusLibrosServerServices methodsFor: 'service handler' stamp: 'ENC 6/28/2021 16:31:02'!
listPurchasesHandler

	^ [ :request | | username password purchases |
		username := (request fields at:'username').
		password := (request fields at:'password').
		
		purchases := facade listPurchasesOf: username authenticatingWith: password. 
		
		purchases
	]! !

!TusLibrosServerServices methodsFor: 'service handler' stamp: 'ENC 7/8/2021 15:08:50'!
removeFromCartHandler

	^ [ :request | | idCart isbn quantity |
		isbn := (request fields at:'isbn').
		quantity := (request fields at:'quantity').
		idCart := (request fields at:'id').
		
		facade remove: (quantity asNumber) of: isbn toCartIdentifiedAs: (idCart asNumber).
		
		'OK'.
	]! !


!TusLibrosServerServices methodsFor: 'services' stamp: 'ENC 7/8/2021 15:05:37'!
addService: aServiceName action: aBlock

	webServer addService: aServiceName action:[:request |
		[ | response |
			response := aBlock value: request.
			request send200Response: (WebUtils jsonEncode: response)
		] on: Error do: [ :anError |
			request send400Response: (anError messageText) 
		]
	]! !


!TusLibrosServerServices methodsFor: 'finalization' stamp: 'ENC 6/24/2021 21:19:32'!
destroy
	
	webServer ifNotNil: [ webServer destroy ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerServices class' category: 'TusLibrosServicesServer'!
TusLibrosServerServices class
	instanceVariableNames: ''!

!TusLibrosServerServices class methodsFor: 'as yet unclassified' stamp: 'ENC 6/24/2021 21:13:51'!
listeningOn: aPortNumber

	^self new initializeWithPort: aPortNumber! !
