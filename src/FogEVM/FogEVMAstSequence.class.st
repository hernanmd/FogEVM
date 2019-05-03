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

{ #category : #testing }
FogEVMAstSequence >> allInstructions [
	self assert: (instructions isEmpty not and: (statements flatCollect: #instructions) isEmpty not) not.
	^ instructions , (statements flatCollect: #instructions)
]

{ #category : #initialization }
FogEVMAstSequence >> initialize [
	super initialize.
	statements := OrderedCollection new
]

{ #category : #testing }
FogEVMAstSequence >> instruction: anObject [
	statements
		ifEmpty: [ super instruction: anObject ]
		ifNotEmpty: [ statements last instruction: anObject ]
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
