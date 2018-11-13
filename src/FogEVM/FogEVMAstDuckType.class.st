Class {
	#name : #FogEVMAstDuckType,
	#superclass : #FogEVMAstNode,
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #printing }
FogEVMAstDuckType >> printOn: aStream [
	aStream nextPutAll: 'Unknown type'
]
