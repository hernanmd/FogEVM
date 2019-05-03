Class {
	#name : #FogEVMAstInvalid,
	#superclass : #FogEVMAstNode,
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #visiting }
FogEVMAstInvalid >> accept: aFogEVMAstVisitor [
	aFogEVMAstVisitor visitInvalid: self
]
