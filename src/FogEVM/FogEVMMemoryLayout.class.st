"
Memory layout, it implements a key-value storage by using a dictionary. Cheap to implement, expensive to use. Easy to debug 
"
Class {
	#name : #FogEVMMemoryLayout,
	#superclass : #FogEVMAbstractLayout,
	#instVars : [
		'dictionary'
	],
	#category : #'FogEVM-Environment-Storage'
}

{ #category : #accessing }
FogEVMMemoryLayout >> atStorage: anAddress put: aValue [
	^ dictionary at: anAddress put: aValue
]

{ #category : #accessing }
FogEVMMemoryLayout >> getStorageAt: anIndex [
	^ self getStorageAt: anIndex ifAbsent: [ FogEVMRegistry zero ]
]

{ #category : #accessing }
FogEVMMemoryLayout >> getStorageAt: anIndex ifAbsent: aBlock [
	^ dictionary at: anIndex ifAbsent: aBlock
]

{ #category : #initialization }
FogEVMMemoryLayout >> initialize [
	super initialize .
	dictionary := Dictionary new.
]

{ #category : #'debugger ui' }
FogEVMMemoryLayout >> values [
	^ dictionary 
]
