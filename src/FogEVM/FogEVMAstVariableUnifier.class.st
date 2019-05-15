Class {
	#name : #FogEVMAstVariableUnifier,
	#superclass : #FogEVMAstParentingVisitor,
	#instVars : [
		'scope',
		'state',
		'readWriteTracker'
	],
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #unifying }
FogEVMAstVariableUnifier >> initialize [
	super initialize.
	state := #reading
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
	variableState := readWriteTracker at: aVariable.
	^ ((variableState at: #read) = 1
		and: [ (variableState at: #write) = 1 ])
		or: [ ((variableState at: #read) > 1
				and: [ (variableState at: #write) = 1 ])
				and: [ (variableState at: #lastAssignment) isEVMLiteral ] ]
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> visitAssignation: anAssignation [
	super visitAssignation: anAssignation.
	(self variableShouldBeReplaced: anAssignation variable) ifTrue: [ 
			self parent instructions: (self parent instructions , anAssignation instructions).
			self parent removeNode: anAssignation 
		]
]

{ #category : #unifying }
FogEVMAstVariableUnifier >> visitVariable: aVariable [
	| variableState |
	(self parent isAssignation and: [ self parent variable = aVariable ])
		ifTrue: [ ^ self ].
	aVariable isGenerated
		ifFalse: [ ^ self ].
	variableState := readWriteTracker at: aVariable.
	(self variableShouldBeReplaced: aVariable)
		ifTrue: [ self parent
				unify: aVariable
				with: (variableState at: #lastAssignment) ].
	(self variableShouldBeMarkedAsUseless: aVariable)
		ifTrue: [ aVariable markAsUseless ].
	(self variableShouldBeMarkedAsConstant: aVariable)
		ifTrue: [ aVariable constant: true ]
]
