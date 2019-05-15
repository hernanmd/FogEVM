"
Contract storage represents the entry point of the storage. It layout 
"
Class {
	#name : #FogEVMBucketStorage,
	#superclass : #Object,
	#instVars : [
		'address',
		'layout'
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
	layout atStorage: #'&balance' put: currentValue
]

{ #category : #initialization }
FogEVMBucketStorage >> address: anAddress [
	address := anAddress.
	layout address: address.
]

{ #category : #read }
FogEVMBucketStorage >> at: anIndex [
	^ layout getStorageAt: anIndex
]

{ #category : #write }
FogEVMBucketStorage >> atStorage: anAddress put: aValue [
	layout atStorage: anAddress put: aValue
]

{ #category : #read }
FogEVMBucketStorage >> balance [
	^ layout getStorageAt: #'&balance'
]

{ #category : #initialization }
FogEVMBucketStorage >> beLocal [ 
	layout := FogEVMMemoryLayout new
]

{ #category : #write }
FogEVMBucketStorage >> beProxified: aContract [
	| executing contract |
	layout := FogEVMProxyLayout new
		contract: aContract;
		yourself.
	executing := FogEVMByteCode fromBinary: aContract contract binary.
	contract := FogEVMContract new
		bytecode: executing;
		address: address asAddress ;
		yourself.
	self contract: contract
]

{ #category : #read }
FogEVMBucketStorage >> contract [
	^ layout
		getStorageAt: #'&contract'
		ifAbsent: [ self error: 'The account is not a contract' ]
]

{ #category : #write }
FogEVMBucketStorage >> contract: aFogEVMContract [ 
	^ layout atStorage:#'&contract' put: aFogEVMContract 
]

{ #category : #read }
FogEVMBucketStorage >> destroyed [
	^ (layout getStorageAt: #'&destroyed') = FogEVMRegistry zero
		ifTrue: [ FogEVMRegistry false ]
		ifFalse: [ FogEVMRegistry true ]
]

{ #category : #read }
FogEVMBucketStorage >> externalAccount [
	^ layout
		getStorageAt: #'&externalAccount'
		ifAbsent: [ self error: 'The account is not an external account' ]
]

{ #category : #write }
FogEVMBucketStorage >> externalAccount: aFogEVMExternalAccount [
	layout atStorage: #'&externalAccount' put: aFogEVMExternalAccount
]

{ #category : #read }
FogEVMBucketStorage >> getStorageAt: anIndex [
	^ layout getStorageAt: anIndex
]

{ #category : #initialization }
FogEVMBucketStorage >> initialize [
	self beLocal.
]

{ #category : #accessing }
FogEVMBucketStorage >> isContract [
	layout getStorageAt: #'&contract' ifAbsent: [ ^ false ].
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
	^ layout atStorage: #'&destroyed' put: true .
]

{ #category : #write }
FogEVMBucketStorage >> withdrawBalance [
	| balance |
	balance := self balance.
	self addBalance: balance * FogEVMRegistry minusOne.
	^ balance
]
