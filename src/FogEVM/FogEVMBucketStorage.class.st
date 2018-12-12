"
Contract storage represents the entry point of the storage. It layout 
"
Class {
	#name : #FogEVMBucketStorage,
	#superclass : #Object,
	#instVars : [
		'address',
		'storage'
	],
	#category : #'FogEVM-Environment-Storage'
}

{ #category : #read }
FogEVMBucketStorage >> account [
	^ self isContract ifTrue: [ self contract ] ifFalse: [ self externalAccount ]
]

{ #category : #write }
FogEVMBucketStorage >> addBalance: aValue [
	| currentValue |
	currentValue := self balance + aValue.
	storage atStorage: #'&balance' put: currentValue
]

{ #category : #initialization }
FogEVMBucketStorage >> address: anAddress [
	address := anAddress
]

{ #category : #read }
FogEVMBucketStorage >> at: anIndex [
	^ storage getStorageAt: anIndex
]

{ #category : #write }
FogEVMBucketStorage >> atStorage: anAddress put: aValue [
	storage atStorage: anAddress put: aValue
]

{ #category : #read }
FogEVMBucketStorage >> balance [
	^ storage getStorageAt: #'&balance'
]

{ #category : #read }
FogEVMBucketStorage >> contract [
	^ storage getStorageAt: #'&contract' ifAbsent: [ self error: 'The account is not a contract' ].
]

{ #category : #write }
FogEVMBucketStorage >> contract: aFogEVMContract [ 
	^ storage atStorage:#'&contract' put: aFogEVMContract 
]

{ #category : #read }
FogEVMBucketStorage >> destroyed [
	^ (storage getStorageAt: #'&destroyed') = FogEVMRegistry zero
		ifTrue: [ FogEVMRegistry false ]
		ifFalse: [ FogEVMRegistry true ]
]

{ #category : #'debugger ui' }
FogEVMBucketStorage >> entries [
	^ storage entries
]

{ #category : #read }
FogEVMBucketStorage >> externalAccount [
	^ storage
		getStorageAt: #'&externalAccount'
		ifAbsent: [ self error: 'The account is not an external account' ]
]

{ #category : #write }
FogEVMBucketStorage >> externalAccount: aFogEVMExternalAccount [
	storage atStorage: #'&externalAccount' put: aFogEVMExternalAccount
]

{ #category : #read }
FogEVMBucketStorage >> getStorageAt: anIndex [
	^ storage getStorageAt: anIndex
]

{ #category : #initialization }
FogEVMBucketStorage >> initialize [
	storage := FogEVMMemoryLayout new.
]

{ #category : #accessing }
FogEVMBucketStorage >> isContract [
	storage getStorageAt: #'&contract' ifAbsent: [ ^ false ].
	^ true
]

{ #category : #accessing }
FogEVMBucketStorage >> printOn: aStream [
	aStream nextPutAll:'Storage'; nextPutAll: ' ('.
	address printOn: aStream.
	aStream nextPutAll: ') - '.
	aStream nextPutAll: self class name 
]

{ #category : #write }
FogEVMBucketStorage >> setDestroyed [
	^ storage atStorage: #'&destroyed' put: true .
]

{ #category : #write }
FogEVMBucketStorage >> withdrawBalance [
	| balance |
	balance := self balance.
	self addBalance: balance * FogEVMRegistry minusOne.
	^ balance
]
