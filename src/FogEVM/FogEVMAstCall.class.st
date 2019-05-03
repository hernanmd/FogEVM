Class {
	#name : #FogEVMAstCall,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'address',
		'gas',
		'money',
		'input'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #accessing }
FogEVMAstCall >> accept: aFogEVMAstVisitor [ 
	aFogEVMAstVisitor visitCall: self
]

{ #category : #accessing }
FogEVMAstCall >> address [
	^ address
]

{ #category : #accessing }
FogEVMAstCall >> address: aFogEVMAstVariable [ 
	address := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstCall >> gas [
	^ gas
]

{ #category : #accessing }
FogEVMAstCall >> gas: aFogEVMAstVariable [ 
	gas := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstCall >> input [
	^ input
]

{ #category : #accessing }
FogEVMAstCall >> input: aFogEVMAstVariable [ 
	input := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstCall >> money [
	^ money
]

{ #category : #accessing }
FogEVMAstCall >> money: aFogEVMAstVariable [ 
	money := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstCall >> printOn: aStream [
	aStream
		nextPutAll: 'Call(';
		nextPutAll: address printString;
		nextPut: $,;
		nextPutAll: input printString;
		nextPut: $,;
		nextPutAll: gas printString;
		nextPut: $)
]
