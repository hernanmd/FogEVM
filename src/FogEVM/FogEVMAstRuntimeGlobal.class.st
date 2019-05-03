Class {
	#name : #FogEVMAstRuntimeGlobal,
	#superclass : #FogEVMAstNode,
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #visiting }
FogEVMAstRuntimeGlobal >> accept: aFogEVMAstVisitor [ 
	aFogEVMAstVisitor visitRuntimeGlobal: self.
]
