Class {
	#name : #FogEVMAstCodeCopy,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'from',
		'amount',
		'loadingArea'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstCodeCopy >> accept: aFogEVMAstVisitor [ 
	aFogEVMAstVisitor visitCodeCopy: self 
]

{ #category : #'as yet unclassified' }
FogEVMAstCodeCopy >> amountOfInstructions [
	^ amount 
]

{ #category : #'as yet unclassified' }
FogEVMAstCodeCopy >> amountOfInstructions: aFogEVMAstVariable [ 
	amount := aFogEVMAstVariable
]

{ #category : #'as yet unclassified' }
FogEVMAstCodeCopy >> fromInstruction [
	^ from
]

{ #category : #'as yet unclassified' }
FogEVMAstCodeCopy >> fromInstruction: aFogEVMAstVariable [ 
	from := aFogEVMAstVariable
]

{ #category : #'as yet unclassified' }
FogEVMAstCodeCopy >> loadingArea [
	^ loadingArea
]

{ #category : #'as yet unclassified' }
FogEVMAstCodeCopy >> loadingArea: aFogEVMAstVariable [ 
	loadingArea := aFogEVMAstVariable
]

{ #category : #'as yet unclassified' }
FogEVMAstCodeCopy >> printOn: aStream [
	loadingArea printOn: aStream .
	aStream nextPutAll: '= CODECOPY(From: '.
	from printOn: aStream.
	aStream nextPutAll: ' Offset: '.
	amount  printOn: aStream.
	aStream nextPutAll: ') '
]
