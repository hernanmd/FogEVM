Class {
	#name : #FogEVMInterpreterBuilder,
	#superclass : #Object,
	#instVars : [
		'interpreter',
		'contract',
		'executing',
		'contractsCodeAddress',
		'activation',
		'blockDifficulty',
		'startedAt',
		'timestamp',
		'gasLimit',
		'blockNumber',
		'blockHash',
		'shoulIinstallContract',
		'columnsToShow',
		'kind',
		'binaryData',
		'useFogValues',
		'session'
	],
	#classVars : [
		'registeredStorages'
	],
	#classInstVars : [
		'registeredStorages'
	],
	#category : #'FogEVM-UIDebugger-Builder'
}

{ #category : #accessing }
FogEVMInterpreterBuilder >> allDeployedContracts [
	^ interpreter storage allDeployedContracts
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> availableInterpreters [
	^ { FogEVMSimulatorInterpreter }
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> availableMemory [
	^ {FogEVMMemory} , FogEVMMemory allSubclasses
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> availableStorage [
		^ self registeredStorages asArray, {FogEVMMemoryStorage} , FogEVMMemoryStorage allSubclasses
]

{ #category : #settings }
FogEVMInterpreterBuilder >> blockDifficulty: aFogEVMRegistry startedAt: aDateAndTime timestamp: aDateAndTime3 gasLimit: aFogEVMRegistry4 blockNumber: aFogEVMRegistry5 blockHash: aFogEVMRegistry6 [
	blockDifficulty := aFogEVMRegistry.
	startedAt := aDateAndTime.
	timestamp := aDateAndTime3.
	gasLimit := aFogEVMRegistry4.
	blockNumber := aFogEVMRegistry5.
	blockHash := aFogEVMRegistry6
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> build [
	contract := FogEVMContract new
		bytecode: executing;
		address: contractsCodeAddress yourself.
	activation contract: contract.
	self shoulIinstallContract
		ifTrue: [ interpreter installContract: contract at: contract address ].
	interpreter pushActivation: activation.
	interpreter isConfigurable
		ifTrue: [ interpreter dataResolver: self buildDataResolver].
	interpreter restart.
	^ interpreter
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> buildDataResolver [
	^ useFogValues
		ifTrue: [ FogEVMFogDataResolver new
				fog: session;
				yourself ]
		ifFalse: [ FogEVMMockedDataResolver new
				blockDifficulty: blockDifficulty;
				startedAt: startedAt;
				timestamp: timestamp;
				gasLimit: gasLimit;
				blockNumber: blockNumber;
				blockHash: blockHash ]
]

{ #category : #testing }
FogEVMInterpreterBuilder >> columnsToShow [
	^ columnsToShow
]

{ #category : #testing }
FogEVMInterpreterBuilder >> columnsToShow: anAmount [
	columnsToShow := anAmount
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> defaultInterpreter [
	^  FogEVMSimulatorInterpreter 
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> defaultMemory [
	^ FogEVMTraceableMemory
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> defaultStorage [
	^ self availableStorage first
]

{ #category : #building }
FogEVMInterpreterBuilder >> fogURL: anUrl [

	session := (FogConnection on: anUrl) nonCachedSession . 
]

{ #category : #setting }
FogEVMInterpreterBuilder >> from: from to: to contract: contractAddress context: contextAddress input: aCollection value: aValue gas: gas gasPrice: gasPrice [
	| call |
	call := FogEVMCall new.
	call contractInput: aCollection asByteArray.
	call callerAddress: from.
	call contractAddress: to.
	call callValue: aValue.
	call gas: gas.
	call gasPrice: gasPrice.
	contractsCodeAddress := contractAddress.
	activation := FogEVMActivation new.
	activation contextualAccount: contextAddress.
	activation call: call.
	^ activation
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> input [
	^ binaryData
]

{ #category : #building }
FogEVMInterpreterBuilder >> input: aString [
	binaryData := aString.
	executing := FogEVMByteCode fromBinary: binaryData
]

{ #category : #setting }
FogEVMInterpreterBuilder >> interpreterClass: anInterpreterClass memoryClass: aMemoryClass storageClass: aStorageClass [
	| storage |
	interpreter := anInterpreterClass new.
	interpreter installMemory: aMemoryClass new.
	storage := aStorageClass isClass
		ifTrue: [ aStorageClass new ]
		ifFalse: [ aStorageClass ].
	interpreter installStorage: storage.
	self registeredStorages add: storage
]

{ #category : #setting }
FogEVMInterpreterBuilder >> isActivation [
	^ kind = #Activate
]

{ #category : #testing }
FogEVMInterpreterBuilder >> isDeploy [
	^ kind = #Deploy
]

{ #category : #setting }
FogEVMInterpreterBuilder >> isTransference [
	^ kind = #Transfer
]

{ #category : #setting }
FogEVMInterpreterBuilder >> registeredStorages [
	^ registeredStorages ifNil: [ registeredStorages := Set new ] 
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> session [
	^ session
]

{ #category : #setting }
FogEVMInterpreterBuilder >> setKindOfTrasaction: aKind [
	kind := aKind
]

{ #category : #testing }
FogEVMInterpreterBuilder >> shoulIinstallContract [
	^ shoulIinstallContract ifNil: [ false ]
]

{ #category : #building }
FogEVMInterpreterBuilder >> useFogValues: aBoolean [
	useFogValues := aBoolean
]
