"
This class represents a continuum memory segment. 

"
Class {
	#name : #FogEVMMemory,
	#superclass : #Object,
	#instVars : [
		'layout'
	],
	#category : #'FogEVM-Environment-Memory'
}

{ #category : #read }
FogEVMMemory >> copyFrom: aNumber to: otherNumber [
	| to ret |
	to := layout size min: otherNumber.
	ret := (layout copyFrom: aNumber + 1 to: to) , (ByteArray new: otherNumber - to).
	self assert: ret size = (otherNumber - aNumber).
	^ ret
]

{ #category : #write }
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

{ #category : #read }
FogEVMMemory >> loadFrom: anAddress bytes: aSize [
	^ self copyFrom: anAddress to: anAddress + aSize 
]

{ #category : #read }
FogEVMMemory >> loadWord: aFogEVMRegistry [
	| address value |
	address := aFogEVMRegistry unsignedValue.
	value := self copyFrom: address to: address + FogEVMAbstractInterpreter wordSize.
	^ FogEVMRegistry forValue: value asInteger bytesLength: FogEVMAbstractInterpreter wordSize
]

{ #category : #read }
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

{ #category : #write }
FogEVMMemory >> set: aValue at: anAddress [
	layout at: anAddress +1 put: aValue
]

{ #category : #accessing }
FogEVMMemory >> sizeInBytes [
	^ layout size
]

{ #category : #accessing }
FogEVMMemory >> slotSize [
	^ 32 
]

{ #category : #write }
FogEVMMemory >> store: aByteArray at: anAddress ensure: aLength [
	self ensureAddressAvailable: anAddress size: aLength.
	1 to: aLength do: [ :idx | self set: (aByteArray at: idx) at: anAddress + idx - 1 ]
]

{ #category : #write }
FogEVMMemory >> storeByte: aRegistry at: aRegistryAddress [
	| address value |
	address := aRegistryAddress unsignedValue.
	value := FogEVMRegistry forValue: aRegistry unsignedValue bytesLength: 1.
	self ensureAddressAvailable: address size: 1.
	self set: value asByteArray first at: address
]

{ #category : #write }
FogEVMMemory >> storeSize [
	^ layout size
]

{ #category : #write }
FogEVMMemory >> storeWord: aRegistry startingAt: aRegistryAddress [
	| address stream acc |
	address := aRegistryAddress unsignedValue .
	stream := aRegistry asWordByteArray readStream.
	self ensureAddressAvailable: address size: FogEVMAbstractInterpreter wordSize.
	acc := 0. 
	address to: address + (FogEVMAbstractInterpreter wordSize -1 )do: [ :i | self set: stream next at: i. acc := acc +1. ].
	self assert: aRegistry unsignedValue = (self loadWord: aRegistryAddress) unsignedValue.
	self assert: acc = 32.
]
