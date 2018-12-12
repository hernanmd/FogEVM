"
Simulation interpreter is an interpreter that extends the abstract interpreter adding the environmental information gather through a DataResolver (FogEVMFogDataResolver | FogEVMMockedDataResolver), allowing to locally execute the bytecode in a sandbox. 

"
Class {
	#name : #FogEVMSimulatorInterpreter,
	#superclass : #FogEVMAbstractInterpreter,
	#instVars : [
		'dataResolver',
		'readMemoryBreakpoint',
		'writeMemoryBreakpoint',
		'writeStorageBreakpoint',
		'readStorageBreakpoint'
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
FogEVMSimulatorInterpreter >> initialize [
	super initialize.
	readMemoryBreakpoint := OrderedCollection new.
	writeMemoryBreakpoint := OrderedCollection new.
	writeStorageBreakpoint := OrderedCollection new.
	readStorageBreakpoint := OrderedCollection new.

]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> isConfigurable [
	^ true
]

{ #category : #breakpoints }
FogEVMSimulatorInterpreter >> memoryAddressesReadBy: anInstruction [
	^ (self predictIO: anInstruction) memoryReadAddresses
]

{ #category : #breakpoints }
FogEVMSimulatorInterpreter >> memoryAddressesWrittenBy: anInstruction [ 
	^ (self predictIO: anInstruction) memoryWriteAddresses
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> minerAddress [
	^ FogEVMRegistry forValue: self dataResolver minerAddress bytesLength: 20
]

{ #category : #convenience }
FogEVMSimulatorInterpreter >> predictIO: anInstruction [
	| predictor |
	predictor := FogEVMIOPrediction new.
	predictor stack: stack copy. 
	anInstruction accept: predictor.
	^ predictor
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> restart [
	memory restart.
	super restart.
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> shouldBreakNow [
	| next |
	next := self currentActivation nextInstruction.
	next shouldBreak
		ifTrue: [ ^ true ].
	(next readsMemory
		and: [ readMemoryBreakpoint anySatisfy: [ :add | (self memoryAddressesReadBy: next instruction) contains: [ :c | c unsignedValue = add ] ] ])
		ifTrue: [ ^ true ].
	(next writesMemory
		and: [ writeMemoryBreakpoint anySatisfy: [ :add | (self memoryAddressesWrittenBy: next instruction) contains: [ :c | c unsignedValue = add ] ] ])
		ifTrue: [ ^ true ].
	(next writesStorage
		and: [ writeStorageBreakpoint anySatisfy: [ :add | (self storageAddressesWrittenBy: next instruction) contains: [ :c | c unsignedValue = add ] ] ])
		ifTrue: [ ^ true ].
	(next readsStorage
		and: [ readStorageBreakpoint anySatisfy: [ :add | (self storageAddressesReadBy: next instruction) contains: [ :c | c unsignedValue = add ] ] ])
		ifTrue: [ ^ true ].
	^ false
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> stack [
	^ stack
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> startedTime [
	^ self dataResolver startedTime
]

{ #category : #breakpoints }
FogEVMSimulatorInterpreter >> storageAddressesReadBy: anInstruction [ 
	^ (self predictIO: anInstruction) storageReadAddresses
]

{ #category : #accessing }
FogEVMSimulatorInterpreter >> timestamp [
	^ FogEVMRegistry forValue: self dataResolver timestamp asUnixTime bytesLength: 32
]
