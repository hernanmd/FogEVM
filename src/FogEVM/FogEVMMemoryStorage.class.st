Class {
	#name : #FogEVMMemoryStorage,
	#superclass : #Object,
	#instVars : [
		'dictionary',
		'storageClass',
		'name'
	],
	#classInstVars : [
		'instances'
	],
	#category : #'FogEVM-Environment-Storage'
}

{ #category : #accessing }
FogEVMMemoryStorage class >> instances [
	^ instances ifNil: [ instances := Set new ]
]

{ #category : #accessing }
FogEVMMemoryStorage class >> named: aName [
	^ self new
		name: aName;
		yourself
]

{ #category : #accessing }
FogEVMMemoryStorage class >> new [
	^ self instances add: super new
]

{ #category : #accessing }
FogEVMMemoryStorage >> allDeployedContracts [
	dictionary ifNil: [ ^ {} ].
	^ dictionary values select: #isContract thenCollect: [ :b | b contract address ]
]

{ #category : #accessing }
FogEVMMemoryStorage >> at: aKey [
	^ self storage at: aKey
]

{ #category : #accessing }
FogEVMMemoryStorage >> initialize [
	super initialize.
	name := UUID new asString
]

{ #category : #accessing }
FogEVMMemoryStorage >> name [
	^ String streamContents: [ :str | self printOn: str ]
]

{ #category : #accessing }
FogEVMMemoryStorage >> name: aName [
	name := aName
]

{ #category : #printing }
FogEVMMemoryStorage >> printOn: aStream [
	aStream nextPutAll: ' Node storage - ('.
	aStream
		nextPutAll: self storage size asString;
		nextPutAll: ' entries) - ';
		nextPutAll: name
]

{ #category : #accessing }
FogEVMMemoryStorage >> storage [
	^ dictionary ifNil: [ dictionary := Dictionary new ]
]

{ #category : #accessing }
FogEVMMemoryStorage >> storageFor: aContractAddress state: aStateHash [
	^ self storage
		at: aContractAddress
		ifAbsentPut: [ FogEVMBucketStorage new
				address: aContractAddress;
				yourself ]
]

{ #category : #accessing }
FogEVMMemoryStorage >> storageFor: aContractAddress state: aString ifAbsent: aBlockClosure [
	^ self storage at: aContractAddress ifAbsent: [ aBlockClosure value ]
]
