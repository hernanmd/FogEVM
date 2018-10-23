"
This class represents a continuum memory segment. 

"
Class {
	#name : #FogEVMMemory,
	#superclass : #Object,
	#instVars : [
		'layout'
	],
	#category : 'FogEVM-Memory'
}

{ #category : #getting }
FogEVMMemory >> copyFrom: anInteger to: anInteger2 [ 
	^ layout copyFrom: anInteger to: anInteger2 
]

{ #category : #accessing }
FogEVMMemory >> ensureAddressAvailable: anAddress size: size [
	| newArray |
	anAddress > layout size
		ifFalse: [ ^ self ].
	newArray := ByteArray new: anAddress + size.
	newArray
		replaceFrom: 1
		to: layout size
		with: layout
		startingAt: 1.
	layout := newArray
]

{ #category : #'as yet unclassified' }
FogEVMMemory >> fetchFrom: anHexaAddressFrom to: anHexaAddressTo [
	| value |
	value := '' writeStream.
	value nextPutAll: '0x'.
	anHexaAddressFrom asBKNumber to: anHexaAddressTo asBKNumber - 1 do: [ :id | 
		| memoryValue |
		memoryValue := self fetchValue: id asBKHexa.
		value nextPutAll: (memoryValue copyFrom: 3 to: memoryValue size) ].
	^ value contents
]

{ #category : #'as yet unclassified' }
FogEVMMemory >> fetchValue: aString [
	^ layout at: aString ifAbsent: [ (layout associations detect: [ :a | a key asBKNumber = aString asBKNumber ] ifNone: [ layout at: aString put: 0 asBKHexa ]) value ]
]

{ #category : #initialization }
FogEVMMemory >> initialize [
	super initialize.
	layout := ByteArray new: 0. 
]

{ #category : #accessing }
FogEVMMemory >> loadFrom: anAddress bytes: aSize [
	^ layout copyFrom: anAddress to: anAddress + aSize 
]

{ #category : #loading }
FogEVMMemory >> loadWord: aFogEVMRegistry [
	| address value |
	address := aFogEVMRegistry unsignedValue.
	value := self copyFrom: address to: address + FogEVMInterpreter wordSize - 1.
	^ FogEVMRegistry forValue: value asInteger bytesLength: FogEVMInterpreter wordSize
]

{ #category : #load }
FogEVMMemory >> loadWords: addressRegistry to: offsetRegistry [
	| address offset value |
	address := addressRegistry unsignedValue.
	offset := offsetRegistry unsignedValue. 
	^ self copyFrom: address to: address + offset
]

{ #category : #'as yet unclassified' }
FogEVMMemory >> set: aValue at: anAddress [
	layout at: anAddress put: aValue
]

{ #category : #'as yet unclassified' }
FogEVMMemory >> sizeInBytes [
	^ layout size
]

{ #category : #accessing }
FogEVMMemory >> store: aByteArray at: anAddress ensure: aLength [
	self ensureAddressAvailable: anAddress size: aLength.
	1 to: aLength do: [ :idx | layout at: anAddress + idx - 1 put: (aByteArray at: idx) ]
]

{ #category : #accessing }
FogEVMMemory >> storeByte: aRegistry at: aRegistryAddress [
	| address value |
	address := aRegistryAddress unsignedValue.
	value := FogEVMRegistry forValue: aRegistry unsignedValue bytesLength: 1.
	self ensureAddressAvailable: address size: 1.
	self set: value asByteArray first at: address
]

{ #category : #accessing }
FogEVMMemory >> storeWord: aRegistry startingAt: aRegistryAddress [
	| address stream |
	address := aRegistryAddress unsignedValue.
	stream := aRegistry asWordByteArray readStream.
	self ensureAddressAvailable: address size: FogEVMInterpreter wordSize.
	address to: address + FogEVMInterpreter wordSize - 1 do: [ :i | self set: stream next at: i ]
]
