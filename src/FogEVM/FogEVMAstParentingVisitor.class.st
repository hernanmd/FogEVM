Class {
	#name : #FogEVMAstParentingVisitor,
	#superclass : #FogEVMAstVisitor,
	#instVars : [
		'stack'
	],
	#category : #'FogEVM-Decompiler-Vitamins'
}

{ #category : #visiting }
FogEVMAstParentingVisitor >> initialize [
	super initialize.
	scopes := OrderedCollection new.
	stack := Stack new.
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> parent [
	^ stack top
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> parentNode: aFogEVMAstNode for: aBlock [
	stack push: aFogEVMAstNode.
	aBlock value.
	stack pop
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> releaseNode [
	^ stack pop
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitAssignation: aFogEVMAssignation [
	self
		parentNode: aFogEVMAssignation
		for: [ aFogEVMAssignation variable accept: self.
			aFogEVMAssignation value accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitCall: aFogEVMAstCall [
	self visitAstNode: aFogEVMAstCall.
	self
		parentNode: aFogEVMAstCall
		for: [ aFogEVMAstCall address accept: self.
			aFogEVMAstCall gas accept: self.
			aFogEVMAstCall money accept: self.
			aFogEVMAstCall input accept: self ]
]

{ #category : #'as yet unclassified' }
FogEVMAstParentingVisitor >> visitCodeCopy: aFogEVMAstCodeCopy [
	self visitAstNode: aFogEVMAstCodeCopy.
	self
		parentNode: aFogEVMAstCodeCopy
		for: [ aFogEVMAstCodeCopy loadingArea accept: self.
			aFogEVMAstCodeCopy fromInstruction accept: self.
			aFogEVMAstCodeCopy amountOfInstructions accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitConditionalJump: aFogEVMAstConditionalJump [
	self visitAstNode: aFogEVMAstConditionalJump.
	self
		parentNode: aFogEVMAstConditionalJump
		for: [ aFogEVMAstConditionalJump condition accept: self.
			aFogEVMAstConditionalJump address accept: self.
			aFogEVMAstConditionalJump destination ifNil: [ ^ self ].
			aFogEVMAstConditionalJump destination accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitContract: aFogEVMContract [
	self visitAstNode: aFogEVMContract.
	self
		parentNode: aFogEVMContract
		for: [ aFogEVMContract bytecode accept: self.
			aFogEVMContract value accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitJump: aFogEVMAstJump [
	self visitAstNode: aFogEVMAstJump.
	self
		parentNode: aFogEVMAstJump
		for: [ aFogEVMAstJump address accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitJumpTag: aFogEVMAstJumpTag [
	self visitAstNode: aFogEVMAstJumpTag.
	self
		parentNode: aFogEVMAstJumpTag
		for: [ aFogEVMAstJumpTag scope ifNotNil: [ :s | s accept: self ] ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitLog: aFogEVMAstLog [
	self visitAstNode: aFogEVMAstLog.
	self
		parentNode: aFogEVMAstLog
		for: [ aFogEVMAstLog message accept: self.
			aFogEVMAstLog topics do: [ :t | t accept: self ] ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitMemoryLoad: aFogEVMAstMemoryLoad [
	self visitAstNode: aFogEVMAstMemoryLoad.
	self
		parentNode: aFogEVMAstMemoryLoad
		for: [ aFogEVMAstMemoryLoad fromAddress accept: self.
			aFogEVMAstMemoryLoad amountOfBytes accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitMemoryStore: aFogEVMAstMemoryStore [
	self visitAstNode: aFogEVMAstMemoryStore.
	self
		parentNode: aFogEVMAstMemoryStore
		for: [ aFogEVMAstMemoryStore address accept: self.
			aFogEVMAstMemoryStore value accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitMessageSend: aFogEVMAstBinaryMessageSend [
	self visitAstNode: aFogEVMAstBinaryMessageSend.
	self
		parentNode: aFogEVMAstBinaryMessageSend
		for: [ aFogEVMAstBinaryMessageSend receiver accept: self.
			aFogEVMAstBinaryMessageSend arguments do: [ :a | a accept: self ] ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitReturn: aFogEVMAstReturn [
	self visitAstNode: aFogEVMAstReturn.
	self
		parentNode: aFogEVMAstReturn
		for: [ aFogEVMAstReturn returns accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitRevert: aFogEVMAstRevert [
	self visitAstNode: aFogEVMAstRevert.
	self
		parentNode: aFogEVMAstRevert
		for: [ aFogEVMAstRevert message accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitScope: aFogEVMAstScope [
	(scopes includes: aFogEVMAstScope)
		ifFalse: [ self
				parentNode: aFogEVMAstScope
				for: [ scopes add: aFogEVMAstScope.
					self visitAstNode: aFogEVMAstScope.
					aFogEVMAstScope sequence accept: self ] ]
]

{ #category : #'as yet unclassified' }
FogEVMAstParentingVisitor >> visitSelfDestruct: aFogEVMAstSelfDestruct [
	self visitAstNode: aFogEVMAstSelfDestruct.
	self
		parentNode: aFogEVMAstSelfDestruct
		for: [ aFogEVMAstSelfDestruct account accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitSequence: aFogEVMSequence [
	| statements |
	self visitAstNode: aFogEVMSequence.
	self
		parentNode: aFogEVMSequence
		for: [ statements := aFogEVMSequence statements asArray.
			statements do: [ :s | s ifNotNil: [ s accept: self ] ] ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitStorageLoad: aFogEVMAstStorageLoad [
	self visitAstNode: aFogEVMAstStorageLoad.
	self
		parentNode: aFogEVMAstStorageLoad
		for: [ aFogEVMAstStorageLoad address accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitStorageStore: aFogEVMAstStorageStore [
	self visitAstNode: aFogEVMAstStorageStore.
	self
		parentNode: aFogEVMAstStorageStore
		for: [ aFogEVMAstStorageStore address accept: self.
			aFogEVMAstStorageStore value accept: self ]
]

{ #category : #visiting }
FogEVMAstParentingVisitor >> visitThrow: aFogEVMAstRevert [
	self visitAstNode: aFogEVMAstRevert.
	self
		parentNode: aFogEVMAstRevert
		for: [ aFogEVMAstRevert message accept: self ]
]
