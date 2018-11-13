"
Contract storage represents the entry point of the storage. It layout 
"
Class {
	#name : #FogEVMBucketStorage,
	#superclass : #Object,
	#instVars : [
		'storage'
	],
	#category : #'FogEVM-Environment-Storage'
}

{ #category : #accessing }
FogEVMBucketStorage >> account [
	^ self isContract ifTrue: [ self contract ] ifFalse: [ self externalAccount ]
]

{ #category : #'balance adding' }
FogEVMBucketStorage >> addBalance: aValue [
	| currentValue |
	currentValue := self balance + aValue.
	storage atStorage: #'&balance' put: currentValue
]

{ #category : #accessing }
FogEVMBucketStorage >> atStorage: anAddress put: aValue [
	storage atStorage: anAddress put: aValue
]

{ #category : #initialization }
FogEVMBucketStorage >> balance [
	^ storage getStorageAt: #'&balance'
]

{ #category : #accessing }
FogEVMBucketStorage >> contract [
	^ storage getStorageAt: #'&contract' ifAbsent: [ self error: 'The account is not a contract' ].
]

{ #category : #accessing }
FogEVMBucketStorage >> contract: aFogEVMContract [ 
	^ storage atStorage:#'&contract' put: aFogEVMContract 
]

{ #category : #initialization }
FogEVMBucketStorage >> destroyed [
	^ (storage getStorageAt: #'&destroyed') = FogEVMRegistry zero
		ifTrue: [ FogEVMRegistry false ]
		ifFalse: [ FogEVMRegistry true ]
]

{ #category : #accessing }
FogEVMBucketStorage >> externalAccount [
	^ storage
		getStorageAt: #'&externalAccount'
		ifAbsent: [ self error: 'The account is not an external account' ]
]

{ #category : #accessing }
FogEVMBucketStorage >> externalAccount: aFogEVMExternalAccount [
	storage atStorage: #'&externalAccount' put: aFogEVMExternalAccount
]

{ #category : #initialization }
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

{ #category : #initialization }
FogEVMBucketStorage >> setDestroyed [
	^ storage atStorage: #'&destroyed' put: true .
]

{ #category : #'debugger ui' }
FogEVMBucketStorage >> values [
	^ storage values
]

{ #category : #accessing }
FogEVMBucketStorage >> withdrawBalance [
	| balance |
	balance := self balance.
	self addBalance: balance * FogEVMRegistry minusOne.
	^ balance
]
