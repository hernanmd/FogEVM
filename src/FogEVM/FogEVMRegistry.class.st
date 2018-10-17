Class {
	#name : #FogEVMRegistry,
	#superclass : #Object,
	#instVars : [
		'value',
		'mask'
	],
	#classInstVars : [
		'falseInstance',
		'trueInstance',
		'zeroInstance',
		'minusOneInstance'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #accessing }
FogEVMRegistry class >> booleanMask [
	^ 16rFF 
]

{ #category : #mask }
FogEVMRegistry class >> createMaskFor: anInteger [
	^ 256 ** anInteger - 1
	" 256 == FF 
(256 ** 1) -1  == 0xFF
(256 ** 2)-1 == 0xFFFF 
...

"
]

{ #category : #mask }
FogEVMRegistry class >> createNegativeMaskFor: anInteger [
	^ 256 ** anInteger - 1.
	
	
	
	" 256 == FF 
(256 ** 1) -1  == 0xFF
(256 ** 2)-1 == 0xFFFF 
...

"
]

{ #category : #accessing }
FogEVMRegistry class >> false [
	^ falseInstance
		ifNil: [ falseInstance := self new
				mask: self booleanMask;
				value: 0;
				yourself ]
]

{ #category : #creating }
FogEVMRegistry class >> forPush: aFogVMPush [
	^ self forValue: aFogVMPush parameter asBKNumber bytesLength: aFogVMPush bytes
]

{ #category : #creating }
FogEVMRegistry class >> forValue: anInteger bytesLength: aByteLengthSize [
	^ self new
		mask: (self createMaskFor: aByteLengthSize);
		value: anInteger;
		yourself
]

{ #category : #creating }
FogEVMRegistry class >> forValue: anInteger maskedAs: aFogEVMRegistry [
	^ self new
		mask: aFogEVMRegistry mask;
		value: anInteger;
		yourself
]

{ #category : #accessing }
FogEVMRegistry class >> mask32Bytes [
	^ self createMaskFor: 32
]

{ #category : #accessing }
FogEVMRegistry class >> minusOne [
	^ minusOneInstance
		ifNil: [ minusOneInstance := self new
				mask: self mask32Bytes;
				value: -1;
				yourself ]
]

{ #category : #creating }
FogEVMRegistry class >> true [
	^ trueInstance
		ifNil: [ trueInstance := self new
				mask: self booleanMask;
				value: 1;
				yourself ]
]

{ #category : #accessing }
FogEVMRegistry class >> zero [
	^ zeroInstance
		ifNil: [ zeroInstance := self new
				mask: self mask32Bytes;
				value: 0;
				yourself ]
]

{ #category : #arithmetics }
FogEVMRegistry >> * aFogEVMRegistry [
	^ FogEVMRegistry forValue: self unsignedValue * aFogEVMRegistry unsignedValue maskedAs: aFogEVMRegistry
]

{ #category : #arithmetics }
FogEVMRegistry >> ** aFogEVMRegistry [
	^ FogEVMRegistry forValue: self unsignedValue ** aFogEVMRegistry unsignedValue maskedAs: self
]

{ #category : #arithmetics }
FogEVMRegistry >> + aFogEVMRegistry [
	^ FogEVMRegistry forValue: self unsignedValue + aFogEVMRegistry unsignedValue maskedAs: aFogEVMRegistry
]

{ #category : #arithmetics }
FogEVMRegistry >> - aFogEVMRegistry [
	^ FogEVMRegistry forValue: self unsignedValue - aFogEVMRegistry unsignedValue maskedAs: aFogEVMRegistry
]

{ #category : #arithmetics }
FogEVMRegistry >> // aFogEVMRegistry [
	^ FogEVMRegistry
		forValue: self unsignedValue // aFogEVMRegistry unsignedValue
		maskedAs: aFogEVMRegistry
]

{ #category : #bit }
FogEVMRegistry >> << aFogEVMRegistry [
	^ FogEVMRegistry forValue: self unsignedValue << aFogEVMRegistry unsignedValue maskedAs: self
]

{ #category : #'bit manipulation' }
FogEVMRegistry >> >> aFogEVMRegistry [
	^ FogEVMRegistry forValue: self unsignedValue >> aFogEVMRegistry unsignedValue maskedAs: self
]

{ #category : #arithmetics }
FogEVMRegistry >> \\ aFogEVMRegistry [
	^ FogEVMRegistry forValue: self unsignedValue \\ aFogEVMRegistry unsignedValue maskedAs: aFogEVMRegistry
]

{ #category : #conversion }
FogEVMRegistry >> asPushableRegistry [
	^ self 
]

{ #category : #converying }
FogEVMRegistry >> byteArray [
	^ self unsignedValue asByteArray
]

{ #category : #accessing }
FogEVMRegistry >> byteAt: aFogEVMRegistry [
	^ FogEVMRegistry forValue: (self byteArray at: aFogEVMRegistry unsignedValue) bytesLength: 1
]

{ #category : #extention }
FogEVMRegistry >> extendRepresentationTo: aFogEVMRegistry [
	aFogEVMRegistry unsignedValue > 31
		ifTrue: [ ^ self ].
	^ FogEVMRegistry
		forValue: self signedValue
		bytesLength: aFogEVMRegistry unsignedValue + 1
]

{ #category : #testing }
FogEVMRegistry >> hex [
	^ value hex
]

{ #category : #flow }
FogEVMRegistry >> ifTrue: aBlockClosure ifFalse: aBlockClosure2 [
	^ self unsignedValue == 1
		ifTrue: aBlockClosure
		ifFalse: aBlockClosure2
]

{ #category : #testing }
FogEVMRegistry >> isEqualsTo: aFogEVMRegistry [
	^ self unsignedValue = aFogEVMRegistry unsignedValue
		ifTrue: [ FogEVMRegistry true ]
		ifFalse: [ FogEVMRegistry false ]
]

{ #category : #accessing }
FogEVMRegistry >> isPositive [
	^ value <= (mask >> 1)
]

{ #category : #testing }
FogEVMRegistry >> isZero [
	^ self unsignedValue = 0
		ifTrue: [ FogEVMRegistry true ]
		ifFalse: [ FogEVMRegistry false ]
]

{ #category : #accessing }
FogEVMRegistry >> mask [
	^ mask
]

{ #category : #accessing }
FogEVMRegistry >> mask: anInteger [ 
	mask := anInteger
]

{ #category : #testing }
FogEVMRegistry >> printOn: aStream [
	aStream nextPutAll: ('Hexa:[{1}]' format: {self hex})
]

{ #category : #arithmetics }
FogEVMRegistry >> signedDivision: aFogEVMRegistry [
	| sign |
	sign := ((self isPositive and: [ aFogEVMRegistry isPositive ]) or: (self isPositive not and: [ aFogEVMRegistry isPositive not ]))
		ifTrue: [ 1 ]
		ifFalse: [ -1 ].
	^ FogEVMRegistry forValue: self signedValue abs // aFogEVMRegistry signedValue abs * sign maskedAs: aFogEVMRegistry
]

{ #category : #comparing }
FogEVMRegistry >> signedGreaterThan: aFogEVMRegistry [
	^ self signedValue > aFogEVMRegistry signedValue
		ifTrue: [ FogEVMRegistry true ]
		ifFalse: [ FogEVMRegistry false ]
]

{ #category : #comparing }
FogEVMRegistry >> signedLesserThan: aFogEVMRegistry [
	^ self signedValue < aFogEVMRegistry signedValue
		ifTrue: [ FogEVMRegistry true ]
		ifFalse: [ FogEVMRegistry false ]
]

{ #category : #'bit manipulation' }
FogEVMRegistry >> signedRightShift: aFogEVMRegistry [
	^ aFogEVMRegistry unsignedValue < 256
		ifTrue: [ self >> aFogEVMRegistry ]
		ifFalse: [ self isPositive
				ifTrue: [ FogEVMRegistry zero ]
				ifFalse: [ FogEVMRegistry minusOne ] ]
]

{ #category : #accessing }
FogEVMRegistry >> signedValue [
	^ self isPositive
		ifTrue: [ value ]
		ifFalse: [ ^ value - (mask + 1) ]
]

{ #category : #arithsmetics }
FogEVMRegistry >> smod: aFogEVMRegistry [
	| x y val |
	y := aFogEVMRegistry signedValue.
	val := y = 0
		ifTrue: [ 0 ]
		ifFalse: [ x := self signedValue.
			x sign * (x abs \\ y abs) ].
	^ FogEVMRegistry forValue: val maskedAs: self
]

{ #category : #comparing }
FogEVMRegistry >> unsignedGT: aFogEVMRegistry [
	^ self unsignedValue > aFogEVMRegistry unsignedValue
		ifTrue: [ FogEVMRegistry true ]
		ifFalse: [ FogEVMRegistry false ]
]

{ #category : #comparing }
FogEVMRegistry >> unsignedLesserThan: aFogEVMRegistry [
	^ self unsignedValue < aFogEVMRegistry unsignedValue
		ifTrue: [ FogEVMRegistry true ]
		ifFalse: [ FogEVMRegistry false ]
]

{ #category : #accessing }
FogEVMRegistry >> unsignedValue [
	^ value
]

{ #category : #accessing }
FogEVMRegistry >> value: anInteger [
	anInteger < 0
		ifTrue: [ value := mask + 1 + anInteger ]
		ifFalse: [ value := anInteger bitAnd: mask ]
]
