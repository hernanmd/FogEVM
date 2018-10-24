Class {
	#name : #FogEVMLogEntry,
	#superclass : #Object,
	#instVars : [
		'topics',
		'content'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #accessing }
FogEVMLogEntry >> content [
	^ content
]

{ #category : #accessing }
FogEVMLogEntry >> content: aCollection [ 
	content := aCollection
]

{ #category : #accessing }
FogEVMLogEntry >> topics [
	^ topics
]

{ #category : #accessing }
FogEVMLogEntry >> topics: aCollection [ 
	topics := aCollection
]
