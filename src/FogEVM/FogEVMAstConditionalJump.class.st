Class {
	#name : #FogEVMAstConditionalJump,
	#superclass : #FogEVMAstNode,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'address',
		'condition',
		'destination',
		'jumpDestination'
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
	^ jumpDestination scope
]

{ #category : #testing }
FogEVMAstConditionalJump >> isConditionalJump [
	^ true
]

{ #category : #testing }
FogEVMAstConditionalJump >> isJump [
	^ true
]

{ #category : #accessing }
FogEVMAstConditionalJump >> jumpDestination [
	^ jumpDestination
]

{ #category : #accessing }
FogEVMAstConditionalJump >> jumpDestination: aFogEVMAstJumpDestination [
	jumpDestination := aFogEVMAstJumpDestination
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
