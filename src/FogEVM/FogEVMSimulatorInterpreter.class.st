Class {
	#name : #FogEVMSimulatorInterpreter,
	#superclass : #FogEVMAbstractInterpreter,
	#instVars : [
		'dataResolver'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #accessing }
FogEVMSimulatorInterpreter >> blockDifficulty [
	^ self dataResolver blockDifficulty
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> blockHashRegisty: aMinimalBlockNumber [ 
	^ self dataResolver blockHashRegisty: aMinimalBlockNumber 
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> currentBlockNumber [
	^ FogEVMRegistry forValue: self dataResolver currentBlockNumber bytesLength: 32
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> dataResolver [
	^ dataResolver 
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> dataResolver: aResolver [ 
	^ dataResolver := aResolver
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> gasLimit [
	^ FogEVMRegistry forValue: self dataResolver gasLimit bytesLength: 32
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> isConfigurable [
	^ true
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> minerAddress [
	^ FogEVMRegistry forValue: self dataResolver minerAddress bytesLength: 20
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> stack [
	^ stack
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> startedTime [
	^ self dataResolver startedTime
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> timestamp [
	^ FogEVMRegistry forValue: self dataResolver timestamp asUnixTime bytesLength: 32
]
