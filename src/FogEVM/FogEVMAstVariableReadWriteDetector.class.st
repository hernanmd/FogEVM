"
I do detect the reads and writes of variables.

"
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

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> reset [ 
	scopesTracking := Stack new.
	state := #reading.
	readWriteTracker := Dictionary new.
	scopes := OrderedCollection new.
	destinations := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
FogEVMAstVariableReadWriteDetector >> unify: aFogEVMAstScope [
	| unifier |
	[ aFogEVMAstScope accept: self.
	unifier := FogEVMAstVariableUnifier new.
	unifier readWriteTracker: readWriteTracker.
	aFogEVMAstScope accept: unifier ]
		doWhileTrue: [
			
			 unifier changed
				ifTrue: [ self reset.
					true ]
				ifFalse: [ false ] ]
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> visitAssignation: aFogEVMAssignation [
	state := #writing.
	assignationValue := aFogEVMAssignation value.
	aFogEVMAssignation variable accept: self.
	state := #reading.
	aFogEVMAssignation value accept: self
]

{ #category : #visiting }
FogEVMAstVariableReadWriteDetector >> visitScope: aFogEVMAstScope [
	self currentScope: aFogEVMAstScope.
	(scopes includes: aFogEVMAstScope)
		ifFalse: [ scopes add: aFogEVMAstScope.
			self visitAstNode: aFogEVMAstScope.
			aFogEVMAstScope
				scopeTemporaries: (aFogEVMAstScope scopeTemporaries select: #isEVMVariable).
			aFogEVMAstScope scopeTemporaries
				do: [ :t | self visitVariableDefinition: t ].
			aFogEVMAstScope sequence accept: self ].
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
