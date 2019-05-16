Class {
	#name : #FogEVMAstThrow,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'message'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstThrow >> accept: aFogEVMAstUneededJumpsWiper [ 
	aFogEVMAstUneededJumpsWiper visitThrow: self 
]

{ #category : #printing }
FogEVMAstThrow >> isEndingState [
	^ true
]

{ #category : #accessing }
FogEVMAstThrow >> message [
	^ message
]

{ #category : #printing }
FogEVMAstThrow >> message: aMessage [
	message := aMessage
]

{ #category : #printing }
FogEVMAstThrow >> printMessageOn: aStream [
	message
		ifNotNil: [ aStream nextPutAll: '('.
			message printOn: aStream.
			aStream nextPutAll: ')' ]
]

{ #category : #printing }
FogEVMAstThrow >> printOn: aStream [
	aStream nextPutAll:'THROW'.
	self printMessageOn: aStream.
]

{ #category : #'as yet unclassified' }
FogEVMAstThrow >> unify: aFogEVMAstVariable with: aFogEVMAstMemoryLoad [
	message = aFogEVMAstVariable
		ifTrue: [ message := aFogEVMAstMemoryLoad ]
]
