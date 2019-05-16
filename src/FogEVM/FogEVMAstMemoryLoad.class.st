Class {
	#name : #FogEVMAstMemoryLoad,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'fromAddress',
		'amountOfBytes'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstMemoryLoad >> accept: aFogEVMAstVariableWiperVisitor [
	aFogEVMAstVariableWiperVisitor visitMemoryLoad: self
]

{ #category : #'as yet unclassified' }
FogEVMAstMemoryLoad >> amountOfBytes [
	^ amountOfBytes
]

{ #category : #'as yet unclassified' }
FogEVMAstMemoryLoad >> amountOfBytes: aFogEVMLiteral [ 
	amountOfBytes := aFogEVMLiteral
]

{ #category : #'as yet unclassified' }
FogEVMAstMemoryLoad >> fromAddress [
	^ fromAddress
]

{ #category : #'as yet unclassified' }
FogEVMAstMemoryLoad >> fromAddress: aFogEVMAstVariable [ 
	fromAddress := aFogEVMAstVariable
]

{ #category : #printing }
FogEVMAstMemoryLoad >> printOn: aStream [
	aStream nextPutAll: '(memory at:'.
	fromAddress printOn: aStream.
	aStream nextPutAll: ' read: '.
	amountOfBytes printOn: aStream.
	aStream nextPutAll: ') '
]

{ #category : #unifying }
FogEVMAstMemoryLoad >> unify: aFogEVMAstVariable with: aFogEVMLiteral [
	amountOfBytes = aFogEVMAstVariable
		ifTrue: [ amountOfBytes := aFogEVMLiteral ].
	fromAddress = aFogEVMAstVariable
		ifTrue: [ fromAddress := aFogEVMLiteral ]
]
