Class {
	#name : #FogEVMAssignation,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'variable',
		'value'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAssignation >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitAssignation: self 
]

{ #category : #'as yet unclassified' }
FogEVMAssignation >> isAssignation [
	^ true
]

{ #category : #jumpTounknown }
FogEVMAssignation >> jumpDestination [
	^ nil.
]

{ #category : #printing }
FogEVMAssignation >> printOn: aStream [
	variable name printOn: aStream.
	aStream nextPutAll: ' := '.
	value printOn: aStream
]

{ #category : #unifying }
FogEVMAssignation >> unify: aFogEVMAstVariable with: aFogEVMAstValue [
	self assert: value = aFogEVMAstVariable.
	value := aFogEVMAstValue
]

{ #category : #accessing }
FogEVMAssignation >> value [
	^ value
]

{ #category : #'as yet unclassified' }
FogEVMAssignation >> value: aClass [ 
	value := aClass
]

{ #category : #'as yet unclassified' }
FogEVMAssignation >> variable [
	^ variable
]

{ #category : #'as yet unclassified' }
FogEVMAssignation >> variable: aFogEVMAstVariable [ 
	variable := aFogEVMAstVariable
]
