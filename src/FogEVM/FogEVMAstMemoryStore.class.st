Class {
	#name : #FogEVMAstMemoryStore,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'address',
		'value',
		'isByteStore',
		'amount'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstMemoryStore >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitMemoryStore: self 
]

{ #category : #'as yet unclassified' }
FogEVMAstMemoryStore >> address [
	^ address
]

{ #category : #'as yet unclassified' }
FogEVMAstMemoryStore >> address: aFogEVMAstVariable [ 
	address := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstMemoryStore >> amount [
	^ amount
]

{ #category : #accessing }
FogEVMAstMemoryStore >> amount: anAmount [
	amount := anAmount
]

{ #category : #printing }
FogEVMAstMemoryStore >> printOn: aStream [
	aStream nextPutAll: '(memory at:'.
	address printOn: aStream.
	aStream nextPutAll: ' put: '.
	value printOn: aStream.
	aStream nextPutAll: ' size: '.
	amount printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #accessing }
FogEVMAstMemoryStore >> value [
	^ value
]

{ #category : #'as yet unclassified' }
FogEVMAstMemoryStore >> value: aFogEVMAstVariable [ 
	value := aFogEVMAstVariable
]
