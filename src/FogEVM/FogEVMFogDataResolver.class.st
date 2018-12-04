"
The interpreter delegates into a dataResolver to fetch general environmental information. 

The fig data resolver allows the user to use an already existing geth installation for fetching this information. 

Use the #fog: setter for setting up FogSession you want the resolver to use. 

interpreter := FogEVMSimulatorInterpreter new.
interpreter dataResolver: FogEVMFogDataResolver new fog: Fog createDefaultConnection session. 

"
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
FogEVMFogDataResolver >> fog: aSession [
	fog := aSession
]

{ #category : #accessing }
FogEVMFogDataResolver >> gasLimit [
	^ (fog findBlockByTag: #latest full: false) gasLimit
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
