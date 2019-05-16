Class {
	#name : #FogEVMAstStorageLoad,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'address',
		'amount'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstStorageLoad >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitStorageLoad: self 
]

{ #category : #'as yet unclassified' }
FogEVMAstStorageLoad >> address [
	^ address
]

{ #category : #'as yet unclassified' }
FogEVMAstStorageLoad >> address: aFogEVMAstVariable [ 
	address := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstStorageLoad >> amount [
	^ amount
]

{ #category : #accessing }
FogEVMAstStorageLoad >> amount: aFogEVMLiteral [
	amount := aFogEVMLiteral
]

{ #category : #testing }
FogEVMAstStorageLoad >> isStorageAccess [
	^ true
]

{ #category : #printing }
FogEVMAstStorageLoad >> printOn: aStream [
	aStream nextPutAll: '(storage at: '.
	address printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #'as yet unclassified' }
FogEVMAstStorageLoad >> resolve [
	self shouldBeImplemented.
]

{ #category : #unifying }
FogEVMAstStorageLoad >> unify: aFogEVMAstVariable with: aFogEVMLiteral [
	address = aFogEVMAstVariable
		ifTrue: [ address := aFogEVMLiteral ].
	amount = aFogEVMAstVariable
		ifTrue: [ amount := aFogEVMLiteral ]
]
