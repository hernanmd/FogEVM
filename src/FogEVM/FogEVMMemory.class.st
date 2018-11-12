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
	^ layout copyFrom: anInteger + 1 to: anInteger2 + 1
]

{ #category : #accessing }
FogEVMMemory >> ensureAddressAvailable: anAddress size: size [
	| newArray |
	(anAddress + 1 + size) >= layout size
		ifFalse: [ ^ self ].
	newArray := ByteArray new: anAddress + 1 + size .
	newArray
		replaceFrom: 1
		to: layout size
		with: layout
		startingAt: 1.
	layout := newArray
]

{ #category : #initialization }
FogEVMMemory >> initialize [
	super initialize.
	layout := ByteArray new: 0. 
]

{ #category : #accessing }
FogEVMMemory >> isEmptyOrNil [
	self shouldBeImplemented.
]

{ #category : #accessing }
FogEVMMemory >> loadFrom: anAddress bytes: aSize [
	^ self copyFrom: anAddress to: anAddress + aSize - 1
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
	| address offset  |
	address := addressRegistry unsignedValue.
	offset := offsetRegistry unsignedValue. 
	^ self copyFrom: address to: address + offset
]

{ #category : #initialization }
FogEVMMemory >> restart [
	self initialize.
]

{ #category : #'as yet unclassified' }
FogEVMMemory >> set: aValue at: anAddress [
	layout at: anAddress + 1 put: aValue
]

{ #category : #'as yet unclassified' }
FogEVMMemory >> sizeInBytes [
	^ layout size
]

{ #category : #accessing }
FogEVMMemory >> slotSize [
	^ 32 
]

{ #category : #accessing }
FogEVMMemory >> store: aByteArray at: anAddress ensure: aLength [
	self ensureAddressAvailable: anAddress size: aLength.
	1 to: aLength do: [ :idx | self set: (aByteArray at: idx) at: anAddress + idx - 1 ]
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
FogEVMMemory >> storeSize [
	^ layout size
]

{ #category : #accessing }
FogEVMMemory >> storeWord: aRegistry startingAt: aRegistryAddress [
	| address stream |
	address := aRegistryAddress unsignedValue.
	stream := aRegistry asWordByteArray readStream.
	self ensureAddressAvailable: address size: FogEVMInterpreter wordSize.
	address to: address + FogEVMInterpreter wordSize - 1 do: [ :i | self set: stream next at: i ]
]
