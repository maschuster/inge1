!classDefinition: #AlanKay category: 'TP1'!
DenotativeObject subclass: #AlanKay
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AlanKay class' category: 'TP1'!
AlanKay class
	instanceVariableNames: ''!

!AlanKay class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:47:17'!
dateOfBirth
	^May/17/1940.! !


!classDefinition: #AlanTuring category: 'TP1'!
DenotativeObject subclass: #AlanTuring
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AlanTuring class' category: 'TP1'!
AlanTuring class
	instanceVariableNames: ''!

!AlanTuring class methodsFor: 'personal info' stamp: 'ENC 3/27/2021 22:40:14'!
dateOfBirth
	^June/23/1912.! !


!AlanTuring class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 23:40:24'!
doesNotUnderstand: aMessage
	^'No entiendo a qué te referís con ', aMessage asString. ! !


!classDefinition: #AlonsoChurch category: 'TP1'!
DenotativeObject subclass: #AlonsoChurch
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AlonsoChurch class' category: 'TP1'!
AlonsoChurch class
	instanceVariableNames: ''!

!AlonsoChurch class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 23:47:04'!
ageDifferenceWith: aPerson
	| ageDifference |
	
	ageDifference := (AlonsoChurch dateOfBirth distanceTo: aPerson dateOfBirth) abs.
	^ageDifference.! !

!AlonsoChurch class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:58:07'!
ageDifferenceWithAlanKay
	| differenceWithDanIngalls |
	differenceWithDanIngalls := (AlonsoChurch dateOfBirth distanceTo: AlanKay dateOfBirth) abs.
	^differenceWithDanIngalls.! !

!AlonsoChurch class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:55:08'!
ageDifferenceWithAlanTuring
	| diffenceWithAlanTuring |
	diffenceWithAlanTuring := (AlanTuring dateOfBirth distanceTo: AlonsoChurch dateOfBirth) abs. 
	^diffenceWithAlanTuring.! !

!AlonsoChurch class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:57:45'!
ageDifferenceWithDanIngalls
	| differenceWithDanIngalls |
	differenceWithDanIngalls := (AlonsoChurch dateOfBirth distanceTo: DanIngalls dateOfBirth) abs.
	^differenceWithDanIngalls.! !

!AlonsoChurch class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:41:53'!
dateOfBirth
	^June/14/1903.! !


!classDefinition: #DanIngalls category: 'TP1'!
DenotativeObject subclass: #DanIngalls
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DanIngalls class' category: 'TP1'!
DanIngalls class
	instanceVariableNames: ''!

!DanIngalls class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:48:48'!
dateOfBirth
	^February/11/1944.! !


!classDefinition: #vehicle category: 'TP1'!
DenotativeObject subclass: #vehicle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TP1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'vehicle class' category: 'TP1'!
vehicle class
	instanceVariableNames: ''!

!vehicle class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:35:28'!
asHtml! !

!vehicle class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:35:47'!
asJson! !

!vehicle class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:32:16'!
break! !

!vehicle class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:32:42'!
openTrunk! !

!vehicle class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:37:52'!
save! !

!vehicle class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:32:28'!
speedUp! !

!vehicle class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:32:08'!
turnOff! !

!vehicle class methodsFor: 'as yet unclassified' stamp: 'ENC 3/27/2021 22:31:52'!
turnOn
! !
