Class {
	#name : #FogEVMSimulatorInterpreter,
	#superclass : #FogEVMAbstractInterpreter,
	#instVars : [
		'dataResolver'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #accessing }
FogEVMSimulatorInterpreter >> blockHashRegisty: aMinimalBlockNumber [ 
	^ dataResolver blockHashRegisty: aMinimalBlockNumber 
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> currentBlockNumber [
	^ FogEVMRegistry forValue: dataResolver currentBlockNumber bytesLength: 32
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> gasLimit [
	^ FogEVMRegistry forValue: dataResolver gasLimit bytesLength: 32
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> minerAddress [
	^ FogEVMRegistry forValue: dataResolver minerAddress bytesLength: 20
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> storage [
	^ storage ifNil: [ storage := dataResolver storage ]
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> timestamp [
	^ FogEVMRegistry forValue: dataResolver timestamp asUnixTime bytesLength: 32
]
