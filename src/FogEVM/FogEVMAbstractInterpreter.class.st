"
This class is in charge of the implementation of the ByteCode interpretation .
"
Class {
	#name : #FogEVMAbstractInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack',
		'memory',
		'storage',
		'logs',
		'activations',
		'trace',
		'errors'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #test }
FogEVMAbstractInterpreter class >> creationCall [
	| call |
	call := FogEVMCall new.
	call contractInput: 16rc3c5a547000000000000000000000000b4ebf466889c4a0239379125a7d0f9c4e8bf2a14 asByteArray.
	call callerAddress: (FogEVMRegistry forValue: 16rb4ebf466889c4a0239379125a7d0f9c4e8bf2a14 bytesLength: 20).
	call contractAddress: (FogEVMRegistry forValue: 16r81bfba8301a073a010e9fb71fab514e53d1cc3f0 bytesLength: 20).
	call callValue: (FogEVMRegistry forValue: 0 bytesLength: 32).
	call gas: (FogEVMRegistry forValue: 3000000 bytesLength: 32).
	call gasPrice: (FogEVMRegistry forValue: 1 bytesLength: 32).
	^ call


	" 
	type Message struct {
		to         *common.Address
		from       common.Address
		nonce      uint64
		amount     *big.Int
		gasLimit   uint64
		gasPrice   *big.Int
		data       []byte
		checkNonce bool
	}
	
	
	
	
	(
            gas,
            value,
            to,
            sender,
            code_address,
            memory_input_start_position,
            memory_input_size,
            memory_output_start_position,
            memory_output_size,
            should_transfer_value,
        ) = self.get_call_params(computation)"
]

{ #category : #test }
FogEVMAbstractInterpreter class >> exampleCall [
	| call |
	call := FogEVMCall new.
	call contractInput: 16rc3c5a547000000000000000000000000b4ebf466889c4a0239379125a7d0f9c4e8bf2a14 asByteArray.
	call callerAddress: (FogEVMRegistry forValue: 16rb4ebf466889c4a0239379125a7d0f9c4e8bf2a14 bytesLength: 20).
	call contractAddress: (FogEVMRegistry forValue: 16r81bfba8301a073a010e9fb71fab514e53d1cc3f0 bytesLength: 20).
	call callValue: (FogEVMRegistry forValue: 1980 bytesLength: 32).
	call gas: (FogEVMRegistry forValue: 3000000 bytesLength: 32).
	call gasPrice: (FogEVMRegistry forValue: 1 bytesLength: 32).
	^ call


	" 
	type Message struct {
		to         *common.Address
		from       common.Address
		nonce      uint64
		amount     *big.Int
		gasLimit   uint64
		gasPrice   *big.Int
		data       []byte
		checkNonce bool
	}
	
	
	
	
	(
            gas,
            value,
            to,
            sender,
            code_address,
            memory_input_start_position,
            memory_input_size,
            memory_output_start_position,
            memory_output_size,
            should_transfer_value,
        ) = self.get_call_params(computation)"
]

{ #category : #'as yet unclassified' }
FogEVMAbstractInterpreter class >> exampleCallFor: aDataContent [
	^ {aDataContent.
	3000000 asBKHexa.
	'contract-hash'.
	'0xb4ebf466889c4a0239379125a7d0f9c4e8bf2a14'.
	'0xcontract-address'.
	0.
	'?'.
	'?'.
	'?'.
	'?'}
	" (
            gas,
            value,
            to,
            sender,
            code_address,
            memory_input_start_position,
            memory_input_size,
            memory_output_start_position,
            memory_output_size,
            should_transfer_value,
        ) = self.get_call_params(computation)"
]

{ #category : #'as yet unclassified' }
FogEVMAbstractInterpreter class >> wordSize [
	^ 32
]

{ #category : #assertion }
FogEVMAbstractInterpreter >> assertIsValidDestination: jumpDestInstruction at: newInstructionPointer [
	jumpDestInstruction isValidJumpDestination
		ifFalse: [ FogEVMRuntimeError
				signal:
					('{1} is not a valid JUMP destination. {2} instruction founded'
						format:
							{newInstructionPointer.
							jumpDestInstruction}) ]
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> binaryBytecodeFor: aContractAddress [
	^ (self resolveContractFor: aContractAddress ) binary
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> blockHashRegisty: aMinimalBlockNumber [ 
	 " Here we could put a strategy. maybe to be able to get information from running environment "
	self subclassResponsibility  
	
]

{ #category : #debug }
FogEVMAbstractInterpreter >> breakOnAddress: anAddress [
	^ self currentActivation breakOnAddress: anAddress
]

{ #category : #debug }
FogEVMAbstractInterpreter >> cancelBreakOnAddress: anAddress [
	^ self currentActivation cancelBreakOnAddress: anAddress
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> contractInput [
	^ self currentActivation call contractInput 
]

{ #category : #convenience }
FogEVMAbstractInterpreter >> copyElement: anInteger [
	self push: (stack at: anInteger) copy
]

{ #category : #convenience }
FogEVMAbstractInterpreter >> copyReturnAt: memOffset sinceByte: dataOffset length: length [
	| data bytearray |
	bytearray := self currentActivation return asByteArray.
	bytearray size >= (dataOffset + length - 1)
		ifFalse: [ FogEVMRuntimeError signal: 'Memory access out of bounds' ].
	data := bytearray copyFrom: dataOffset to: dataOffset + length - 1.
	self memory store: data at: memOffset ensure: length.
	^ data
]

{ #category : #'call activation' }
FogEVMAbstractInterpreter >> createActivationFor: anInput value: aValue gas: aGas contextAccount: aContextAccount callingAccount: anCallingAccount gasPrice: aGasPrice contract: aContract [
	| activation newCall |
	newCall := FogEVMCall new.
	newCall contractInput: anInput.
	newCall callerAddress: anCallingAccount.
	newCall contractAddress: aContract address.
	newCall callValue: aValue.
	newCall gas: aGas.
	newCall gasPrice: aGasPrice.
	activation := FogEVMActivation new.
	activation contextualAccount: aContextAccount.
	activation call: newCall.
	activation contract: aContract.
	^ activation
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> currentActivation [
	^ activations top
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> currentBlockNumber [
	self subclassResponsibility 
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> currentInstruction [
	^ self currentActivation currentInstruction
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> currentInstructionPointer [
	^ FogEVMRegistry forValue: self currentActivation currentInstructionPointer  bytesLength: 8
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> errors [
	^ errors
]

{ #category : #actions }
FogEVMAbstractInterpreter >> executeNextInstruction [
	| instruction |
	instruction := self currentActivation fetchNextInstruction.
	trace add: instruction.
	instruction accept: self with: nil.
	^ instruction
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> gasLimit [
	^ self subclassResponsibility  
	
]

{ #category : #convenience }
FogEVMAbstractInterpreter >> hexaToBoolean: anInteger [
	^ anInteger unsignedValue = 0
		ifTrue: [ false ]
		ifFalse: [ true ]
]

{ #category : #initialization }
FogEVMAbstractInterpreter >> initialize [
	super initialize.
	stack := Stack new.
	logs := OrderedCollection new.
	activations := Stack new.
	errors := OrderedCollection new.
	
]

{ #category : #convenience }
FogEVMAbstractInterpreter >> installContract: aContract at: anAddress [
	(self storageFor: anAddress) contract: aContract
]

{ #category : #'installing accounts' }
FogEVMAbstractInterpreter >> installExternalAccount: aFogEVMAccount at: anAddress [
	(self storageFor: anAddress) externalAccount: aFogEVMAccount
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> installMemory: aMemoryObject [
	^ memory ifNil: [ memory := aMemoryObject ] ifNotNil: [ FogEVMRuntimeError signal: ' Memory already in use! It cannot be changed' ]
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> installStorage: aStorage [
	^ storage ifNil: [ storage := aStorage ] ifNotNil: [ FogEVMRuntimeError signal: ' Storage already in use! It cannot be changed' ]
]

{ #category : #interpret }
FogEVMAbstractInterpreter >> interpret [
	self restart.
	[ self currentActivation isFinished ] whileFalse: [ self executeNextInstruction ]
]

{ #category : #testing }
FogEVMAbstractInterpreter >> isConfigurable [
	^ false
]

{ #category : #convenience }
FogEVMAbstractInterpreter >> keccack256: aString [
	| kck |
	kck := Keccak hashEncode: aString.
	kck := FogEVMRegistry forValue: ('16r' , kck) asNumber bytesLength: 32.
	^ kck
]

{ #category : #logs }
FogEVMAbstractInterpreter >> logs [
	^ logs
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> memory [
	^ memory ifNil: [ memory := FogEVMMemory new  ]
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> minerAddress [

	self subclassResponsibility  
	
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> pop [
	^ stack pop 
]

{ #category : #'stack operations' }
FogEVMAbstractInterpreter >> popActivation [
	^ activations pop
]

{ #category : #testing }
FogEVMAbstractInterpreter >> programHasFinished [
	^ activations size = 1 and: [ self currentActivation isFinished ]
]

{ #category : #'stack operations' }
FogEVMAbstractInterpreter >> push: aPushableObject [
	stack push: aPushableObject asPushableRegistry
]

{ #category : #'stack operations' }
FogEVMAbstractInterpreter >> pushActivation: anActivation [
	activations push: anActivation
]

{ #category : #'call activation' }
FogEVMAbstractInterpreter >> readOnlySendToContract: aContract contextualAccount: aContextAccount from: anCallingAccount contractInput: anInput returnOffset: aFogEVMRegistryReturnOffset returnSize: aFogEVMRegistryReturnSize gas: aGas gasPrice: aGasPrice [
	| computationSuccess |
	self
		pushActivation:
			(self
				createActivationFor: anInput
				value: 0
				gas: aGas
				contextAccount: aContextAccount
				callingAccount: anCallingAccount
				gasPrice: aGasPrice
				contract: aContract).
	[ self interpret.
	computationSuccess := FogEVMRegistry one ]
		on: Error
		do: [ :e | 
			self registerError: e.
			computationSuccess := FogEVMRegistry zero ].
	self copyReturnAt: aFogEVMRegistryReturnOffset unsignedValue sinceByte: 1 length: aFogEVMRegistryReturnSize unsignedValue.
	self push: computationSuccess.
	^ self popActivation return
]

{ #category : #'call activation' }
FogEVMAbstractInterpreter >> registerError: anError [
	errors add: anError.
]

{ #category : #logs }
FogEVMAbstractInterpreter >> registerLog: aContent topics: aCollectionOfTopics [
	^ logs
		add:
			(FogEVMLogEntry new
				content: aContent;
				topics: aCollectionOfTopics;
				yourself)
]

{ #category : #'contract resolving' }
FogEVMAbstractInterpreter >> resolveAccountFor: aFogEVMRegistry [
	^ (self
		storageFor: aFogEVMRegistry
		state: self runtimeState
		ifAbsent: [ FogEVMRuntimeError signal: 'The given registry point to an unexistant account' ])
		account
]

{ #category : #'contract resolving' }
FogEVMAbstractInterpreter >> resolveContractFor: aContractAddress [ 
	^ (self storageFor: aContractAddress state: (self runtimeState) ) contract
]

{ #category : #interpret }
FogEVMAbstractInterpreter >> restart [
	trace := OrderedCollection new.
	stack := Stack new.
	self currentActivation initializeInstructionPointer
]

{ #category : #'call activation' }
FogEVMAbstractInterpreter >> revertComputation: reason [ 
	self currentActivation revert.
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> runtimeState [
	" We should hash the states"
	^ 'latest'
]

{ #category : #'call activation' }
FogEVMAbstractInterpreter >> sendToContract: aContract contextualAccount: aContextAccount from: anCallingAccount contractInput: anInput returnOffset: aFogEVMRegistryReturnOffset returnSize: aFogEVMRegistryReturnSize gas: aGas gasPrice: aGasPrice transferring: aValue [
	| computationSuccess |
	self
		pushActivation:
			(self
				createActivationFor: anInput
				value: aValue
				gas: aGas
				contextAccount: aContextAccount
				callingAccount: anCallingAccount
				gasPrice: aGasPrice
				contract: aContract).
				
	[ self interpret.
	computationSuccess := FogEVMRegistry one ]
		on: Error
		do: [ :e | 
			e signal.
			self registerError: e.
			computationSuccess := FogEVMRegistry zero ].
	self
		copyReturnAt: aFogEVMRegistryReturnOffset unsignedValue
		sinceByte: 1
		length: aFogEVMRegistryReturnSize unsignedValue.
	self push: computationSuccess.
	^ self popActivation return
]

{ #category : #convenience }
FogEVMAbstractInterpreter >> stackSize [
	^ stack size 
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> storage [
	^ storage ifNil: [ storage := Dictionary new ]
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> storageFor: anAddress [
	^ storage storageFor: anAddress state: self runtimeState
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> storageFor: aContractAddress state: aStateHash [ 
	^ self storage storageFor: aContractAddress state: aStateHash 
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> storageFor: aContractAddress state: aStateHash ifAbsent: aBlock [
	^ self storage storageFor: aContractAddress state: aStateHash ifAbsent: aBlock
]

{ #category : #'stack operations' }
FogEVMAbstractInterpreter >> swapStackRegistry: anInteger with: anInteger2 [
	stack swap: anInteger with: anInteger2
]

{ #category : #accessing }
FogEVMAbstractInterpreter >> timestamp [
	" Must return a registry "
	self subclassResponsibility  
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitAdd: aFogVMAdd [
	| a b |
	a := self pop.
	b := self pop.
	self push: a + b
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitAddmod: aFogVMAddmod [
	| x y z module |
	x := self pop .
	y := self pop .
	z := self pop .
	module := (x + y) \\ z.
	self push: module 
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitAddress: aFogVMAddress [ 
	self push: self currentActivation contractAddress  
]

{ #category : #'visit - boolean alebra' }
FogEVMAbstractInterpreter >> visitAnd: aFogVMAnd [
	| a b |
	a := self pop.
	b := self pop.
	
	self push: (a & b)
]

{ #category : #'visit - account' }
FogEVMAbstractInterpreter >> visitBalance: aFogVMBalance [
	| address |
	address := self pop.
	self push: (self storageFor: address state: self runtimeState) balance
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitBlockhash: aFogVMBlockhash [
	| minimalBlockNumber |
	minimalBlockNumber := self pop.
	self push: (self blockHashRegisty: minimalBlockNumber)
]

{ #category : #'visit - memory' }
FogEVMAbstractInterpreter >> visitByte: aFogVMByte [
	| chunk position |
	chunk := self pop.
	position := self pop.
	self push: (chunk byteAt: position)
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitCall: aFogVMCall [
	| gas address value inOffset inSize retOffset retSize contractInput |
	gas := self pop.
	address := self pop.
	value := self pop.
	inOffset := self pop.
	inSize := self pop.
	retOffset := self pop.
	retSize := self pop.
	contractInput := self memory loadFrom: inOffset unsignedValue bytes: inSize unsignedValue.
	self
		sendToContract: (self resolveContractFor: address)
		contextualAccount: self currentActivation contract
		from: self currentActivation contract address
		contractInput: contractInput
		returnOffset: retOffset
		returnSize: retSize
		gas: self currentActivation gas
		gasPrice: self currentActivation gasPrice
		transferring: value
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitCallcode: aFogVMCallcode [ 
| gas address value inOffset inSize retOffset retSize contractInput |
	gas := self pop.
	address := self pop.
	value := self pop.
	inOffset := self pop.
	inSize := self pop.
	retOffset := self pop.
	retSize := self pop.
	contractInput := self memory loadFrom: inOffset unsignedValue bytes: inSize unsignedValue.
	self
		sendToContract: (self resolveContractFor: address)
		contextualAccount: (self resolveAccountFor: self currentActivation callerAddress )
		from: self currentActivation contract address
		contractInput: contractInput
		returnOffset: retOffset
		returnSize: retSize
		gas: self currentActivation gas
		gasPrice: self currentActivation gasPrice
		transferring: value
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitCalldatacopy: aFogVMCalldatacopy [
	| memFrom dataFrom length loadedData |
	memFrom := self pop.
	dataFrom := self pop.
	length := self pop.
	loadedData := self contractInput copyFrom: dataFrom unsignedValue to: dataFrom unsignedValue + length unsignedValue.
	self memory store: loadedData at: memFrom unsignedValue ensure: length unsignedValue
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitCalldataload: aFogVMCalldataload [
	| id segment upTo data |
	id := self pop.
	id := id unsignedValue + 1.
	upTo := id + 31 min: self contractInput size.
	data := self contractInput copyFrom: id to: upTo.
	data size < 32
		ifTrue: [ data := data , (ByteArray new: 32 - data size).
			data at: data size put: 1 ].
	segment := data asInteger.
	self push: (FogEVMRegistry forValue: segment bytesLength: 32)
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitCalldatasize: aFogVMCalldatasize [
	self push: (FogEVMRegistry forValue: self contractInput size bytesLength: 32)
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitCaller: aFogVMCaller [ 
	self push: self currentActivation callerAddress
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitCallvalue: aFogVMCallvalue [
	self push: self currentActivation callValue
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitCodecopy: aFogVMCodecopy [
	| loadingArea fromByte from amountOfBytes loadedData  to |
	loadingArea := self pop.
	fromByte := self pop.
	amountOfBytes := self pop.
	
	from := fromByte unsignedValue + 1 .
	to :=  from + amountOfBytes unsignedValue - 1.

	loadedData := self currentActivation binaryBytecode copyFrom: from to: to.
	self memory store: loadedData at: loadingArea unsignedValue ensure: amountOfBytes unsignedValue
	"
	hexa := program toHexa.
	hexa := hexa copyFrom: 3 to: hexa size.
	hexa := hexa copyFrom: fromInstruction to: fromInstruction + amountOfInstructions - 1.
	memory storeChunck: hexa startingAt: loadingArea ensureBytes: amountOfInstructions / 2"
	"0 to: amountOfInstructions - 1 do: [ :i | memory store: (self hexa at: fromInstruction + i) at: (loadingArea + i) asBKHexa ]"
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitCodesize: aFogVMCodesize [
	self push: (FogEVMRegistry forValue: self currentActivation bytecodeSize bytesLength: 32)
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitCoinbase: aFogVMCoinbase [ 
	self push: self minerAddress
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitDelegatecall: aFogVMDelegatecall [ 
| gas address  inOffset inSize retOffset retSize contractInput |
	gas := self pop.
	address := self pop.
	inOffset := self pop.
	inSize := self pop.
	retOffset := self pop.
	retSize := self pop.
	contractInput := self memory loadFrom: inOffset unsignedValue bytes: inSize unsignedValue.
	self
		sendToContract: (self resolveContractFor: address)
		contextualAccount: (self resolveAccountFor: self currentActivation callerAddress )
		from: self currentActivation callerAddress
		contractInput: contractInput
		returnOffset: retOffset
		returnSize: retSize
		gas: self currentActivation gas
		gasPrice: self currentActivation gasPrice
		transferring: 0
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitDifficulty: aFogVMDifficulty [ 
	self push: self blockDifficulty.
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitDiv: aFogVMDiv [
	| numerator denom |
	numerator := self pop.
	denom := self pop. 
	self
		push:
			(numerator isZero
				ifTrue: [ FogEVMRegistry zero ]
				ifFalse: [ numerator // denom ])
]

{ #category : #'visit - stack' }
FogEVMAbstractInterpreter >> visitDup: aFogVMDup [
	 self copyElement: aFogVMDup expectedPops
	"	self push: element copy"
]

{ #category : #'visit - comparision' }
FogEVMAbstractInterpreter >> visitEq: aFogVMEq [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 isEqualsTo: element2)
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitExp: aFogVMExp [
	| value exponent |
	value := self pop.
	exponent := self pop.
	self push: (value ** exponent)
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitExtcodecopy: aFogVMExtcodecopy [
	| contractAddress loadingArea fromByte amountOfBytes loadedData |
	contractAddress := self pop.
	loadingArea := self pop.
	fromByte := self pop.
	amountOfBytes := self pop.
	loadedData := (self binaryBytecodeFor: contractAddress) copyFrom: fromByte unsignedValue to: fromByte unsignedValue + amountOfBytes unsignedValue.
	self memory store: loadedData at: loadingArea unsignedValue ensure: amountOfBytes unsignedValue
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitExtcodehash: aFogVMExtcodehash [
	| address |
	address := self pop.
	self push: (self keccack256: (self binaryBytecodeFor: address))
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitExtcodesize: aFogVMExtcodesize [
	| contractAddress |
	contractAddress := self pop.
	self push: (FogEVMRegistry forValue: (self binaryBytecodeFor: contractAddress) size bytesLength: 32)
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitGas: aFogVMGas [
	self push: self currentActivation gas
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitGaslimit: aFogVMGaslimit [
	self push: self gasLimit
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitGasprice: aFogVMGasprice [
	self push: self currentActivation gasPrice
]

{ #category : #'visit - comparision' }
FogEVMAbstractInterpreter >> visitGt: aFogVMGt [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 unsignedGreaterThan: element2)
]

{ #category : #'visit - boolean alebra' }
FogEVMAbstractInterpreter >> visitIszero: aFogVMIszero [
	self push: self pop isZero
]

{ #category : #'visit - flow' }
FogEVMAbstractInterpreter >> visitJump: aFogVMJump [
	| newInstructionPointer jumpDestInstruction |
	newInstructionPointer := self pop.
	jumpDestInstruction := self currentActivation peekInstruction: newInstructionPointer.
	self assertIsValidDestination: jumpDestInstruction at: newInstructionPointer .
	self currentActivation setInstructionPointerToByte: newInstructionPointer
]

{ #category : #'visit - flow' }
FogEVMAbstractInterpreter >> visitJumpdest: aFogVMJumpdest [ 
	" nothing to do here "
]

{ #category : #'visit - flow' }
FogEVMAbstractInterpreter >> visitJumpi: aFogVMJumpi [
	| condition newInstructionPointer jumpDestInstruction |
	newInstructionPointer := self pop.
	jumpDestInstruction := self currentActivation peekInstruction: newInstructionPointer.
	condition := self pop.
	condition booleanValue
		ifTrue: [ self assertIsValidDestination: jumpDestInstruction at: newInstructionPointer.
			self currentActivation setInstructionPointerToByte: newInstructionPointer ]
]

{ #category : #'visit - log' }
FogEVMAbstractInterpreter >> visitLog: aFogVMLog [
	| fromMemory upTo topics |
	fromMemory := self pop.
	upTo := self pop.
	topics := OrderedCollection new.
	aFogVMLog logKind timesRepeat: [ topics add: self pop ].
	self registerLog: (self memory loadFrom: fromMemory unsignedValue bytes: upTo unsignedValue) topics: topics.
	'func makeLog(size int) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		topics := make([]common.Hash, size)
		mStart, mSize := stack.pop(), stack.pop()
		for i := 0; i < size; i++ {
			topics[i] = common.BigToHash(stack.pop())
		}

		d := memory.Get(mStart.Int64(), mSize.Int64())
		interpreter.evm.StateDB.AddLog(&types.Log{
			Address: contract.Address(),
			Topics:  topics,
			Data:    d,
			// This is a non-consensus field, but assigned here because
			// core/state doesnt know the current block number.
			BlockNumber: interpreter.evm.BlockNumber.Uint64(),
		})

		interpreter.intPool.put(mStart, mSize)
		return nil, nil
	}
}

// ma'
]

{ #category : #'visit - comparision' }
FogEVMAbstractInterpreter >> visitLt: aFogVMGt [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 unsignedLesserThan: element2)
]

{ #category : #'visit - memory' }
FogEVMAbstractInterpreter >> visitMload: aFogVMMload [
	| fromAddress toAddress |
	fromAddress := self pop.
	self push: (self memory loadWord: fromAddress)
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitMod: aFogVMMod [
	| x y |
	x := self pop.
	y := self pop.
	self push: x \\ y
]

{ #category : #'visit - memory' }
FogEVMAbstractInterpreter >> visitMsize: aFogVMMsize [ 
	self push:( FogEVMRegistry forValue: (self memory sizeInBytes) bytesLength: 32).
]

{ #category : #'visit - memory' }
FogEVMAbstractInterpreter >> visitMstore8: aFogVMMstore8 [
	| address value |
	address := self pop.
	value := self pop.
	self memory storeByte: value at: address
]

{ #category : #'visit - memory' }
FogEVMAbstractInterpreter >> visitMstore: aFogVMMstore [
	| address value |
	address := self pop.
	value := self pop.
	self memory storeWord: value startingAt: address
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitMul: aFogVMMul [
	| numberA numberB |
	numberA := self pop.
	numberB := self pop.
	self push: numberA * numberB
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitMulmod: aFogVMMulmod [
	| x y z module |
	x := self pop.
	y := self pop.
	z := self pop.
	module := x * y \\ z.
	self push: module
]

{ #category : #'visit - boolean alebra' }
FogEVMAbstractInterpreter >> visitNot: aFogVMNot [
	| value |
	value := self pop.
	self push: value not
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitNumber: aFogVMNumber [
	self push: self currentBlockNumber
]

{ #category : #'visit - boolean alebra' }
FogEVMAbstractInterpreter >> visitOr: aFogVMOr [
	| a b |
	a := self pop.
	b := self pop.
	self push: a | b
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitOrigin: aFogVMOrigin [ 
	self push: self originAddress
]

{ #category : #'visit - flow' }
FogEVMAbstractInterpreter >> visitPc: aFogVMPc [ 
	self push: self currentInstructionPointer 
]

{ #category : #'visit - stack' }
FogEVMAbstractInterpreter >> visitPop: aFogVMPop [
	self pop
]

{ #category : #'visit - stack' }
FogEVMAbstractInterpreter >> visitPush: aFogVMPush [
	self push: aFogVMPush
]

{ #category : #'visit - flow' }
FogEVMAbstractInterpreter >> visitReturn: aFogVMReturn [
	| from to return |
	from := self pop.
	to := self pop.
	return := self memory loadFrom: from unsignedValue bytes: to unsignedValue.
	self currentActivation return: return.
	self currentActivation isContractDeploy
		ifTrue: [ self currentActivation contract
				bytecode: (FogEVMByteCode fromBinary: self currentActivation return hex) ].
	
]

{ #category : #'visit - flow' }
FogEVMAbstractInterpreter >> visitReturndatacopy: aFogVMReturndatacopy [
	| memOffset dataOffset length |
	"func opReturnDataCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		memOffset  = stack.pop()
		dataOffset = stack.pop()
		length     = stack.pop()

		end = interpreter.intPool.get().Add(dataOffset, length)
	)
	defer interpreter.intPool.put(memOffset, dataOffset, length, end)

	if end.BitLen() > 64 || uint64(len(interpreter.returnData)) < end.Uint64() {
		return nil, errReturnDataOutOfBounds
	}
	memory.Set(memOffset.Uint64(), length.Uint64(), interpreter.returnData[dataOffset.Uint64():end.Uint64()])"
	memOffset := self pop.
	dataOffset := self pop.
	length := self pop.
	self copyReturnAt: memOffset unsignedValue sinceByte: dataOffset unsignedValue length: length unsignedValue
]

{ #category : #'visit - flow' }
FogEVMAbstractInterpreter >> visitReturndatasize: aFogVMReturndatasize [
	self push: (FogEVMRegistry forValue: self currentActivation return size bytesLength: 8)
]

{ #category : #'visit - flow' }
FogEVMAbstractInterpreter >> visitRevert: aFogVMRevert [
	| offset size content |
	offset := self pop.
	size := self pop.
	content := self memory loadFrom: offset unsignedValue bytes: size unsignedValue.
	self revertComputation: content
]

{ #category : #'visit - bit operators' }
FogEVMAbstractInterpreter >> visitSar: aFogVMSar [
	| shift value push |
	shift := self pop.
	value := self pop.  
	push := value signedRightShift: shift.
	self push: push
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitSdiv: aFogVMSdiv [
	| x y |

	x := self pop.
	y := self pop.

	self push: (x signedDivision: y)	"y sign * x sign * (x abs // y abs)"
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitSelfdestruct: aFogVMSelfdestruct [
	| withdrawTo |
	withdrawTo := self pop.
	(self storageFor: withdrawTo) addBalance: (self storageFor: self currentActivation contractAddress ) withdrawBalance.
	(self storageFor: self currentActivation contractAddress ) setDestroyed.
]

{ #category : #'visit - comparision' }
FogEVMAbstractInterpreter >> visitSgt: aFogVMSgt [
	" Signed Greater than"

	| x y |
	x := self pop.
	y := self pop.
	self push: (x signedGreaterThan: y)
]

{ #category : #'visit - hashing' }
FogEVMAbstractInterpreter >> visitSha3: aFogVMSha3 [
	| fromAddress offset kck |
	fromAddress := self pop.
	offset := self pop.
	kck := self keccack256: (self memory loadWords: fromAddress to: offset).
	self push: kck
]

{ #category : #'visit - bit operators' }
FogEVMAbstractInterpreter >> visitShl: aFogVMShl [
	| shift value |
	shift := self pop.
	value := self pop.
	self push: value << shift
]

{ #category : #'visit - bit operators' }
FogEVMAbstractInterpreter >> visitShr: aFogVMShr [
	| shift value |
	shift := self pop.
	value := self pop.
	self push: value >> shift
]

{ #category : #'visit - memory' }
FogEVMAbstractInterpreter >> visitSignextend: aFogVMSignextend [
	| length value |
	length := self pop.
	value := self pop.
	self push: (value extendRepresentationTo: length)
]

{ #category : #'visit - storage' }
FogEVMAbstractInterpreter >> visitSload: aFogVMSload [ 
	| storageAddress value address | 
	storageAddress := self pop.
	address := FogEVMRegistry forValue: storageAddress unsignedValue bytesLength: 32.
	value := (self storageFor: self currentActivation contractAddress ) getStorageAt: address. 
	self push: value. 
]

{ #category : #'visit - comparision' }
FogEVMAbstractInterpreter >> visitSlt: aFogVMSlt [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 signedLesserThan: element2)
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitSmod: aFogVMSmod [
	| x y |
	x := self pop.
	y := self pop.
	self push: (x smod: y)
]

{ #category : #'visit - storage' }
FogEVMAbstractInterpreter >> visitSstore: aFogVMSstore [
	| storageAddress value address |
	storageAddress := self pop.
	value := self pop.

	address := FogEVMRegistry forValue: storageAddress unsignedValue bytesLength: 32.
	value := (self storageFor: self currentActivation contractAddress ) atStorage: address put: value
]

{ #category : #'visit - call' }
FogEVMAbstractInterpreter >> visitStaticcall: aFogVMStaticcall [
	| gas address inOffset inSize retOffset retSize contractInput |
	gas := self pop.
	address := self pop.
	inOffset := self pop.
	inSize := self pop.
	retOffset := self pop.
	retSize := self pop.
	contractInput := self memory loadFrom: inOffset unsignedValue bytes: inSize unsignedValue.
	self
		readOnlySendToContract: (self resolveContractFor: address)
		contextualAccount: (self resolveAccountFor: self currentActivation callerAddress)
		from: self currentActivation callerAddress
		contractInput: contractInput
		returnOffset: retOffset
		returnSize: retSize
		gas: self currentActivation gas
		gasPrice: self currentActivation gasPrice
]

{ #category : #'visit - flow' }
FogEVMAbstractInterpreter >> visitStop: aFogVMStop [
	self currentActivation stop.
	
]

{ #category : #'visit - arithmetics' }
FogEVMAbstractInterpreter >> visitSub: aFogVMAdd [
	| a b |
	a := self pop.
	b := self pop.
	self push: a - b
]

{ #category : #'visit - stack' }
FogEVMAbstractInterpreter >> visitSwap: aFogVMSwap [
	self swapStackRegistry: 1 with: aFogVMSwap expectedPops 
]

{ #category : #'visit - running variables' }
FogEVMAbstractInterpreter >> visitTimestamp: aFogVMTimestamp [ 
	self push:self timestamp 
]

{ #category : #'visit - boolean alebra' }
FogEVMAbstractInterpreter >> visitXor: aFogVMXor [
	| a b |
	a := self pop.
	b := self pop.
	self push: (a xor: b)
]
