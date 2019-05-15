Class {
	#name : #FogEVMAstNode,
	#superclass : #Object,
	#instVars : [
		'instructions'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstNode >> initialize [
	super initialize.
	instructions := OrderedCollection  new.
	
]

{ #category : #'as yet unclassified' }
FogEVMAstNode >> instruction: aFogEVMMnemonicExecutableMemoryEntry [
	instructions add: aFogEVMMnemonicExecutableMemoryEntry
]

{ #category : #enumerating }
FogEVMAstNode >> instructions [
	^ instructions
]

{ #category : #testing }
FogEVMAstNode >> isAssignation [
	^ false
]

{ #category : #testing }
FogEVMAstNode >> isConditionalJump [
	^ false 
]

{ #category : #'as yet unclassified' }
FogEVMAstNode >> isEVMLiteral [
	^ false. 
]

{ #category : #testing }
FogEVMAstNode >> isEVMMessageSend [
	^ false 
]

{ #category : #testing }
FogEVMAstNode >> isEVMVariable [ 
	^ false 
]

{ #category : #testing }
FogEVMAstNode >> isEndingState [
	^ false.
]

{ #category : #testing }
FogEVMAstNode >> isGenerated [
	^ false
]

{ #category : #'as yet unclassified' }
FogEVMAstNode >> isJump [
	^ false 
]

{ #category : #'as yet unclassified' }
FogEVMAstNode >> isJumpDest [
	^ false. 
]

{ #category : #'as yet unclassified' }
FogEVMAstNode >> isStorageAccess [
	^ false
]

{ #category : #testing }
FogEVMAstNode >> isStrictJump [
	^ false 
]

{ #category : #enumerating }
FogEVMAstNode >> select: aCondition [
	| finder |
	finder := FogEVMAstFinder new
		condition: aCondition;
		yourself.
	self accept: finder.
	^ finder found
]
