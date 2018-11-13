Class {
	#name : #FogEVMDebuggingInterpreter,
	#superclass : #FogEVMAbstractInterpreter,
	#instVars : [
		'startedTime',
		'contract',
		'call'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #'as yet unclassified' }
FogEVMDebuggingInterpreter >> binaryBytecodeFor: aFogEVMRegistry [
	self assert: aFogEVMRegistry unsignedValue = 740735499233530362346919405980904206194320393200.
	^ contract bytecode toBinary 
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> blockDifficulty [
	^ FogEVMRegistry forValue: 16r00000001  bytesLength: 32
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> blockHashRegisty: aMinimalBlockNumber [ 
	 " Here we could put a strategy. maybe to be able to get information from running environment "
	^ FogEVMRegistry forMemoryContent: 16r687980987654abaca234.
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> contract: aFogEVMByteCode [
	self halt.
	contract := FogEVMContract new
		bytecode: aFogEVMByteCode;
		address: call contractAddress;
		yourself.
	(self storageFor: call contractAddress ) contract: contract .
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> currentBlockNumber [
	^ FogEVMRegistry forValue: 9999 bytesLength: 32
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> gasLimit [
	^ FogEVMRegistry forValue: 999999999999999999999999 bytesLength: 32
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> initialize [
	super initialize .
	startedTime 	:= DateAndTime now 
]

{ #category : #'as yet unclassified' }
FogEVMDebuggingInterpreter >> minerAddress [
	^ FogEVMRegistry forValue: 16rA3EBF466889C2A0239379125A7D0F9C4E8BF2A14 bytesLength: 20
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> originAddress [
	^ FogEVMRegistry forValue: 16rA3EBF466889C2A0239379125A7D0F9C4E8BF2A54 bytesLength: 20
]

{ #category : #'running arbitrary code' }
FogEVMDebuggingInterpreter >> restart [
	memory restart.
	super restart.
]

{ #category : #'running arbitrary code' }
FogEVMDebuggingInterpreter >> run [
	self prepareToRun.
	self interpret
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> stack [
	^ stack
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> startedTime [
	^ startedTime
]

{ #category : #accessing }
FogEVMDebuggingInterpreter >> timestamp [
	^ FogEVMRegistry forValue: self startedTime asUnixTime bytesLength: 32
]
