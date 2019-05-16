Class {
	#name : #FogEVMAstSelfDestruct,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'account'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstSelfDestruct >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitSelfDestruct: self .
]

{ #category : #'as yet unclassified' }
FogEVMAstSelfDestruct >> account [
	^ account
]

{ #category : #'as yet unclassified' }
FogEVMAstSelfDestruct >> account: aFogEVMAstVariable [ 
	account := aFogEVMAstVariable
]

{ #category : #printing }
FogEVMAstSelfDestruct >> printOn: aStream [
	aStream nextPutAll: 'SELF-DESTRUCT Account: '.
	account printOn: aStream
]

{ #category : #unifying }
FogEVMAstSelfDestruct >> unify: aFogEVMAstVariable with: aFogEVMLiteral [
	account = aFogEVMAstVariable
		ifTrue: [ account := aFogEVMLiteral ]
]
