Class {
	#name : #FogEVMAstVariableReadWriteDetector,
	#superclass : #FogEVMAstVisitor,
	#instVars : [
		'readWriteTracker',
		'state',
		'assignationValue',
		'scopesTracking'
	],
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #'as yet unclassified' }
FogEVMAstVariableReadWriteDetector >> anyScopeHasChanged [
	^ readWriteTracker keys anySatisfy: [ :v | v isEVMVariable not ]
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> currentScope [
	^ scopesTracking top
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> currentScope: aScope [
 	scopesTracking push: aScope.
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> initialize [
	super initialize.
	scopesTracking := Stack new.
	state := #reading
]

{ #category : #'as yet unclassified' }
FogEVMAstVariableReadWriteDetector >> readWriteTracker [
	^ readWriteTracker ifNil: [ readWriteTracker := Dictionary new ]
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> releaseScope [
	scopesTracking pop.
]

{ #category : #'as yet unclassified' }
FogEVMAstVariableReadWriteDetector >> unify: aFogEVMAstScope [
	| unifier |
	aFogEVMAstScope accept: self.
	unifier := FogEVMAstVariableUnifier new.
	unifier readWriteTracker: readWriteTracker.
	aFogEVMAstScope accept: unifier
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> visitAssignation: aFogEVMAssignation [

	(aFogEVMAssignation value = aFogEVMAssignation variable or: [ aFogEVMAssignation variable isEVMVariable not ])
		ifTrue: [ 
			self currentScope sequence removeStatement: aFogEVMAssignation 
		]
		ifFalse: [ 
			state := #writing.
			assignationValue := aFogEVMAssignation value.
			aFogEVMAssignation variable accept: self.
			state := #reading.
			aFogEVMAssignation value accept: self 
		]
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> visitScope: aFogEVMAstScope [
	self currentScope: aFogEVMAstScope.
	aFogEVMAstScope temporaries: (aFogEVMAstScope temporaries select: #isEVMVariable).
	aFogEVMAstScope temporaries do: [ :t | self visitVariableDefinition: t ].
	super visitScope: aFogEVMAstScope.
	self releaseScope
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> visitVariable: aFogEVMAstVariable [
	state = #writing
		ifTrue: [ (self readWriteTracker at: aFogEVMAstVariable) at: #lastAssignment put: assignationValue.
			(self readWriteTracker at: aFogEVMAstVariable) at: #write put: ((self readWriteTracker at: aFogEVMAstVariable) at: #write) + 1 ]
		ifFalse: [ (self readWriteTracker at: aFogEVMAstVariable) at: #read put: ((self readWriteTracker at: aFogEVMAstVariable) at: #read) + 1 ]
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> visitVariableDefinition: aFogEVMAstVariable [
	self readWriteTracker
		at: aFogEVMAstVariable
		ifPresent: [ :d | (d at: #scopes) add: self currentScope ]
		ifAbsentPut: [ {(#scopes -> {self currentScope} asSet).
			(#read -> 0).
			(#write -> 0)} asDictionary ]
]

{ #category : #'as yet unclassified' }
FogEVMAstVariableReadWriteDetector >> wipe [
	(readWriteTracker associations
		select: [ :a | a key isGenerated and: [ (a value at: #read) = 1 and: [ (a value at: #write) = 1 ] ] ])
		do: [ :a | a key becomeForward: (a value at: #lastAssignment) ].
	(readWriteTracker associations
		select: [ :a | 
			a key isEVMVariable
				and: [ a key isGenerated and: [ (a value at: #read) = 0 and: [ (a value at: #write) > 1 ] ] ] ])
		do: [ :a | a key name: 'NON-READ-' , a key name ].
	(readWriteTracker associations
		select: [ :a | 
			a key isEVMVariable
				and: [ a key isGenerated and: [ (a value at: #read) > 1 and: [ (a value at: #write) = 1 ] ] ] ])
		do: [ :a | 
			(a value at: #lastAssignment) isEVMLiteral
				ifTrue: [ a key becomeForward: (a value at: #lastAssignment) ]
				ifFalse: [ a key value: (a value at: #lastAssignment).
					a key constant: true ] ]
]
