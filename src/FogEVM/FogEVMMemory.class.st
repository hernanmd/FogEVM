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

{ #category : #accessing }
FogEVMMemory >> ensureAddressAvailable: anAddress [
	| newArray |
	anAddress > layout size
		ifFalse: [ ^ self ].
	newArray := ByteArray new: anAddress + FogEVMInterpreter wordSize.
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

{ #category : #'as yet unclassified' }
FogEVMMemory >> sizeInBytes [
	^ layout size
]

{ #category : #'as yet unclassified' }
FogEVMMemory >> store: aValue at: anAddress [
	self ensureAddressAvailable: anAddress. 	
	layout at: anAddress put: aValue

]

{ #category : #accessing }
FogEVMMemory >> storeWord: aRegistry startingAt: aRegistryAddress [
	| address stream |
	address := aRegistryAddress unsignedValue.
	stream := aRegistry asWordByteArray readStream.
	address to: address + FogEVMInterpreter wordSize - 1 do: [ :i | self store: stream next at: address ]
]
