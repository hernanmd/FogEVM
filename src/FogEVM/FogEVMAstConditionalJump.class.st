Class {
	#name : #FogEVMAstConditionalJump,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'address',
		'condition',
		'destination'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstConditionalJump >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitConditionalJump: self 
]

{ #category : #'as yet unclassified' }
FogEVMAstConditionalJump >> address [
	^ address
]

{ #category : #'as yet unclassified' }
FogEVMAstConditionalJump >> address: aFogEVMAstVariable [ 
	address := aFogEVMAstVariable
]

{ #category : #'as yet unclassified' }
FogEVMAstConditionalJump >> condition [
	^ condition
]

{ #category : #'as yet unclassified' }
FogEVMAstConditionalJump >> condition: aFogEVMAstVariable [ 
	condition := aFogEVMAstVariable
]

{ #category : #testing }
FogEVMAstConditionalJump >> deepCopy [
	^ self 
]

{ #category : #accessing }
FogEVMAstConditionalJump >> destination [
	^ destination
]

{ #category : #accessing }
FogEVMAstConditionalJump >> destination: aJumpDestination [
	destination := aJumpDestination
]

{ #category : #testing }
FogEVMAstConditionalJump >> isConditionalJump [
	^ true
]

{ #category : #testing }
FogEVMAstConditionalJump >> isJump [
	^ true
]

{ #category : #testing }
FogEVMAstConditionalJump >> printOn: aStream [
	aStream nextPutAll: '('.
	condition printOn: aStream.
	aStream nextPutAll: ') ifTrue: [ interpreter jumpTo: '.
	address  printOn: aStream.
	aStream nextPutAll: '] '
]

{ #category : #accessing }
FogEVMAstConditionalJump >> scope [
	^ destination
]
