Class {
	#name : #FogEVMLogEntry,
	#superclass : #Object,
	#instVars : [
		'topics',
		'content'
	],
	#category : #'FogEVM-Envinronment-Objects'
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
