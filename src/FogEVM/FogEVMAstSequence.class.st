Class {
	#name : #FogEVMAstSequence,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'statements',
		'isClosed'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstSequence >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitSequence: self 
]

{ #category : #'as yet unclassified' }
FogEVMAstSequence >> addStatement: aFogEVMAssignation [
	self isClosed
		ifTrue: [ ^ self error: 'Sequence is already closed! Something weird is happening ;-o' ].
	statements add: aFogEVMAssignation
]

{ #category : #initialization }
FogEVMAstSequence >> initialize [
	super initialize.
	statements := OrderedCollection new
]

{ #category : #testing }
FogEVMAstSequence >> isClosed [
	^ isClosed ifNil: [ statements isNotEmpty and: [ statements last isEndingState ] ]
]

{ #category : #testing }
FogEVMAstSequence >> isClosed: aBoolean [
	isClosed := aBoolean
]

{ #category : #printing }
FogEVMAstSequence >> printOn: aStream [
	statements
		do: [ :s | 
			s printOn: aStream.
			aStream nextPut: $..
			aStream nextPutAll: String crlf ]
]

{ #category : #removing }
FogEVMAstSequence >> removeStatement: aFogEVMAssignation [ 
	statements remove: aFogEVMAssignation
]

{ #category : #'as yet unclassified' }
FogEVMAstSequence >> statements [
	^ statements
]
