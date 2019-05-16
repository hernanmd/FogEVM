"
I do variable unification, by refactoring the decompiled AST. I need a registry of variable read and writes for working.
"
Class {
	#name : #FogEVMAstVariableUnifier,
	#superclass : #FogEVMAstParentingVisitor,
	#instVars : [
		'scope',
		'state',
		'readWriteTracker',
		'changes'
	],
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #unifying }
FogEVMAstVariableUnifier >> changed [
	^ changes
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> changed: aValue [
	self halt.
	changes := aValue
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> initialize [
	super initialize.
	state := #reading.
	changes := false.
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> readWriteTracker: aDictionary [
	readWriteTracker := aDictionary
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> unify [

]

{ #category : #unifying }
FogEVMAstVariableUnifier >> unify: aScope [
	scope := aScope.
	aScope accept: self.
	self unify
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> variableShouldBeMarkedAsConstant: aVariable [
	| variableState |
	variableState := readWriteTracker at: aVariable.
	^ (variableState at: #read) > 1
		and: [ (variableState at: #write) = 1
				and: [ (variableState at: #lastAssignment) isEVMLiteral not ] ]
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> variableShouldBeMarkedAsUseless: aVariable [
	| variableState |
	variableState := readWriteTracker at: aVariable.
	^ (variableState at: #read) = 0
		and: [ (variableState at: #write) = 1 ]
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> variableShouldBeReplaced: aVariable [
	| variableState |
	variableState := readWriteTracker at: aVariable ifAbsent: [^ false].
	^ ((variableState at: #read) = 1
		and: [ (variableState at: #write) = 1 ])
		or: [ ((variableState at: #read) > 1
				and: [ (variableState at: #write) = 1 ])
				and: [ (variableState at: #lastAssignment) isEVMLiteral ] ]
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> visitAssignation: anAssignation [
	super visitAssignation: anAssignation.
	(self variableShouldBeReplaced: anAssignation variable)
		ifTrue: [ self parent
				instructions: self parent instructions , anAssignation instructions.
			scopes
				select: [ :s | s statements includes: anAssignation ]
				thenDo: [ :s | s removeNode: anAssignation ].
			self parent removeNode: anAssignation.
			self changed: true ]
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> visitSequence: aSequence [
	super visitSequence: aSequence.
	"collection := self parent temporaries
		reject: [ :v | self variableShouldBeReplaced: v ].
	self parent temporaries = collection
		ifFalse: [ changes := true.
			self parent temporaries: collection ]"
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> visitVariable: aVariable [
	| variableState |
	(self parent isAssignation and: [ self parent variable = aVariable ])
		ifTrue: [ ^ self ].
	aVariable isGenerated
		ifFalse: [ ^ self ].
	variableState := readWriteTracker at: aVariable ifAbsent:[ ^ self] .
	(self variableShouldBeReplaced: aVariable)
		ifTrue: [ self changed: true.
			self parent
				unify: aVariable
				with: (variableState at: #lastAssignment) ].
	((self variableShouldBeMarkedAsUseless: aVariable) and: [  aVariable isUseless not ]) 
		ifTrue: [ self changed:true.
			aVariable markAsUseless ].
	((self variableShouldBeMarkedAsConstant: aVariable)
		and: [ aVariable isConstant not ])
		ifTrue: [ self changed: true.
			aVariable constant: true ]
]
