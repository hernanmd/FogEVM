"
The execution preview is an object that is contructed by observing the stack, to predict the parameters that it will use. 
It is also able to check the stack, to retreeve the result (push) of this operation, regarding to the stack.
"
Class {
	#name : #FogEVMExecutionPreview,
	#superclass : #Object,
	#instVars : [
		'instruction',
		'args',
		'result'
	],
	#category : #'FogEVM-UIDebugger-View'
}

{ #category : #'instance creation' }
FogEVMExecutionPreview class >> from: aMemoryInstruction and: stack [
	| stackPointer args |
	args := OrderedCollection new.
	stack
		ifNotEmpty: [ stackPointer := stack firstLink.
			1 to: aMemoryInstruction instruction expectedPops do: [ :idx | 
				args add: stackPointer value.
				stackPointer := stackPointer nextLink ] ].
	^ self new
		instruction: aMemoryInstruction;
		args: args;
		yourself
]

{ #category : #accessing }
FogEVMExecutionPreview >> args [
	^ args
]

{ #category : #accessing }
FogEVMExecutionPreview >> args: anObject [
	args := anObject
]

{ #category : #accessing }
FogEVMExecutionPreview >> instruction [
	^ instruction
]

{ #category : #accessing }
FogEVMExecutionPreview >> instruction: anObject [
	instruction := anObject
]

{ #category : #accessing }
FogEVMExecutionPreview >> loadResultFrom: aStack [
	| stackPointer |
	result := OrderedCollection new.
	aStack
		ifNotEmpty: [ stackPointer := aStack firstLink.
			1 to: instruction instruction expectedPushes do: [ :idx | 
				result add: stackPointer value.
				stackPointer := stackPointer nextLink ] ].

]

{ #category : #accessing }
FogEVMExecutionPreview >> mnemonic [
	^ instruction instruction printString 
]

{ #category : #accessing }
FogEVMExecutionPreview >> result [
	^ result
]

{ #category : #accessing }
FogEVMExecutionPreview >> resultString [
	^ '[{1}]' format: {('][' join: result)}
]

{ #category : #accessing }
FogEVMExecutionPreview >> showTime [
	^'{1}\{[{2}]\} -> [{3}] '
		format:
			{instruction instruction printString.
			('][' join: args).
			'][' join: result  }
]
