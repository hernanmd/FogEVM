Class {
	#name : #FogEVMAstLog,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'topics',
		'message'
	],
	#category : #'FogEVM-DecompilerAST'
}

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
