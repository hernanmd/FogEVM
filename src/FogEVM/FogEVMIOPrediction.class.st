Class {
	#name : #FogEVMIOPrediction,
	#superclass : #Object,
	#instVars : [
		'stack',
		'memoryReadAddresses',
		'memoryWriteAddresses',
		'storageReadAddresses',
		'storageWriteAddresses'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #accessing }
FogEVMIOPrediction >> getExpectedPopInformationFor: anInstruction [
	| args stackPointer |
	args := OrderedCollection new.
	stackPointer := stack firstLink.
	1 to: anInstruction expectedPops do: [ :idx | 
		args add: stackPointer value.
		stackPointer := stackPointer nextLink ].
	^ args
]

{ #category : #intervals }
FogEVMIOPrediction >> getStorageAt: aFogEVMRegistry [ 
	^ self loadWord: aFogEVMRegistry
]

{ #category : #accessing }
FogEVMIOPrediction >> initialize [
	super initialize.
	memoryReadAddresses := OrderedCollection new.
	memoryWriteAddresses := OrderedCollection new.
	storageReadAddresses := OrderedCollection new.
	storageWriteAddresses := OrderedCollection new
]

{ #category : #accessing }
FogEVMIOPrediction >> interval: first to: second [
	^ first to: second
]

{ #category : #accesssing }
FogEVMIOPrediction >> loadFrom: from bytes: to [
	^ self interval: from to: from + to
]

{ #category : #visiting }
FogEVMIOPrediction >> loadWord: first [
	^ self
		interval: first
		to: (first + FogEVMSimulatorInterpreter wordSizeRegistry - FogEVMRegistry one)
]

{ #category : #accessing }
FogEVMIOPrediction >> loadWords: first to: second [
	^ self interval: first to: first + second - FogEVMRegistry one
]

{ #category : #accessing }
FogEVMIOPrediction >> memoryReadAddresses [
	^ memoryReadAddresses
]

{ #category : #accessing }
FogEVMIOPrediction >> memoryWriteAddresses [
	^ memoryWriteAddresses
]

{ #category : #accessing }
FogEVMIOPrediction >> stack: aCollection [
	stack := aCollection
]

{ #category : #accessing }
FogEVMIOPrediction >> storageReadAddresses [
	^ storageReadAddresses
]

{ #category : #accessing }
FogEVMIOPrediction >> storeFrom: from offset: to [ 
	^ self loadFrom: from bytes: to
]

{ #category : #accessing }
FogEVMIOPrediction >> storeWordAt: aFogEVMRegistry [ 
	^ self loadWord: aFogEVMRegistry
]

{ #category : #'as yet unclassified' }
FogEVMIOPrediction >> visitCalldatacopy: aFogVMCalldatacopy [
	| data |
	data := self getExpectedPopInformationFor: aFogVMCalldatacopy.
	memoryWriteAddresses addAll: (self storeFrom: data first offset: data third)
]

{ #category : #'as yet unclassified' }
FogEVMIOPrediction >> visitCodecopy: aFogVMCodecopy [ 
	| data |
	data := self getExpectedPopInformationFor: aFogVMCodecopy.
	memoryWriteAddresses addAll: (self storeFrom: data first offset: data third )
]

{ #category : #visiting }
FogEVMIOPrediction >> visitMload: aFogVMMload [
	| data |
	data := self getExpectedPopInformationFor: aFogVMMload.
	memoryReadAddresses addAll: (self loadWord: data first)
]

{ #category : #visiting }
FogEVMIOPrediction >> visitMstore: aFogVMMstore [
	| data |
	data := self getExpectedPopInformationFor: aFogVMMstore.
	memoryWriteAddresses addAll: (self storeWordAt: data first)
]

{ #category : #accessing }
FogEVMIOPrediction >> visitReturn: aFogVMReturn [
	| data |
	data := self getExpectedPopInformationFor: aFogVMReturn.
	memoryReadAddresses addAll: (self loadFrom: data first bytes: data second)
]

{ #category : #accessing }
FogEVMIOPrediction >> visitSha3: aFogVMSha3 [
	| data |
	data := self getExpectedPopInformationFor: aFogVMSha3.
	memoryReadAddresses addAll: (self loadWords: data first to: data second)
]

{ #category : #visiting }
FogEVMIOPrediction >> visitSload: aFogVMSload [
	| data |
	data := self getExpectedPopInformationFor: aFogVMSload.
	storageReadAddresses addAll: (self getStorageAt: data first)
]
