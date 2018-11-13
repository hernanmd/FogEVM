Class {
	#name : #FogEVMFogDataResolver,
	#superclass : #Object,
	#instVars : [
		'address',
		'fog'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #accessing }
FogEVMFogDataResolver >> blockDifficulty [
	^ (fog findBlockByTag: #latest full: false) difficulty
]

{ #category : #accessing }
FogEVMFogDataResolver >> blockHashRegisty [
	^ (fog findBlockByTag: #latest full: false) privateBlockHash 
]

{ #category : #resolving }
FogEVMFogDataResolver >> blockHashRegisty: anInteger [ 
	^ self blockHashRegisty 
]

{ #category : #accessing }
FogEVMFogDataResolver >> connection [
	^ fog ifNil: [ fog := FogConnection createDefaultConnection session ]
]

{ #category : #accessing }
FogEVMFogDataResolver >> currentBlockNumber [
	^ (fog findBlockByTag: #latest full: false) number
]

{ #category : #accessing }
FogEVMFogDataResolver >> gasLimit [
	^ (fog findBlockByTag: #latest full: false) gasLimit
]

{ #category : #accessing }
FogEVMFogDataResolver >> initialize [
	super initialize.
	fog ifNil: [ fog := FogConnection createDefaultConnection session ]
]

{ #category : #accessing }
FogEVMFogDataResolver >> minerAddress [
	^ fog coinBase
]

{ #category : #accessing }
FogEVMFogDataResolver >> startedTime [
	^ DateAndTime now
]

{ #category : #accessing }
FogEVMFogDataResolver >> timestamp [
	^ (fog findBlockByTag: #latest full: false) timestamp
]
