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
	jumpDestination ifNil: [ ^ nil ].
	^ jumpDestination scope
]

{ #category : #'as yet unclassified' }
FogEVMAstConditionalJump >> instructions: aCollection [
	instructions := aCollection
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

{ #category : #removeing }
FogEVMAstConditionalJump >> removeNode: aFogEVMAssignation [ 

]

{ #category : #accessing }
FogEVMAstConditionalJump >> scope [
	^ destination
]

{ #category : #unifyinh }
FogEVMAstConditionalJump >> unify: aFogEVMAstVariable with: aFogEVMLiteral [
	address = aFogEVMAstVariable
		ifTrue: [ address := aFogEVMLiteral.
			^ self ].
	condition = aFogEVMAstVariable
		ifTrue: [ condition := aFogEVMLiteral.
			^ self ].
	"self error: 'Should by unifying something does it ? '"
]
