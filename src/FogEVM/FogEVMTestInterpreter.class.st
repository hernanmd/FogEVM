Class {
	#name : #FogEVMTestInterpreter,
	#superclass : #FogEVMAbstractInterpreter,
	#instVars : [
		'startedTime',
		'call',
		'contract'
	],
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #'as yet unclassified' }
FogEVMTestInterpreter >> binaryBytecodeFor: aFogEVMRegistry [
	self assert: aFogEVMRegistry unsignedValue = 740735499233530362346919405980904206194320393200.
	^ contract bytecode toBinary 
]

{ #category : #accessing }
FogEVMTestInterpreter >> blockDifficulty [
	^ FogEVMRegistry forValue: 16r00000001  bytesLength: 32
]

{ #category : #accessing }
FogEVMTestInterpreter >> blockHashRegisty: aMinimalBlockNumber [ 
	 " Here we could put a strategy. maybe to be able to get information from running environment "
	^ FogEVMRegistry forMemoryContent: 16r687980987654abaca234.
]

{ #category : #accessing }
FogEVMTestInterpreter >> bytecode: aFogEVMByteCode [
	self contract: aFogEVMByteCode
]

{ #category : #'as yet unclassified' }
FogEVMTestInterpreter >> call [
	^ call
]

{ #category : #accessing }
FogEVMTestInterpreter >> call: aFogEVMCall [
	call := aFogEVMCall
]

{ #category : #accessing }
FogEVMTestInterpreter >> contract: aFogEVMByteCode [
	contract := FogEVMContract new
		bytecode: aFogEVMByteCode;
		address: call contractAddress;
		yourself.
	(self storageFor: call contractAddress ) contract: contract .
]

{ #category : #accessing }
FogEVMTestInterpreter >> currentBlockNumber [
	^ FogEVMRegistry forValue: 9999 bytesLength: 32
]

{ #category : #accessing }
FogEVMTestInterpreter >> gasLimit [
	^ FogEVMRegistry forValue: 999999999999999999999999 bytesLength: 32
]

{ #category : #running }
FogEVMTestInterpreter >> hackedRun [
	| activation |
	activation := activations size = 1
		ifTrue: [ activation := activations top
				setFinished: false;
				yourself ]
		ifFalse: [ FogEVMActivation new ].
	activation call: call.
	activation contract: contract.
	activations size = 1
		ifFalse: [ self pushActivation: activation ].
	self interpret
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
FogEVMTestInterpreter >> prepareToRun [
	| activation |
	activation := FogEVMActivation new.
	activation call: call.
	activation contract: contract.
	self pushActivation: activation.
	
]

{ #category : #'running arbitrary code' }
FogEVMTestInterpreter >> run [
	self prepareToRun.
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
