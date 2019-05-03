Class {
	#name : #FogEVMAstScope,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'temporaries',
		'sequence',
		'finishesAt',
		'stack',
		'parent',
		'trace'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstScope >> accept: aFogEVMAstVariableWiperVisitor [
	aFogEVMAstVariableWiperVisitor visitScope: self
]

{ #category : #'as yet unclassified' }
FogEVMAstScope >> addTemporary: aFogEVMAstVariable [ 
	temporaries add: aFogEVMAstVariable
]

{ #category : #convenience }
FogEVMAstScope >> allInstructions [
	^ sequence allInstructions
]

{ #category : #testing }
FogEVMAstScope >> alreadyProcessedInstruction: anInstruction [
	^ (self getProcessedInstruction: anInstruction ifNone: [ nil ]) isNotNil
]

{ #category : #testing }
FogEVMAstScope >> getProcessedInstruction: anInstruction [
	^ self getProcessedInstruction: anInstruction ifNone: [ self error ]
]

{ #category : #testing }
FogEVMAstScope >> getProcessedInstruction: anInstruction ifNone: aBlock [
	^ sequence statements
		detect: [ :s | s instructions anySatisfy: [ :i | i = anInstruction ] ]
		ifNone: [ parent
				ifNil: [ aBlock value ]
				ifNotNil: [ parent getProcessedInstruction: anInstruction ifNone: aBlock ] ]
]

{ #category : #initialization }
FogEVMAstScope >> initialize [
	super initialize.
	temporaries := OrderedCollection new. 
	sequence := FogEVMAstSequence new .
	trace := OrderedCollection new.
]

{ #category : #initialization }
FogEVMAstScope >> initializeWith: aParent [
	parent := aParent.
	stack := parent ifNil: [ Stack new ] ifNotNil: [ parent stack deepCopy ].
	
]

{ #category : #testing }
FogEVMAstScope >> isClosed [
	^ sequence isClosed
]

{ #category : #'as yet unclassified' }
FogEVMAstScope >> linkJumpsTo: aCollection [
	sequence statements select: #isJump thenDo: [ :s | self halt ]
]

{ #category : #initialization }
FogEVMAstScope >> newScope [
	^ self class new
		initializeWith: self;
		yourself
]

{ #category : #initialization }
FogEVMAstScope >> parent [
	^ parent
]

{ #category : #printing }
FogEVMAstScope >> printOn: aStream [
	aStream nextPutAll: ' |'.
	temporaries
		do: [ :t | 
			aStream
				nextPutAll: ' ';
				nextPutAll: t name;
				nextPutAll: ' ' ].
	aStream nextPutAll: '| '.
	aStream nextPutAll: String crlf.
	sequence printOn: aStream
]

{ #category : #'as yet unclassified' }
FogEVMAstScope >> sequence [
	^ sequence
]

{ #category : #accessing }
FogEVMAstScope >> stack [
	^ stack
]

{ #category : #convenienve }
FogEVMAstScope >> statements [
	^ sequence statements
]

{ #category : #'as yet unclassified' }
FogEVMAstScope >> temporaries [
	^ (parent ifNil: [ {} ] ifNotNil: [ parent temporaries ]) , temporaries
]

{ #category : #accessing }
FogEVMAstScope >> temporaries: aCollectionOfTemporaries [
	temporaries := aCollectionOfTemporaries
]

{ #category : #initialization }
FogEVMAstScope >> trace [
	^ trace
]
