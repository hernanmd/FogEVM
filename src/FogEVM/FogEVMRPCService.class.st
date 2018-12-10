Class {
	#name : #FogEVMRPCService,
	#superclass : #Object,
	#instVars : [
		'dataResolver',
		'transactions'
	],
	#classVars : [
		'currentStorage'
	],
	#category : #'FogEVM-Service'
}

{ #category : #call }
FogEVMRPCService >> call: aCollection [
	| call activation executing relatedContract evmInterpreter |
	call := FogEVMCall loadDefinition: aCollection first.
	activation := FogEVMActivation new.
	activation contextualAccount: call contractAddress.
	activation call: call.
	evmInterpreter := self evmInterpreter.
	relatedContract := call contractAddress
		ifNil: [ | contract |
			executing := FogEVMByteCode fromByteArray: call contractInput.
			contract := FogEVMContract new
				bytecode: executing;
				address: (self generateContractHashFor: executing);
				yourself.
			evmInterpreter installContract: contract at: contract address.
			contract ]
		ifNotNil: [ (evmInterpreter storageFor: activation call contractAddress) contract ].
	activation contract: relatedContract.
	evmInterpreter pushActivation: activation.
	evmInterpreter interpret.
	self assert: evmInterpreter currentActivation return last isZero.
	^ '0x', evmInterpreter currentActivation return allButLast hex
]

{ #category : #initialization }
FogEVMRPCService >> currentStorage [
	^ currentStorage := currentStorage ifNil: [ FogEVMMemoryStorage new ]
]

{ #category : #initialization }
FogEVMRPCService >> dataResolver [
	^ dataResolver ifNil: [ dataResolver := FogTestingDataLoader new ]
]

{ #category : #initialize }
FogEVMRPCService >> evmInterpreter [
	| evmInterpreter |
	evmInterpreter := FogEVMSimulatorInterpreter new.
	evmInterpreter dataResolver: self dataResolver.
	evmInterpreter installMemory: FogEVMTraceableMemory new.
	evmInterpreter installStorage: self currentStorage.
	^ evmInterpreter
]

{ #category : #hashing }
FogEVMRPCService >> generateContractHashFor: aFogEVMByteCode [
	| number |
	number := Number readFrom: (Keccak hashMessage: aFogEVMByteCode hash + DateAndTime now asUnixTime) asByteArray hex readStream base: 16.
	^ FogEVMRegistry forValue: number bytesLength: 20
]

{ #category : #testing }
FogEVMRPCService >> getBlockByHash: aCollection [
	^ self dataResolver fog getBlockByHash: aCollection first asSymbol full: aCollection second
]

{ #category : #eth }
FogEVMRPCService >> getBlockByNumber: aCollection [
	^ aCollection first isNumber
		ifFalse: [ self dataResolver fog getBlockByTag: aCollection first asSymbol full: aCollection second ]
		ifTrue: [ self dataResolver fog getBlockByNumber: aCollection first asSymbol full: aCollection second ]
]

{ #category : #accessing }
FogEVMRPCService >> getStorageAt: aCollection [
	| ref storage slotRef |
	ref := FogEVMRegistry forValue: aCollection first asNumber bytesLength: 20.
	slotRef := FogEVMRegistry forValue: aCollection second asBKNumber bytesLength: 32.
	storage := self currentStorage storageFor: ref state: aCollection last.
	^ (storage at: slotRef) asWordByteArray hex
]

{ #category : #accessing }
FogEVMRPCService >> getTransactionReceipt: aCollection [
	| future activation |
	future := transactions at: aCollection first.
	future isFinished
		ifFalse: [ ^ nil ].
	[ activation := (future synchronizeTimeout: 1 second) currentActivation ]
		on: Error
		do: [ :err | 
			^ {(#transactionHash -> aCollection first).
			(#transactionIndex -> '').
			(#blockHash -> '').
			(#blockNumber -> '').
			(#from -> activation callerAddress hex).
			(#to -> activation contractAddress hex).
			(#cumulativeGas -> '').
			(#gasUsed -> '').
			(#contractAddress -> activation contractAddress hex)} asDictionary ].
	^ {(#transactionHash -> aCollection first).
	(#transactionIndex -> 1).
	(#blockHash -> '0xabcabcabc1235125124').
	(#blockNumber -> 2123123).
	(#from -> activation callerAddress hex).
	(#to -> activation contractAddress hex).
	(#cumulativeGas -> 2343345435).
	(#gasUsed -> 3234234).
	(#contractAddress -> activation contractAddress hex)} asDictionary
]

{ #category : #testing }
FogEVMRPCService >> initialize [
	super initialize.
	transactions := Dictionary new
]

{ #category : #accessing }
FogEVMRPCService >> module: aString [ 
	^ self 
]

{ #category : #processing }
FogEVMRPCService >> processMessage: aFogMessage [
	^ Dictionary new
		at: #result
			put:
			((self module: aFogMessage module)
				perform: aFogMessage serviceSelector
				withArguments: {aFogMessage parameters});
		yourself
]

{ #category : #'as yet unclassified' }
FogEVMRPCService >> sendTransaction: aCollection [
	| call activation executing relatedContract evmInterpreter txId |
	call := FogEVMCall loadDefinition: aCollection first.
	activation := FogEVMActivation new.
	activation contextualAccount: call contractAddress.
	activation call: call.
	evmInterpreter := self evmInterpreter.
	relatedContract := call contractAddress
		ifNil: [ | contract |
			executing := FogEVMByteCode fromByteArray: call contractInput.
			contract := FogEVMContract new
				bytecode: executing;
				address: (self generateContractHashFor: executing);
				yourself.
			evmInterpreter installContract: contract at: contract address.
			contract ]
		ifNotNil: [ (evmInterpreter storageFor: activation call contractAddress) contract ].
	txId := UUID new.
	transactions
		at: txId
		put:
			[ activation contract: relatedContract.
			evmInterpreter pushActivation: activation.
			evmInterpreter interpret.
			evmInterpreter ] future.
	^ txId
]
