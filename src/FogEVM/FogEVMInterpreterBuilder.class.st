Class {
	#name : #FogEVMInterpreterBuilder,
	#superclass : #Object,
	#instVars : [
		'interpreterClass',
		'memoryClass',
		'storageClass',
		'bytecode',
		'callData',
		'interpreterData',
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
		'binaryData'
	],
	#category : #'FogEVM-UIDebugger-Open'
}

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
		ifTrue: [ interpreter
				blockDifficulty: blockDifficulty;
				startedAt: startedAt;
				timestamp: timestamp;
				gasLimit: gasLimit;
				blockNumber: blockNumber;
				blockHash: blockHash ].
	interpreter restart.
	^ interpreter
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
FogEVMInterpreterBuilder >> contractBytecode: aCollection named: aString [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
FogEVMInterpreterBuilder >> contractBytecode: aBinaryData named: aName deploying: aBytecodeSelector [
	| selector |
	binaryData := aBinaryData.
	selector := aBytecodeSelector = #Deploy
		ifTrue: [ #binary ]
		ifFalse: [ #runtime ].
	executing := FogEVMByteCode fromBinary: (aBinaryData at: selector)
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

{ #category : #setting }
FogEVMInterpreterBuilder >> interpreterClass: anInterpreterClass memoryClass: aMemoryClass storageClass: aStorageClass [
	interpreter := anInterpreterClass new.
	interpreter installMemory: aMemoryClass new.
	interpreter installStorage: aStorageClass new
]

{ #category : #testing }
FogEVMInterpreterBuilder >> shoulIinstallContract [
	^ shoulIinstallContract ifNil: [ false ]
]
