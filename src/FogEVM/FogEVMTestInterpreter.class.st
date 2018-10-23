Class {
	#name : #FogEVMTestInterpreter,
	#superclass : #FogEVMInterpreter,
	#instVars : [
		'startedTime'
	],
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #accessing }
FogEVMTestInterpreter >> blockHashRegisty: aMinimalBlockNumber [ 
	 " Here we could put a strategy. maybe to be able to get information from running environment "
	^ FogEVMRegistry forMemoryContent: 16r687980987654abaca234.
]

{ #category : #accessing }
FogEVMTestInterpreter >> bytecode: aFogEVMByteCode [
	self contract: aFogEVMByteCode
]

{ #category : #accessing }
FogEVMTestInterpreter >> currentBlockNumber [
	^ FogEVMRegistry forValue: 9999 bytesLength: 32
]

{ #category : #accessing }
FogEVMTestInterpreter >> gasLimit [
	^ FogEVMRegistry forValue: 999999999999999999999999 bytesLength: 32
]

{ #category : #accessing }
FogEVMTestInterpreter >> initialize [
	super initialize .
	startedTime 	:= DateAndTime now 
]

{ #category : #'as yet unclassified' }
FogEVMTestInterpreter >> minerAddress [
	^ FogEVMRegistry forValue: 16rA3EBF466889C2A0239379125A7D0F9C4E8BF2A14 bytesLength: 20
]

{ #category : #accessing }
FogEVMTestInterpreter >> originAddress [
	^ FogEVMRegistry forValue: 16rA3EBF466889C2A0239379125A7D0F9C4E8BF2A54 bytesLength: 20
]

{ #category : #'running arbitrary code' }
FogEVMTestInterpreter >> run [
	self interpret
]

{ #category : #accessing }
FogEVMTestInterpreter >> stack [
	^ stack
]

{ #category : #accessing }
FogEVMTestInterpreter >> startedTime [
	^ startedTime
]

{ #category : #accessing }
FogEVMTestInterpreter >> timestamp [
	^ FogEVMRegistry forValue: self startedTime asUnixTime bytesLength: 32
]
