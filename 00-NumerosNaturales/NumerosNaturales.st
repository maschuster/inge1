!classDefinition: #I category: 'NumerosNaturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NumerosNaturales'!
I class
	instanceVariableNames: 'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'!

!I class methodsFor: 'operaciones' stamp: 'ENC 4/6/2021 23:06:13'!
* unFactor

	^ unFactor.! !

!I class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:46:17'!
+ unSumando

	^ unSumando next.! !

!I class methodsFor: 'operaciones' stamp: 'ENC 4/6/2021 23:42:13'!
- unSustraendo

	^ self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'operaciones' stamp: 'ENC 4/6/2021 23:36:34'!
/ unDivisor

	^ (self = unDivisor) ifTrue: [ self ] ifFalse: [ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].! !

!I class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:01:16'!
< unNatural
	^ (unNatural = I) not.! !

!I class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:46:17'!
next
	^II.! !

!I class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:54:19'!
substractedFrom: unMinuendo

	^ unMinuendo previous.! !


!I class methodsFor: 'errors' stamp: 'ENC 4/6/2021 23:41:06'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir por un número mayor'! !

!I class methodsFor: 'errors' stamp: 'ENC 4/6/2021 23:42:50'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	
	^ 'Número negativos no soportados'.! !


!I class methodsFor: 'as yet unclassified' stamp: 'ENC 4/7/2021 22:58:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor := 'No se puede dividir por un número mayor'.! !


!classDefinition: #II category: 'NumerosNaturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NumerosNaturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:46:51'!
* unFactor

	^ unFactor + (self previous * unFactor).! !

!II class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:46:51'!
+ unSumando

	^ self previous + unSumando next! !

!II class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:54:19'!
- unSustraendo
	
	^ unSustraendo substractedFrom: self.! !

!II class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:52:02'!
/ unDivisor

	| cociente dividendo |

	(self = unDivisor) ifTrue: [ ^I ].
	
	(self < unDivisor) ifTrue: [ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	cociente := I.
	dividendo := self - unDivisor.
	
	[ unDivisor < dividendo ] whileTrue: [ 
		cociente := cociente next.
		dividendo := dividendo - unDivisor.
	].

	(unDivisor = dividendo) ifTrue: [ ^cociente next ] ifFalse: [ ^cociente ].! !

!II class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:46:51'!
< unNatural

	(unNatural = I) ifTrue: [ ^false ].
	
	^ self previous < unNatural previous.! !

!II class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:47:36'!
next
	next ifNil: [
		next := self createChildNamed: self name, 'I'.
		next previous: self.
		].
	^ next! !

!II class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:57:43'!
previous
	^ previous.! !

!II class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:54:19'!
substractedFrom: unMinuendo

	^ (self previous) substractedFrom: (unMinuendo previous).! !


!II class methodsFor: 'errors' stamp: 'ENC 4/7/2021 22:43:11'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor'.! !


!II class methodsFor: 'as yet unclassified' stamp: 'ENC 4/7/2021 22:58:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'NumerosNaturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NumerosNaturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'operaciones' stamp: 'ENC 4/7/2021 22:57:43'!
previous: elPredecesor 
	previous _ elPredecesor.! !


!III class methodsFor: 'as yet unclassified' stamp: 'ENC 4/7/2021 22:58:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'NumerosNaturales'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'NumerosNaturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'ENC 4/7/2021 22:58:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'NumerosNaturales'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'NumerosNaturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ENC 4/7/2021 22:58:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!