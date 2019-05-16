Class {
	#name : #FogEVMAstLog,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'topics',
		'message'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #visiting }
FogEVMAstLog >> accept: aFogEVMAstVisitor [
	aFogEVMAstVisitor visitLog: self
]

{ #category : #accessing }
FogEVMAstLog >> message [
	^ message
]

{ #category : #accessing }
FogEVMAstLog >> message: aFogEVMAstVariable [ 
	message := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstLog >> topics [
	^ topics ifNil: [ topics := OrderedCollection new ]
]

{ #category : #unifying }
FogEVMAstLog >> unify: aFogEVMAstVariable with: aFogEVMAstValue [
	message = aFogEVMAstVariable
		ifTrue: [ message := aFogEVMAstValue ].
	topics replaceAll: aFogEVMAstVariable with: aFogEVMAstValue
]
