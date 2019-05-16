Class {
	#name : #FogEVMAstUnknownType,
	#superclass : #FogEVMAstNode,
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #printing }
FogEVMAstUnknownType >> printOn: aStream [
	aStream nextPutAll: 'Unknown type'
]
