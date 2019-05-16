Class {
	#name : #FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest,
	#superclass : #FogEVMDecompileAndUnifyTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #'three parameters globals' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> decompiler [
	^ decompiler
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testADDRESS [
	| sequence |
	"ADDRESS->
		sequence + 
		 address := Runtime address.
	   stack +
	    address
	"
	sequence := self decompile: self createBytecodeForADDRESS.
		self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'one parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testBALANCE [
	| sequence |
	"BALANCE(GivenAddress)->
		sequence + 
	    balance := Runtime balanceFor: address.
	   stack +
	    balance
	"
	sequence := self decompile: (self createBytecodeForBALANCE: '0x0012341234').
		self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'one parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testBLOCKHASH [
	| sequence |
	"BLOCKHASH(BlockNumber)->
		sequence + 
	    blockHash := Runtime blockHashFor: BlockNumber.
	   stack +
	    blockHash
	"
	sequence := self
		decompile: (self createBytecodeForBLOCKHASH: '0x4323543').
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'three parameters globals' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testCALLDATACOPY [
	| sequence |
	"
	CALLDATACOPY(MemAt,CallDataFrom, DataLength)
		sequence +
			memory at: MemAt put: (Runtime calldata readFromByte: CallDataFrom amount: DataLength).
		stack
	"
	sequence := self decompile: (self createBytecodeForCALLDATACOPY: '0x1' data: '0x3' length: '0x5').
	self assert: sequence statements size equals: 1.
	self assertIsMemoryWrite:  sequence statements last .
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'one parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testCALLDATALOAD [
	| sequence |
	"CALLDATALOAD(FromByte)->
		sequence + 
		 load := Runtime calldata wordAt: FromByte.
	   stack +
	    load
	"
	bytecode := self createBytecodeForCALLDATALOAD: '0x0'.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testCALLDATASIZE [
	| sequence |
   "CALLDATASIZE->
		sequence + 
		 size := Runtime calldata size.
	   stack +
	    size
	"
	sequence := self decompile:  self createBytecodeForCALLDATASIZE.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testCALLER [
	| sequence |
	"CALLER->
		sequence + 
		 caller := Runtime message sender.
	   stack +
	    caller
	"

	sequence := self decompile:  self createBytecodeForCALLER.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testCALLSIZE [
	| sequence |
	"CALLDATASIZE->
		sequence + 
		 size := Runtime calldata size.
	   stack +
	    size
	"
	sequence := self decompile: self createBytecodeForCALLDATASIZE.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'three parameters globals' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testCODECOPY [
	| sequence |
		"
	CODECOPY(MemAt,CallDataFrom, DataLength)
		sequence +
			memory at: MemAt put: (Runtime calldata readFromByte: CallDataFrom amount: DataLength).
		stack
	"
	sequence := self decompile: (self createBytecodeForCODECOPY: '0x2' code: '0x0' length: '0x3').
	self assert: sequence statements size equals: 1.
	self assertIsMemoryWrite:  sequence statements last .
	self assert: sequence allInstructions equals: (bytecode instructions first: 5)
	
	
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testCODESIZE [
	| sequence |
	"CODESIZE->
		sequence + 
		 size := Runtime runningContract codeSize.
	   stack +
	    size
	"
	bytecode := self createBytecodeForCODESIZE.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testCOINBASE [
	| sequence |
	"COINBASE->
		sequence + 
		 coinBaseAddress := Runtime coinbase address.
	   stack +
	    coinBaseAddress
	"
	bytecode := self createBytecodeForCOINBASE.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testDIFFICULTY [
	|  sequence |
	"DIFFICULTY->
		sequence + 
	    runtime := Runtime.
	    block := runtime currentBlock.
		 difficulty := block difficulty.
	   stack +
	    difficulty
	"
	bytecode := self createBytecodeForDIFFICULTY.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'three parameters globals' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testEXTCODECOPY [
	| sequence |
	"should test over 
		func opExtCodeCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		addr       = common.BigToAddress(stack.pop())
		memOffset  = stack.pop()
		codeOffset = stack.pop()
		length     = stack.pop()
	)
	codeCopy := getDataBig(interpreter.evm.StateDB.GetCode(addr), codeOffset, length)
	memory.Set(memOffset.Uint64(), length.Uint64(), codeCopy)

	interpreter.intPool.put(memOffset, codeOffset, length)
	return nil, nil
}

// opExtCodeHash returns the code hash of a specified account.
// There are sever"
	sequence := self
		decompile:
			(self
				createBytecodeForEXTCODE: '0x02342435'
				COPY: '0x1'
				code: '0x3'
				length: '0x5').
	self assert: sequence statements size equals: 1.
	self assertIsMemoryWrite: sequence statements first.
	self assert: sequence allInstructions equals: (bytecode instructions first: 6)
]

{ #category : #'one parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testEXTCODEHASH [
	| sequence |
	"EXTCODEHASH(ContractAddress)->
		sequence + 
	    binaryHash := runtime contractCodeHashFor: address.
	   stack +
	    binaryHash
	"
	bytecode := self createBytecodeForEXTCODEHASH: '0x1234567123456'.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'one parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testEXTCODESIZE [
	| sequence |
	"EXTCODESIZE(ContractAddress)->
		sequence + 
	    binarySize := runtime contractCodeSizeFor: address.
	   stack +
	    binarySize
	"
	bytecode := self createBytecodeForEXTCODESIZE: '0x1234567123456'.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testGAS [
	| sequence |
	"GAS->
		sequence + 
	   
	    currentGas := runtime currentGas.
	   stack +
	    currentGas
	"
	bytecode := self createBytecodeForGAS.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testGASLIMIT [
	| sequence |
	"GASLIMIT->
		sequence + 
		 gasLimit := block gasLimit.
	   stack +
	    gasLimit
	"
	bytecode := self createBytecodeForGASLIMIT.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testGASPRICE [
	| sequence |
	"GASPRICE->
		sequence + 
		 gasPrice := calldata gasPrice.
	   stack +
	    gasPrice
	"
	bytecode := self createBytecodeForGASPRICE.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testNUMBER [
	| sequence |
	"NUMBER->
		sequence + 
	    runtime := Runtime.
	    block := runtime currentBlock.
		 number := block number.
	   stack +
	    number
	"
	bytecode := self createBytecodeForNUMBER.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testORIGIN [
	| sequence |
	"ORIGIN->
		sequence + 
	    origin := runtime origin.
	   stack +
	    origin
	"
	bytecode := self createBytecodeForORIGIN.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #'no parameter global' }
FogEVMDecompileAndUnifyEnvironmentalInformationAccessTest >> testTIMESTAMP [
	| sequence |
	"TIMESTAMP->
		sequence + 
		 timestamp := runtime currentBlock timestamp.
	   stack +
	    timestamp
	"
	bytecode := self createBytecodeForTIMESTAMP.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]
