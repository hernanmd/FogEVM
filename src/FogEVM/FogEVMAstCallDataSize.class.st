Class {
	#name : #FogEVMAstCallDataSize,
	#superclass : #FogEVMAstNode,
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstCallDataSize >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitCallDataSize: self 
]

{ #category : #printing }
FogEVMAstCallDataSize >> printOn: aStream [
	aStream nextPutAll: 'CallData size'
]
