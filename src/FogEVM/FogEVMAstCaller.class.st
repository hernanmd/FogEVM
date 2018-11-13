Class {
	#name : #FogEVMAstCaller,
	#superclass : #FogEVMAstNode,
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstCaller >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitCaller: self 
]

{ #category : #printing }
FogEVMAstCaller >> printOn: aStream [
	aStream nextPutAll: ' CALLER-Account '
]
