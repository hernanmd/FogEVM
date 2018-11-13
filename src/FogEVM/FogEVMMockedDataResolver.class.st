Class {
	#name : #FogEVMMockedDataResolver,
	#superclass : #Object,
	#instVars : [
		'blockHashRegisty',
		'currentBlockNumber',
		'gasLimit',
		'minerAddress',
		'timestamp'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #accessing }
FogEVMMockedDataResolver >> blockHashRegisty [
	^ blockHashRegisty
]

{ #category : #accessing }
FogEVMMockedDataResolver >> blockHashRegisty: aMinimalBlockNumber [ 
	^ blockHashRegisty
]

{ #category : #accessing }
FogEVMMockedDataResolver >> blockHashRegistyValue: anObject [
	blockHashRegisty := anObject
]

{ #category : #accessing }
FogEVMMockedDataResolver >> currentBlockNumber [
	^ currentBlockNumber 
]

{ #category : #accessing }
FogEVMMockedDataResolver >> currentBlockNumber: anObject [
	currentBlockNumber := anObject
]

{ #category : #accessing }
FogEVMMockedDataResolver >> gasLimit [
	^ gasLimit
]

{ #category : #accessing }
FogEVMMockedDataResolver >> gasLimit: anObject [
	gasLimit := anObject
]

{ #category : #accessing }
FogEVMMockedDataResolver >> minerAddress [
	^ minerAddress
]

{ #category : #accessing }
FogEVMMockedDataResolver >> minerAddress: anObject [
	minerAddress := anObject
]

{ #category : #accessing }
FogEVMMockedDataResolver >> timestamp [
	^ timestamp
]

{ #category : #accessing }
FogEVMMockedDataResolver >> timestamp: anObject [
	timestamp := anObject
]
