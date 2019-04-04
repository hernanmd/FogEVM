Class {
	#name : #FogEVMAstRevert,
	#superclass : #FogEVMAstThrow,
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #printing }
FogEVMAstRevert >> accept: aFogEVMAstUneededJumpsWiper [ 
	aFogEVMAstUneededJumpsWiper visitRevert: self 
]

{ #category : #printing }
FogEVMAstRevert >> printOn: aStream [
	aStream nextPutAll:'REVERT'.
	self printMessageOn: aStream
]
