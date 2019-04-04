Class {
	#name : #FogEVMAstMemoryStore,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'address',
		'value',
		'isByteStore'
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
FogEVMAstMemoryStore >> isByteStore [
	^ isByteStore ifNil: [ false ]
]

{ #category : #accessing }
FogEVMAstMemoryStore >> isByteStore: aValue [
	isByteStore := aValue
]

{ #category : #printing }
FogEVMAstMemoryStore >> printOn: aStream [
	aStream nextPutAll: '(memory at:'.
	address printOn: aStream.
	aStream nextPutAll: ' put: '.
	value printOn: aStream.
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
