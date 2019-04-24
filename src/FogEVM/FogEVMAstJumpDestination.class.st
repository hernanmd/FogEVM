Class {
	#name : #FogEVMAstJumpDestination,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'address',
		'scope',
		'origin'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstJumpDestination >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitJumpTag: self 
]

{ #category : #printing }
FogEVMAstJumpDestination >> addOrigin: aJump [
	origin add: aJump
]

{ #category : #'as yet unclassified' }
FogEVMAstJumpDestination >> address [
	^ address
]

{ #category : #'as yet unclassified' }
FogEVMAstJumpDestination >> address: anInteger [ 
	address := anInteger
]

{ #category : #accessing }
FogEVMAstJumpDestination >> deepCopy [
	^ self 
]

{ #category : #accessing }
FogEVMAstJumpDestination >> destination [
	^ self 
]

{ #category : #printing }
FogEVMAstJumpDestination >> initialize [
	super initialize.
	origin := Set new
]

{ #category : #testing }
FogEVMAstJumpDestination >> isJumpDest [
	^ true 
]

{ #category : #accessing }
FogEVMAstJumpDestination >> jumpDestination [
	^ self 
]

{ #category : #printing }
FogEVMAstJumpDestination >> printOn: aStream [
	aStream
		nextPutAll: '" -> ';
		nextPutAll: (address write0xHexadecimal: 8);
		nextPutAll: ' "'
]

{ #category : #accessing }
FogEVMAstJumpDestination >> scope [
	^ scope
]

{ #category : #accessing }
FogEVMAstJumpDestination >> scope: aFogEVMAstScope [
	scope := aFogEVMAstScope
]
