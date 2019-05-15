Class {
	#name : #FogEVMProxyLayout,
	#superclass : #FogEVMAbstractLayout,
	#instVars : [
		'internal',
		'contract',
		'address',
		'session'
	],
	#category : #'FogEVM-Environment-Storage'
}

{ #category : #accessing }
FogEVMProxyLayout >> address: anAddress [
	address := anAddress
]

{ #category : #accessing }
FogEVMProxyLayout >> atStorage: anAddress put: aValue [
	internal atStorage: anAddress put: aValue
]

{ #category : #accessing }
FogEVMProxyLayout >> contract [
	^ contract
		ifNil: [ contract := session
				findContractInstanceByHash: address
				blockTag: #latest ]
]

{ #category : #accessing }
FogEVMProxyLayout >> contract: aContract [
	contract := aContract
]

{ #category : #accessing }
FogEVMProxyLayout >> entries [
	^ internal entries
]

{ #category : #accessing }
FogEVMProxyLayout >> getStorageAt: anIndex [
	^ self getStorageAt: anIndex ifAbsent: [ FogEVMRegistry zero ]
]

{ #category : #accessing }
FogEVMProxyLayout >> getStorageAt: anIndex ifAbsent: aBlock [
	^ internal
		getStorageAt: anIndex
		ifAbsent: [ | value |
			anIndex isNumber
				ifTrue: [ value := contract fetchSlot: anIndex at: #latest ]
				ifFalse: [ value := '0x' ].
			value = '0x'
				ifTrue: [ aBlock value ]
				ifFalse: [ self atStorage: anIndex put: value.
					value ] ]
]

{ #category : #accessing }
FogEVMProxyLayout >> initialize [
	super initialize.
	internal := FogEVMMemoryLayout new
]

{ #category : #accessing }
FogEVMProxyLayout >> session: aSession [
	session := aSession
]
