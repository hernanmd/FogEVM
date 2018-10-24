"
Contract storage represents the entry point of the storage. It layout 
"
Class {
	#name : #FogEVMBucketStorage,
	#superclass : #Object,
	#instVars : [
		'storage'
	],
	#category : #'FogEVM-Storage'
}

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

{ #category : #initialization }
FogEVMBucketStorage >> destroyed [
	^ (storage getStorageAt: #'&destroyed') = FogEVMRegistry zero
		ifTrue: [ FogEVMRegistry false ]
		ifFalse: [ FogEVMRegistry true ]
]

{ #category : #initialization }
FogEVMBucketStorage >> getStorageAt: anIndex [
	^ storage getStorageAt: anIndex
]

{ #category : #initialization }
FogEVMBucketStorage >> initialize [
	storage := FogEVMMemoryLayout new.
]

{ #category : #initialization }
FogEVMBucketStorage >> setDestroyed [
	^ storage atStorage: #'&destroyed' put: true .
]

{ #category : #accessing }
FogEVMBucketStorage >> withdrawBalance [
	| balance |
	balance := self balance.
	self addBalance: balance * FogEVMRegistry minusOne.
	^ balance
]
