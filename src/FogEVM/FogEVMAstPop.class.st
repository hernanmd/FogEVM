Class {
	#name : #FogEVMAstPop,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'variable'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstPop >> accept: aFogEVMAstVariableWiperVisitor [ 
	" pass "
]

{ #category : #printing }
FogEVMAstPop >> printOn: aStream [
	aStream nextPutAll: 'POP '.
	variable printOn: aStream
]

{ #category : #'as yet unclassified' }
FogEVMAstPop >> variable: aFogEVMAstVariable [ 
	variable := aFogEVMAstVariable
]
