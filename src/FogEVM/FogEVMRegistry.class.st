"
The Registry is a class used widely, specially by the interpreter, for managing representing a fixed size registry of data.

EVM manages registries of many sizes, from 1 byte to 32 bytes. 

For achieving the expected behaviour, the registry:
	* Implements complement of two, for signed numbers
	* Use a bit mask for ensuring the size of the representing value 
		- On value assignment it applies bit operations for only getting the part of the information needed.
	* implements all the basic operations needed by a stack element of the interpreter
		- arithmetics
		- bit manipulation
		- bitwise operations 
		- comparisions 
		

"
Class {
	#name : #FogEVMRegistry,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'value',
		'mask'
	],
	#classInstVars : [
		'falseInstance',
		'trueInstance',
		'zeroInstance',
		'minusOneInstance',
		'oneInstance'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #accessing }
FogEVMRegistry class >> booleanMask [
	^ 16rFF 
]

{ #category : #mask }
FogEVMRegistry class >> createMaskFor: anInteger [
	<doc: 'Returns a mask for the given amount of bytes. Integer expected as parameter'>
	^ 256 ** anInteger - 1
	" 256 == FF 
(256 ** 1) -1  == 0xFF
(256 ** 2)-1 == 0xFFFF 
...

"
]

{ #category : #accessing }
FogEVMRegistry class >> false [
	<doc: 'Returns the singleton registry that represents false'>
	^ falseInstance
		ifNil: [ falseInstance := self new
				mask: self booleanMask;
				value: 0;
				yourself ]
]

{ #category : #creating }
FogEVMRegistry class >> forByteArray: aByteArray bytesLength: anInteger [ 
	| int stream rest |
	stream := aByteArray readStream.
	[stream peek = 0.] whileTrue: [ stream next ].
	rest := stream upToEnd. 
	int := LargePositiveInteger new: rest size.
	rest doWithIndex: [ : val : i | int digitAt:i put: val ].
	^ self forValue: int bytesLength: anInteger 
]

{ #category : #creating }
FogEVMRegistry class >> forMemoryContent: aString [
	<doc:
		'Returns a registry for being pushed into the memory representation. The given content may be a String holding an hexadecimal representation. Each slot of memory in the memory is word-size (32)'>
	^ self forValue: aString read0xHexadecimal bytesLength: FogEVMAbstractInterpreter wordSize
]

{ #category : #creating }
FogEVMRegistry class >> forPush: aFogVMPush [
	<doc: 'Returns a registry with the value pushed by a given push bytecode. Each push knows the value and length representation.'>
	^ self forValue: aFogVMPush parameter read0xHexadecimal bytesLength: aFogVMPush bytes
]

{ #category : #creating }
FogEVMRegistry class >> forValue: anInteger bytesLength: aByteLengthSize [
	<doc: 'Returns a registry with a given value and a given byte length representation'>
	^ self new
		mask: (self createMaskFor: aByteLengthSize);
		value: anInteger;
		yourself
]

{ #category : #creating }
FogEVMRegistry class >> forWordSizeValue: aValue [
	<doc: 'Returns a registry for the given value, with a word-sizd byte length representation (32)'>
	^ self forValue: aValue read0xHexadecimal bytesLength: FogEVMAbstractInterpreter wordSize
]

{ #category : #creating }
FogEVMRegistry class >> fromPrintString: aString length: aByteLength [
<doc: 'Returns a registry for the given string, and a given bytes length. This string representation is the same used by the FogEVMRegistry>>printOn:.'>
	^ self forValue: (aString copyReplaceAll: '0x' with: '16r') asNumber bytesLength: aByteLength
]

{ #category : #accessing }
FogEVMRegistry class >> mask32Bytes [
	^ self createMaskFor: 32
]

{ #category : #accessing }
FogEVMRegistry class >> minusOne [
	<doc: 'Returns the singleton registry that represents minus one (-1)'>
	^ minusOneInstance
		ifNil: [ minusOneInstance := self new
				mask: self mask32Bytes;
				value: -1;
				yourself ]
]

{ #category : #accessing }
FogEVMRegistry class >> one [
	<doc: 'Returns the singleton registry that represents one (1)'>
	^ oneInstance
		ifNil: [ oneInstance := self new
				mask: self booleanMask;
				value: 1;
				yourself ]
]

{ #category : #accessing }
FogEVMRegistry class >> true [
	<doc: 'Returns the singleton registry that represents true'>
	^ trueInstance
		ifNil: [ trueInstance := self new
				mask: self booleanMask;
				value: 1;
				yourself ]
]

{ #category : #accessing }
FogEVMRegistry class >> zero [
	<doc: 'Returns the singleton registry that represents zero (0)'>
	^ zeroInstance
		ifNil: [ zeroInstance := self new
				mask: self mask32Bytes;
				value: 0;
				yourself ]
]

{ #category : #'bitwise logical operations' }
FogEVMRegistry >> & aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the AND bitwise logical operation. The result uses a 32 bytes mask'>
	^ self class forValue: (self unsignedValue bitAnd: aFogEVMRegistry unsignedValue) bytesLength: 32
]

{ #category : #arithmetics }
FogEVMRegistry >> * aFogEVMRegistry [
	<doc:
		'Returns the registry for the value of the multiplication operation. The result uses a word size byte length representation'>
	^ FogEVMRegistry forWordSizeValue: self unsignedValue * aFogEVMRegistry unsignedValue
]

{ #category : #arithmetics }
FogEVMRegistry >> ** aFogEVMRegistry [
	<doc:
		'Returns the registry for the value of the exponentiation operation. The result uses a mask as the registry on the right side of the operation'>
	^ FogEVMRegistry forWordSizeValue: self unsignedValue ** aFogEVMRegistry unsignedValue
]

{ #category : #arithmetics }
FogEVMRegistry >> + aFogEVMRegistry [
	<doc:
		'Returns the registry for the value of the addition operation. The result uses a mask as the registry on the right side of the operation'>
	^ FogEVMRegistry forWordSizeValue: self unsignedValue + aFogEVMRegistry unsignedValue
]

{ #category : #arithmetics }
FogEVMRegistry >> - aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the substraction operation. The result uses a mask as the registry on the right side of the operation'>
	^ FogEVMRegistry forWordSizeValue: self unsignedValue - aFogEVMRegistry unsignedValue 
]

{ #category : #arithmetics }
FogEVMRegistry >> // aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the entire division operation. The result uses a mask as the registry on the right side of the operation'>
	^ FogEVMRegistry forWordSizeValue: self unsignedValue // aFogEVMRegistry unsignedValue
]

{ #category : #'bit manipulation' }
FogEVMRegistry >> < otherRegistry [
	^ self unsignedLesserThan: otherRegistry 
]

{ #category : #'bit manipulation' }
FogEVMRegistry >> << aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the shift-to-left operation'>
	^ FogEVMRegistry forWordSizeValue: self unsignedValue << aFogEVMRegistry unsignedValue
]

{ #category : #'bit manipulation' }
FogEVMRegistry >> >> aFogEVMRegistry [
	<doc:
		'Returns the registry for the value of the shift-to-right operation. The result uses a mask as the registry on the left side of the operation'>
	^ FogEVMRegistry forWordSizeValue: self unsignedValue >> aFogEVMRegistry unsignedValue
]

{ #category : #arithmetics }
FogEVMRegistry >> \\ aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the modulo operation. The result uses a mask as the registry on the right side of the operation'>
	^ FogEVMRegistry forWordSizeValue: self unsignedValue \\ aFogEVMRegistry unsignedValue 
]

{ #category : #converting }
FogEVMRegistry >> asByteArray [
	^ self byteArray
]

{ #category : #converting }
FogEVMRegistry >> asPushableRegistry [
	^ self 
]

{ #category : #converting }
FogEVMRegistry >> asRegistryLengthArray [
	<doc: 'Returns the byte array representation of the registry''s value, ensuring a byte array long as the registry byte length.'>
	| content wordarray delta |
	content := self byteArray.
	delta := self byteLengthRepresentation - content size.
	wordarray := ByteArray new: self byteLengthRepresentation.
	1 to: content size do: [ :idx | wordarray at: delta + idx put: (content at: idx) ].
	^ wordarray
]

{ #category : #converting }
FogEVMRegistry >> asWordByteArray [
	<doc: 'Returns the byte array representation of the registry''s value, ensuring a byte array long as FogEVMAbstractInterpreter wordSize (32)'>
	| content wordarray delta |
	content := self byteArray.
	delta := FogEVMAbstractInterpreter wordSize - content size.
	wordarray := ByteArray new: FogEVMAbstractInterpreter wordSize.
	1 to: content size do: [ :idx | wordarray at: delta + idx put: (content at: idx) ].
	^ wordarray
]

{ #category : #accessing }
FogEVMRegistry >> booleanValue [
	^ value = 1 
]

{ #category : #converting }
FogEVMRegistry >> byteArray [
	<doc: 'Returns the byte array representation of the registry''s value'>
	^ self unsignedValue asByteArray reverse
]

{ #category : #accessing }
FogEVMRegistry >> byteAt: aFogEVMRegistry [
	^ FogEVMRegistry forValue: (self byteArray reverse at: aFogEVMRegistry unsignedValue) bytesLength: 1
]

{ #category : #converting }
FogEVMRegistry >> byteLengthRepresentation [
	<doc: 'Returns the registry''s byte length representation'>
	^ (mask hex asString copyReplaceAll: '16r' with: '') size / 2
]

{ #category : #enumerating }
FogEVMRegistry >> collect: aBlock [
	^{ self } collect: aBlock
]

{ #category : #extention }
FogEVMRegistry >> extendRepresentationTo: aFogEVMRegistry [
	<doc:
		'Returns a new registry with the same content, but with a byte length as the given parameter. The parameter is expected to be a registry with the value of the new length.'>
	aFogEVMRegistry unsignedValue > 31
		ifTrue: [ ^ self ].
	^ FogEVMRegistry forValue: self signedValue bytesLength: aFogEVMRegistry unsignedValue + 1
]

{ #category : #converting }
FogEVMRegistry >> headlessHexa [
	| hex |
	hex := self hex.
	
	^  hex copyFrom: 4 to: hex size 
]

{ #category : #testing }
FogEVMRegistry >> hex [
	^ value hex
]

{ #category : #flow }
FogEVMRegistry >> ifTrue: aBlockClosure ifFalse: aBlockClosure2 [
	<doc: 'For making easier the usage, we implement ifTrue:ifFalse: message, using our own definition of True and False'>
	^ self unsignedValue == 0
		ifFalse: aBlockClosure
		ifTrue: aBlockClosure2
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

{ #category : #'bitwise logical operations' }
FogEVMRegistry >> not [
	<doc: 'Returns the registry for the value of the NOT bitwise logical operation. The result uses a 32 bytes mask'>
	^ self class forValue: (self unsignedValue bitXor: mask) bytesLength: 32
]

{ #category : #testing }
FogEVMRegistry >> printOn: aStream [
	aStream nextPutAll: ('{1}' format: {self hex asString copyReplaceAll:'16r' with:'0x'})
]

{ #category : #arithmetics }
FogEVMRegistry >> signedDivision: aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the signed-entire division operation. The result uses a mask as the registry on the right side of the operation'>
	| sign |
	sign := ((self isPositive and: [ aFogEVMRegistry isPositive ]) or: (self isPositive not and: [ aFogEVMRegistry isPositive not ]))
		ifTrue: [ 1 ]
		ifFalse: [ -1 ].
	^ FogEVMRegistry forWordSizeValue: self signedValue abs // aFogEVMRegistry signedValue abs * sign 
]

{ #category : #comparing }
FogEVMRegistry >> signedGreaterThan: aFogEVMRegistry [
	<doc: 'Returns the registry for the value True or False, according to the comparing operation "Is Greater Than". Both values use a 1 byte representation'>
	^ self signedValue > aFogEVMRegistry signedValue
		ifTrue: [ FogEVMRegistry true ]
		ifFalse: [ FogEVMRegistry false ]
]

{ #category : #comparing }
FogEVMRegistry >> signedLesserThan: aFogEVMRegistry [
	<doc: 'Returns the registry for the value True or False, according to the comparing operation "Is Lesser Than". Both values use a 1 byte representation'>
	^ self signedValue < aFogEVMRegistry signedValue
		ifTrue: [ FogEVMRegistry true ]
		ifFalse: [ FogEVMRegistry false ]
]

{ #category : #'bit manipulation' }
FogEVMRegistry >> signedRightShift: aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the sign-aware shift-right operation'>
	^ aFogEVMRegistry signedValue abs < 256
		ifTrue: [ FogEVMRegistry forWordSizeValue: self signedValue >> aFogEVMRegistry signedValue ]
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

{ #category : #arithmetics }
FogEVMRegistry >> smod: aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the signed modulo operation. The result uses a mask as the registry on the right side of the operation'>
	| x y val |
	y := aFogEVMRegistry signedValue.
	val := y = 0
		ifTrue: [ 0 ]
		ifFalse: [ x := self signedValue.
			x sign * (x abs \\ y abs) ].
	^ FogEVMRegistry forWordSizeValue: val
]

{ #category : #interval }
FogEVMRegistry >> to: aFogEVMRegistry [
	^ (self unsignedValue to: aFogEVMRegistry unsignedValue)
		collect: [ :n | FogEVMRegistry forValue: n bytesLength: 32 ]
]

{ #category : #comparing }
FogEVMRegistry >> unsignedGreaterThan: aFogEVMRegistry [
	<doc: 'Returns the registry for the value True or False, according to the comparing operation "Unsigned Is Greater Than". Both values use a 1 byte representation'>
	^ self unsignedValue > aFogEVMRegistry unsignedValue
		ifTrue: [ FogEVMRegistry true ]
		ifFalse: [ FogEVMRegistry false ]
]

{ #category : #comparing }
FogEVMRegistry >> unsignedLesserThan: aFogEVMRegistry [
	<doc: 'Returns the registry for the value True or False, according to the comparing operation "Unsigned Is Lesser Than". Both values use a 1 byte representation'>
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

{ #category : #'bitwise logical operations' }
FogEVMRegistry >> xor: aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the XOR bitwise logical operation. The result uses a 32 bytes mask'>
	^ (self booleanValue xor: aFogEVMRegistry booleanValue)
		ifTrue: [ self class true ]
		ifFalse: [ self class false ]
]

{ #category : #'bitwise logical operations' }
FogEVMRegistry >> | aFogEVMRegistry [
	<doc: 'Returns the registry for the value of the OR bitwise logical operation. The result uses a 32 bytes mask'>
		^ self class forValue: (self unsignedValue bitOr: aFogEVMRegistry unsignedValue) bytesLength: 32
]
