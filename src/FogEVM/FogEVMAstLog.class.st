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
FogEVMAstLog >> message: aFogEVMAstVariable [ 
	message := aFogEVMAstVariable
]
