"
Storage layout basic protocol 
"
Class {
	#name : #FogEVMAbstractLayout,
	#superclass : #Object,
	#category : #'FogEVM-Environment-Storage'
}

{ #category : #accessing }
FogEVMAbstractLayout >> address: anAddress [

]

{ #category : #accessing }
FogEVMAbstractLayout >> atStorage: anAddress put: aValue [
	self subclassResponsibility
]

{ #category : #accessing }
FogEVMAbstractLayout >> getStorageAt: anIndex [
	^ self subclassResponsibility 
]

{ #category : #accessing }
FogEVMAbstractLayout >> getStorageAt: anIndex ifAbsent: aBlock [
	self subclassResponsibility
]
