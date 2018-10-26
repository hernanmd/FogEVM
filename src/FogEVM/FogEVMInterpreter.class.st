"
This class is in charge of the implementation of the ByteCode interpretation .
"
Class {
	#name : #FogEVMInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack',
		'memory',
		'executableMemory',
		'instructionPointer',
		'programFinished',
		'storage',
		'program',
		'return',
		'trace',
		'reverted',
		'call',
		'logs',
		'returnValues'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #test }
FogEVMInterpreter class >> exampleCall [
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
FogEVMInterpreter class >> exampleCallFor: aDataContent [
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
FogEVMInterpreter class >> wordSize [
	^ 32
]

{ #category : #assertion }
FogEVMInterpreter >> assertIsValidDestination: jumpDestInstruction at: newInstructionPointer [
	jumpDestInstruction isValidJumpDestination
		ifFalse: [ FogEVMRuntimeError
				signal:
					('{1} is not a valid JUMP destination. {2} instruction founded'
						format:
							{newInstructionPointer.
							jumpDestInstruction}) ]
]

{ #category : #accessing }
FogEVMInterpreter >> binary [
	^ program toBinary
]

{ #category : #accessing }
FogEVMInterpreter >> binaryBytecode [
	^ program toBinary
]

{ #category : #accessing }
FogEVMInterpreter >> blockHashRegisty: aMinimalBlockNumber [ 
	 " Here we could put a strategy. maybe to be able to get information from running environment "
	self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> breakOnAddress: anAddress [
	^ (executableMemory at: (self indexForMemoryAddress: anAddress)) breakpoint: true.
]

{ #category : #accessing }
FogEVMInterpreter >> bytecodeSize [
	^ program bytecodeSize
]

{ #category : #accessing }
FogEVMInterpreter >> call: aCall [
	call := aCall
]

{ #category : #accessing }
FogEVMInterpreter >> callGas [
	^ call gas
]

{ #category : #accessing }
FogEVMInterpreter >> callGasPrice [
	^ call gasPrice
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> callValue [
	^ call callValue
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> callerAddress [
	^ call callerAddress 
	
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> cancelBreakOnAddress: anAddress [
	^ (executableMemory at: (self indexForMemoryAddress: anAddress)) breakpoint: false.
]

{ #category : #accessing }
FogEVMInterpreter >> contract: aFogEVMMnemonicContract [
	executableMemory := aFogEVMMnemonicContract sequence copy.
	executableMemory do: #initialize.
	program := aFogEVMMnemonicContract
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> contractAddress [
	^ call contractAddress 
]

{ #category : #accessing }
FogEVMInterpreter >> contractInput [
	^ call contractInput 
]

{ #category : #convenience }
FogEVMInterpreter >> copyElement: anInteger [
	self push: (stack at: anInteger) copy
]

{ #category : #accessing }
FogEVMInterpreter >> currentInstructionPointer [
	^ FogEVMRegistry forValue: instructionPointer - 1 bytesLength: 8
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> fetchNextInstruction [
	| instruction |
	instruction := (executableMemory at: instructionPointer) .
	instructionPointer := instructionPointer + 1.
	^ instruction
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> finishComputation [
	programFinished  := true. 
]

{ #category : #accessing }
FogEVMInterpreter >> gasLimit [
	^ self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> hexa [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> hexaToBoolean: anInteger [
	^ anInteger unsignedValue = 0
		ifTrue: [ false ]
		ifFalse: [ true ]
]

{ #category : #accessing }
FogEVMInterpreter >> indexForMemoryAddress: anAddress [
	^ self indexForMemoryAddress: anAddress ifNone: [  FogEVMRuntimeError signal: 'Invalid Address. Out Of Memory' ]
]

{ #category : #accessing }
FogEVMInterpreter >> indexForMemoryAddress: anAddress ifNone: aBlock [
	| index |
	index := executableMemory
		detect: [ :i | i byteNumber = anAddress unsignedValue ]
		ifNone: [ ^ aBlock value ].
	^ executableMemory indexOf: index
]

{ #category : #initialization }
FogEVMInterpreter >> initialize [
	super initialize.
	stack := Stack new.
	logs := OrderedCollection new.
	returnValues := Stack new. 
]

{ #category : #'instruction decoding' }
FogEVMInterpreter >> interpret [
	| i |
	trace := OrderedCollection new.
	stack := Stack new.
	programFinished := false.
	self setInstructionPointerToByte: (FogEVMRegistry forValue: executableMemory first byteNumber bytesLength: 8).
	[ self programHasFinished ]
		whileFalse: [ i := self fetchNextInstruction.
			trace add: i.
			i accept: self with: nil ]
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> isTerminated [
	^ programFinished
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> keccack256: aString [
	| kck |
	kck := Keccak hashEncode: aString.
	kck := FogEVMRegistry forValue: ('16r' , kck) asNumber bytesLength: 32.
	^ kck
]

{ #category : #accessing }
FogEVMInterpreter >> logs [
	^ logs
]

{ #category : #accessing }
FogEVMInterpreter >> memory [
	^ memory ifNil: [ memory := FogEVMMemory new  ]
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> peekInstruction: anAddress [
	^ (executableMemory at: (self indexForMemoryAddress: anAddress)) instruction
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> peekNextInstruction [
	^ (executableMemory at: instructionPointer ) instruction
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> peekNextNextInstruction [
	^ (executableMemory at: instructionPointer + 1) instruction
]

{ #category : #accessing }
FogEVMInterpreter >> pop [
	^ stack pop 
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> programHasFinished [
	^ programFinished ifNil: [ programFinished := executableMemory size < instructionPointer ]
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> push: aPushableObject [
	stack push: aPushableObject asPushableRegistry
]

{ #category : #logs }
FogEVMInterpreter >> registerLog: aContent topics: aCollectionOfTopics [
	^ logs
		add:
			(FogEVMLogEntry new
				content: aContent;
				topics: aCollectionOfTopics;
				yourself)
]

{ #category : #accessing }
FogEVMInterpreter >> returnValues [
	self shouldBeImplemented.
]

{ #category : #business }
FogEVMInterpreter >> revertComputation: reason [ 
	self finishComputation.
	self halt. 
	reverted := true .
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> runtimeState [
	" We should hash the states"
	^ 'latest'
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> setInstructionPointerToByte: anInteger [
	instructionPointer := executableMemory indexOf: (executableMemory detect: [ :i | i byteNumber = anInteger unsignedValue ])
]

{ #category : #utility }
FogEVMInterpreter >> stackSize [
	^ stack size 
]

{ #category : #accessing }
FogEVMInterpreter >> storage [
	^ storage ifNil: [ storage := Dictionary new ]
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> storageFor: anAddress [
	^ self storageFor: anAddress state: self runtimeState
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> storageFor: aContractAddress state: aStateHash [ 
	self flag: #WeshouldCareAboutTheMerkelTreeState. 
	^ self storage at: aContractAddress ifAbsentPut: [ FogEVMBucketStorage new ].
]

{ #category : #'stack operations' }
FogEVMInterpreter >> swapStackRegistry: anInteger with: anInteger2 [
	stack swap: anInteger with: anInteger2
]

{ #category : #accessing }
FogEVMInterpreter >> timestamp [
	" Must return a registry "
	self shouldBeImplemented 
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitAdd: aFogVMAdd [
	| a b |
	a := self pop.
	b := self pop.
	self push: a + b
]

{ #category : #visit }
FogEVMInterpreter >> visitAddmod: aFogVMAddmod [
	| x y z module |
	x := self pop .
	y := self pop .
	z := self pop .
	module := (x + y) \\ z.
	self push: module 
]

{ #category : #visiting }
FogEVMInterpreter >> visitAddress: aFogVMAddress [ 
	self push: self contractAddress 
]

{ #category : #'visit - boolean alebra' }
FogEVMInterpreter >> visitAnd: aFogVMAnd [
	| a b |
	a := self pop.
	b := self pop.
	self push: a & b
]

{ #category : #visiting }
FogEVMInterpreter >> visitBalance: aFogVMBalance [
	| address |
	address := self pop.
	self push: (self storageFor: address state: self runtimeState) balance
]

{ #category : #visiting }
FogEVMInterpreter >> visitBlockhash: aFogVMBlockhash [
	| minimalBlockNumber |
	minimalBlockNumber := self pop.
	self push: (self blockHashRegisty: minimalBlockNumber)
]

{ #category : #visiting }
FogEVMInterpreter >> visitByte: aFogVMByte [
	| chunk position |
	chunk := self pop.
	position := self pop.
	self push: (chunk byteAt: position)
]

{ #category : #visiting }
FogEVMInterpreter >> visitCalldatacopy: aFogVMCalldatacopy [
	| memFrom dataFrom length loadedData |
	memFrom := self pop.
	dataFrom := self pop.
	length := self pop.
	loadedData := self contractInput copyFrom: dataFrom unsignedValue to: dataFrom unsignedValue + length unsignedValue.
	self memory store: loadedData at: memFrom unsignedValue ensure: length unsignedValue
]

{ #category : #'visit - call' }
FogEVMInterpreter >> visitCalldataload: aFogVMCalldataload [
	| id segment |
	id := self pop.
	segment := (self contractInput copyFrom: id unsignedValue to: id unsignedValue + 31) asInteger .
	self push: (FogEVMRegistry forValue: segment bytesLength: 32)
]

{ #category : #'visit - call' }
FogEVMInterpreter >> visitCalldatasize: aFogVMCalldatasize [
	self push: (FogEVMRegistry forValue: self contractInput size bytesLength: 32)
]

{ #category : #'visit - call' }
FogEVMInterpreter >> visitCaller: aFogVMCaller [ 
	self push: self callerAddress
]

{ #category : #'visit - call' }
FogEVMInterpreter >> visitCallvalue: aFogVMCallvalue [
	self push: self callValue
]

{ #category : #visiting }
FogEVMInterpreter >> visitCodecopy: aFogVMCodecopy [
	| loadingArea fromByte amountOfBytes loadedData |
	loadingArea := self pop.
	fromByte := self pop.
	amountOfBytes := self pop.
	loadedData := self binaryBytecode copyFrom: fromByte unsignedValue to: fromByte unsignedValue + amountOfBytes unsignedValue.
	self memory store: loadedData at: loadingArea unsignedValue ensure: amountOfBytes unsignedValue
	"
	hexa := program toHexa.
	hexa := hexa copyFrom: 3 to: hexa size.
	hexa := hexa copyFrom: fromInstruction to: fromInstruction + amountOfInstructions - 1.
	memory storeChunck: hexa startingAt: loadingArea ensureBytes: amountOfInstructions / 2"
	"0 to: amountOfInstructions - 1 do: [ :i | memory store: (self hexa at: fromInstruction + i) at: (loadingArea + i) asBKHexa ]"
]

{ #category : #visitign }
FogEVMInterpreter >> visitCodesize: aFogVMCodesize [
	self push: (FogEVMRegistry forValue: self bytecodeSize bytesLength: 32)
]

{ #category : #accessing }
FogEVMInterpreter >> visitCoinbase: aFogVMCoinbase [ 
	self push: self minerAddress
]

{ #category : #visiting }
FogEVMInterpreter >> visitDifficulty: aFogVMDifficulty [ 
	self push: self blockDifficulty.
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitDiv: aFogVMDiv [
	| numerator denom |
	numerator := self pop.
	denom := self pop. 
	self
		push:
			(numerator isZero
				ifTrue: [ 0 ]
				ifFalse: [ numerator // denom ])
]

{ #category : #'visit - stack' }
FogEVMInterpreter >> visitDup: aFogVMDup [
	 self copyElement: aFogVMDup expectedPops
	"	self push: element copy"
]

{ #category : #'visit - comparision' }
FogEVMInterpreter >> visitEq: aFogVMEq [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 isEqualsTo: element2)
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitExp: aFogVMExp [
	| value exponent |
	value := self pop.
	exponent := self pop.
	self push: value ** exponent
]

{ #category : #visiting }
FogEVMInterpreter >> visitExtcodecopy: aFogVMExtcodecopy [
	| contractAddress loadingArea fromByte amountOfBytes loadedData |
	contractAddress := self pop.
	loadingArea := self pop.
	fromByte := self pop.
	amountOfBytes := self pop.
	loadedData := (self binaryBytecodeFor: contractAddress) copyFrom: fromByte unsignedValue to: fromByte unsignedValue + amountOfBytes unsignedValue.
	self memory store: loadedData at: loadingArea unsignedValue ensure: amountOfBytes unsignedValue
]

{ #category : #visiting }
FogEVMInterpreter >> visitExtcodehash: aFogVMExtcodehash [
	| address |
	address := self pop.
	self push: (self keccack256: (self binaryBytecodeFor: address))
]

{ #category : #visiting }
FogEVMInterpreter >> visitExtcodesize: aFogVMExtcodesize [
	| contractAddress |
	contractAddress := self pop.
	self push: (FogEVMRegistry forValue: (self binaryBytecodeFor: contractAddress) size bytesLength: 32)
]

{ #category : #visiting }
FogEVMInterpreter >> visitGas: aFogVMGas [ 
	self push: self callGas 
]

{ #category : #visiting }
FogEVMInterpreter >> visitGaslimit: aFogVMGaslimit [
	self push: self gasLimit
]

{ #category : #visiting }
FogEVMInterpreter >> visitGasprice: aFogVMGasprice [ 
	self push: self callGasPrice 
]

{ #category : #'visit - comparision' }
FogEVMInterpreter >> visitGt: aFogVMGt [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 unsignedGT: element2)
]

{ #category : #'visit - boolean alebra' }
FogEVMInterpreter >> visitIszero: aFogVMIszero [
	self push: self pop isZero
]

{ #category : #'visit - flow' }
FogEVMInterpreter >> visitJump: aFogVMJump [
	| newInstructionPointer jumpDestInstruction |
	newInstructionPointer := self pop.
	jumpDestInstruction := self peekInstruction: newInstructionPointer.
	self assertIsValidDestination: jumpDestInstruction at: newInstructionPointer .
	self setInstructionPointerToByte: newInstructionPointer
]

{ #category : #'visit - flow' }
FogEVMInterpreter >> visitJumpdest: aFogVMJumpdest [ 
	" nothing to do here "
]

{ #category : #'visit - flow' }
FogEVMInterpreter >> visitJumpi: aFogVMJumpi [
	| condition newInstructionPointer jumpDestInstruction |
	newInstructionPointer := self pop.
	jumpDestInstruction := self peekInstruction: newInstructionPointer.
	condition := self pop.
	condition booleanValue
		ifTrue: [ self assertIsValidDestination: jumpDestInstruction at: newInstructionPointer.
			self setInstructionPointerToByte: newInstructionPointer ]
]

{ #category : #visiting }
FogEVMInterpreter >> visitLog: aFogVMLog [
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
FogEVMInterpreter >> visitLt: aFogVMGt [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 unsignedLesserThan: element2)
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> visitMload: aFogVMMload [
	| fromAddress toAddress |
	fromAddress := self pop.
	self push: (self memory loadWord: fromAddress)
]

{ #category : #visiting }
FogEVMInterpreter >> visitMod: aFogVMMod [
	| x y |
	x := self pop.
	y := self pop.
	self push: x \\ y
]

{ #category : #visiting }
FogEVMInterpreter >> visitMsize: aFogVMMsize [ 
	self push:( FogEVMRegistry forValue: (self memory sizeInBytes) bytesLength: 32).
]

{ #category : #visiting }
FogEVMInterpreter >> visitMstore8: aFogVMMstore8 [
	| address value |
	address := self pop.
	value := self pop.
	self memory storeByte: value at: address
]

{ #category : #'visit - memory' }
FogEVMInterpreter >> visitMstore: aFogVMMstore [
	| address value |
	address := self pop.
	value := self pop.
	self memory storeWord: value startingAt: address
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitMul: aFogVMMul [
	| numberA numberB |
	numberA := self pop.
	numberB := self pop.
	self push: numberA * numberB
]

{ #category : #visiting }
FogEVMInterpreter >> visitMulmod: aFogVMMulmod [
	| x y z module |
	x := self pop.
	y := self pop.
	z := self pop.
	module := x * y \\ z.
	self push: module
]

{ #category : #'visit - boolean alebra' }
FogEVMInterpreter >> visitNot: aFogVMNot [
	| value |
	value := self pop.
	self push: value not
]

{ #category : #visiting }
FogEVMInterpreter >> visitNumber: aFogVMNumber [
	self push: self currentBlockNumber
]

{ #category : #'visit - boolean alebra' }
FogEVMInterpreter >> visitOr: aFogVMOr [
	| a b |
	a := self pop.
	b := self pop.
	self push: a | b
]

{ #category : #visiting }
FogEVMInterpreter >> visitOrigin: aFogVMOrigin [ 
	self push: self originAddress
]

{ #category : #visiting }
FogEVMInterpreter >> visitPc: aFogVMPc [ 
	self push: self currentInstructionPointer 
]

{ #category : #'visit - stack' }
FogEVMInterpreter >> visitPop: aFogVMPop [
	self pop
]

{ #category : #'visit - stack' }
FogEVMInterpreter >> visitPush: aFogVMPush [
	self push: aFogVMPush
]

{ #category : #'visit - flow' }
FogEVMInterpreter >> visitReturn: aFogVMReturn [
	| from to |
	from := self pop.
	to := self pop.
	return := self memory loadFrom: from unsignedValue bytes: to unsignedValue .
	returnValues push: return.
	self finishComputation
]

{ #category : #visiting }
FogEVMInterpreter >> visitReturndatacopy: aFogVMReturndatacopy [
	| memOffset dataOffset length data |
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
	returnValues top size >= (dataOffset unsignedValue + length unsignedValue - 1)
		ifFalse: [ FogEVMRuntimeError signal: 'Memory access out of bounds' ].
	data := returnValues top
		copyFrom: dataOffset unsignedValue
		to: dataOffset unsignedValue + length unsignedValue -1 .
	self memory store: data at: memOffset unsignedValue ensure: length unsignedValue
]

{ #category : #visiting }
FogEVMInterpreter >> visitRevert: aFogVMRevert [ 
	| offset size content |
	offset := self pop. 
	size := self pop. 
	
	content := self copyMemoryFrom: offset bytes: size .
	self revertComputation: content.  
	
	
]

{ #category : #visiting }
FogEVMInterpreter >> visitSar: aFogVMSar [
	| shift value push |
	shift := self pop.
	value := self pop.  
	push := value signedRightShift: shift.
	self push: push
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> visitSdiv: aFogVMSdiv [
	| x y |

	x := self pop.
	y := self pop.

	self push: (x signedDivision: y)	"y sign * x sign * (x abs // y abs)"
]

{ #category : #visiting }
FogEVMInterpreter >> visitSelfdestruct: aFogVMSelfdestruct [
	| withdrawTo |
	withdrawTo := self pop.
	(self storageFor: withdrawTo) addBalance: (self storageFor: self contractAddress) withdrawBalance.
	(self storageFor: self contractAddress) setDestroyed.
]

{ #category : #visiting }
FogEVMInterpreter >> visitSgt: aFogVMSgt [
	" Signed Greater than"

	| x y |
	x := self pop.
	y := self pop.
	self push: (x signedGreaterThan: y)
]

{ #category : #'visit - hashing' }
FogEVMInterpreter >> visitSha3: aFogVMSha3 [
	| fromAddress offset kck |
	fromAddress := self pop.
	offset := self pop.
	kck := self keccack256: (self memory loadWords: fromAddress to: offset).
	self push: kck
]

{ #category : #visiting }
FogEVMInterpreter >> visitShl: aFogVMShl [
	| shift value |
	shift := self pop.
	value := self pop.
	self push: value << shift
]

{ #category : #visiting }
FogEVMInterpreter >> visitShr: aFogVMShr [
	| shift value |
	shift := self pop.
	value := self pop.
	self push: value >> shift
]

{ #category : #visiting }
FogEVMInterpreter >> visitSignextend: aFogVMSignextend [
	| length value |
	length := self pop.
	value := self pop.
	self push: (value extendRepresentationTo: length)
]

{ #category : #'visit - storage' }
FogEVMInterpreter >> visitSload: aFogVMSload [ 
	| storageAddress value address | 
	storageAddress := self pop.
	address := FogEVMRegistry forValue: storageAddress unsignedValue bytesLength: 32.
	value := (self storageFor: self contractAddress) getStorageAt: address. 
	self push: value. 
]

{ #category : #'visit - comparision' }
FogEVMInterpreter >> visitSlt: aFogVMSlt [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 signedLesserThan: element2)
]

{ #category : #visit }
FogEVMInterpreter >> visitSmod: aFogVMSmod [
	| x y |
	x := self pop.
	y := self pop.
	self push: (x smod: y)
]

{ #category : #'visit - storage' }
FogEVMInterpreter >> visitSstore: aFogVMSstore [
	| storageAddress value address |
	storageAddress := self pop.
	value := self pop.
	address := FogEVMRegistry forValue: storageAddress unsignedValue bytesLength: 32.
	value := (self storageFor: self contractAddress) atStorage: address put: value
]

{ #category : #'visiti stop' }
FogEVMInterpreter >> visitStop: aFogVMStop [
	programFinished := true
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitSub: aFogVMAdd [
	| a b |
	a := self pop.
	b := self pop.
	self push: a - b
]

{ #category : #'visit - stack' }
FogEVMInterpreter >> visitSwap: aFogVMSwap [
	self swapStackRegistry: 1 with: aFogVMSwap expectedPops 
]

{ #category : #accessing }
FogEVMInterpreter >> visitTimestamp: aFogVMTimestamp [ 
	self push:self timestamp 
]

{ #category : #visiting }
FogEVMInterpreter >> visitXor: aFogVMXor [
	| a b |
	a := self pop.
	b := self pop.
	self push: (a xor: b)
]
