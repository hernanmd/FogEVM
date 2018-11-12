Class {
	#name : #FogEVMTraceableMemory,
	#superclass : #FogEVMMemory,
	#instVars : [
		'tags'
	],
	#category : #'FogEVM-Memory'
}

{ #category : #accessing }
FogEVMTraceableMemory >> ensureAddressAvailable: anAddress size: size [
	super ensureAddressAvailable: anAddress size: size - 1.
	anAddress to: anAddress + size do: [ :byte | self tag: byte with: self resolveCall ]
]

{ #category : #accessing }
FogEVMTraceableMemory >> initialize [
	super initialize.
	tags := Dictionary new  
]

{ #category : #accessing }
FogEVMTraceableMemory >> resolveCall [
	| sender |
	sender := thisContext sender.
	[ sender receiver isKindOf: FogEVMMemory ] whileTrue: [ sender := sender sender ].
	^ (sender receiver isKindOf: FogEVMInterpreter)
		ifTrue: [ sender receiver currentInstruction ]
		ifFalse: [ 'non-interpreter-allocated' ]
]

{ #category : #accessing }
FogEVMTraceableMemory >> tag: byte with: aTag [
	(self tags at: byte ifAbsentPut: [ OrderedCollection new ]) add: aTag
]

{ #category : #accessing }
FogEVMTraceableMemory >> tagFor: aByte [
	^ self tags at: aByte ifAbsent: [ {} ]
]

{ #category : #accessing }
FogEVMTraceableMemory >> tags [
	^ tags 
]
