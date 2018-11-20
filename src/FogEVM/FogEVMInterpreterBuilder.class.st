"
The interpreter builder is the model behind the OpenWizard UI. 
It provides the logic for accessing to: available values, default values and Fog session related information. 
It has the responsibility of eventually building a fully functional interpreter, with the bytecode ready to be executed.

For tracking usually used configurations it use two class variables: registeredContracts registeredStorages. 


"
Class {
	#name : #FogEVMInterpreterBuilder,
	#superclass : #Object,
	#instVars : [
		'interpreter',
		'executing',
		'contractsCodeAddress',
		'activation',
		'blockDifficulty',
		'startedAt',
		'timestamp',
		'gasLimit',
		'blockNumber',
		'blockHash',
		'columnsToShow',
		'kind',
		'binaryData',
		'useFogValues',
		'session',
		'sourceCode',
		'returningType'
	],
	#classVars : [
		'registeredContracts',
		'registeredStorages'
	],
	#classInstVars : [
		'registeredStorages'
	],
	#category : #'FogEVM-UIDebugger-Builder'
}

{ #category : #'default values' }
FogEVMInterpreterBuilder >> allDeployedContracts [
	^ interpreter storage allDeployedContracts
]

{ #category : #'default values' }
FogEVMInterpreterBuilder >> availableInterpreters [
	^ { FogEVMSimulatorInterpreter }
]

{ #category : #'default values' }
FogEVMInterpreterBuilder >> availableMemory [
	^ {FogEVMMemory} , FogEVMMemory allSubclasses
]

{ #category : #'default values' }
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

{ #category : #build }
FogEVMInterpreterBuilder >> build [
	activation contract: self resolveContract.
	interpreter pushActivation: activation.
	interpreter isConfigurable
		ifTrue: [ interpreter dataResolver: self buildDataResolver ].
	interpreter restart.
	^ interpreter
]

{ #category : #build }
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

{ #category : #settings }
FogEVMInterpreterBuilder >> bytecodIsInTheInput [
	^ activation call contractAddress isNil
]

{ #category : #testing }
FogEVMInterpreterBuilder >> columnsToShow [
	^ columnsToShow
]

{ #category : #testing }
FogEVMInterpreterBuilder >> columnsToShow: anAmount [
	columnsToShow := anAmount
]

{ #category : #'default values' }
FogEVMInterpreterBuilder >> defaultInterpreter [
	^  FogEVMSimulatorInterpreter 
]

{ #category : #'default values' }
FogEVMInterpreterBuilder >> defaultMemory [
	^ FogEVMTraceableMemory
]

{ #category : #'default values' }
FogEVMInterpreterBuilder >> defaultStorage [
	^ self availableStorage first
]

{ #category : #'default values' }
FogEVMInterpreterBuilder >> eraseAllAvailableStorages [
	registeredStorages removeAll.
]

{ #category : #testing }
FogEVMInterpreterBuilder >> eraseStorage: aStorage [
	registeredStorages remove: aStorage ifAbsent: [  ].
]

{ #category : #settings }
FogEVMInterpreterBuilder >> fogURL: anUrl [

	session := (FogConnection on: anUrl) nonCachedSession . 
]

{ #category : #settings }
FogEVMInterpreterBuilder >> from: from to: to contract: contractAddress context: contextAddress input: aCollection value: aValue gas: gas gasPrice: gasPrice [
	| call |
	call := FogEVMCall new.
	call contractInput: aCollection.
	call callerAddress: from.
	call contractAddress: to.
	call callValue: aValue.
	call gas: gas.
	call gasPrice: gasPrice.
	contractsCodeAddress := contractAddress.
	activation := FogEVMDebuggableActivation  new.
	activation contextualAccount: contextAddress.
	activation returningType: returningType .
	activation call: call.
	^ activation
]

{ #category : #'as yet unclassified' }
FogEVMInterpreterBuilder >> generateContractHashFor: aFogEVMByteCode [
	| number |
	number := Number readFrom: (Keccak hashMessage: aFogEVMByteCode hash + DateAndTime now asUnixTime) asByteArray hex readStream base: 16.
	^ FogEVMRegistry forValue: number bytesLength: 20
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> input [
	^ binaryData
]

{ #category : #settings }
FogEVMInterpreterBuilder >> input: aString returningType: aType [
	binaryData := aString.
	returningType := aType.
	
]

{ #category : #settings }
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

{ #category : #testing }
FogEVMInterpreterBuilder >> isActivation [
	^ kind = #Activate
]

{ #category : #testing }
FogEVMInterpreterBuilder >> isDeploy [
	^ kind = #Deploy
]

{ #category : #testing }
FogEVMInterpreterBuilder >> isTransference [
	^ kind = #Transfer
]

{ #category : #'default values' }
FogEVMInterpreterBuilder >> loadPackageForFileReference: aFile [
	| package |
	package := self session loadPackageForFileReference: aFile.
	self registeredContracts at: aFile put: package.
	^ package
]

{ #category : #'default values' }
FogEVMInterpreterBuilder >> loadedPackages [
	^ self registeredContracts associations
]

{ #category : #settings }
FogEVMInterpreterBuilder >> registeredContracts [
	^ registeredContracts ifNil: [ registeredContracts := Dictionary new ] 
]

{ #category : #settings }
FogEVMInterpreterBuilder >> registeredStorages [
	^ registeredStorages ifNil: [ registeredStorages := Set new ] 
]

{ #category : #build }
FogEVMInterpreterBuilder >> resolveContract [
	^ self bytecodIsInTheInput
		ifTrue: [ | contract |
			executing := FogEVMByteCode fromBinary: binaryData.
			contract := FogEVMContract new
				bytecode: executing;
				address: (self generateContractHashFor:executing );
				yourself.
			interpreter installContract: contract at: contract address.
			contract ]
		ifFalse: [ (interpreter storageFor: activation call contractAddress) contract ]
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> session [
	^ session
]

{ #category : #settings }
FogEVMInterpreterBuilder >> setKindOfTrasaction: aKind [
	kind := aKind
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> sourceCode: aString [ 
	sourceCode := aString
]

{ #category : #settings }
FogEVMInterpreterBuilder >> useFogValues: aBoolean [
	useFogValues := aBoolean
]
