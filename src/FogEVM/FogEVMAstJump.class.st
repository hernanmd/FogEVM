Class {
	#name : #FogEVMAstJump,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'address'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstJump >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitJump: self 
]

{ #category : #'as yet unclassified' }
FogEVMAstJump >> address [
	^ address
]

{ #category : #accessing }
FogEVMAstJump >> address: aFogEVMAstVariable [ 
	address := aFogEVMAstVariable
]

{ #category : #testing }
FogEVMAstJump >> deepCopy [
	^ self 
]

{ #category : #testing }
FogEVMAstJump >> isJump [
	^ true
]

{ #category : #testing }
FogEVMAstJump >> isStrictJump [
	^ true
]

{ #category : #testing }
FogEVMAstJump >> printOn: aStream [
	aStream nextPutAll: ' interpreter jumpTo: '.
	address printOn: aStream. 
]

{ #category : #unifying }
FogEVMAstJump >> unify: aFogEVMAstVariable with: aFogEVMLiteral [
	self assert: address = aFogEVMAstVariable.
	address = aFogEVMAstVariable
		ifTrue: [ address := aFogEVMLiteral ]
]
