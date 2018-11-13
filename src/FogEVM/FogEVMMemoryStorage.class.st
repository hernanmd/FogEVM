Class {
	#name : #FogEVMMemoryStorage,
	#superclass : #Object,
	#instVars : [
		'dictionary',
		'storageClass'
	],
	#category : #'FogEVM-Environment-Storage'
}

{ #category : #accessing }
FogEVMMemoryStorage >> at: aKey [
	^ self storage at: aKey
]

{ #category : #'debugger ui' }
FogEVMMemoryStorage >> entries [
	^ self storage values 
]

{ #category : #'debugger ui' }
FogEVMMemoryStorage >> printOn: aStream [
	aStream nextPutAll: ' Node storage - ('.
	aStream
		nextPutAll: self storage size asString;
		nextPutAll: ' entries) - ';
		nextPutAll: self class name
]

{ #category : #accessing }
FogEVMMemoryStorage >> storage [
	^ dictionary ifNil: [ dictionary := Dictionary new ]
]

{ #category : #accessing }
FogEVMMemoryStorage >> storageFor: aContractAddress state: aStateHash [
	self flag: #WeshouldCareAboutTheMerkelTreeState.
	^ self storage
		at: aContractAddress
		ifAbsentPut: [ FogEVMBucketStorage new
				address: aContractAddress;
				yourself ]
]
