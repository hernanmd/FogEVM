Class {
	#name : #FogEVMDecompileEnvironmentalInformationAccessTest,
	#superclass : #FogEVMUnitaryTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #'three parameters globals' }
FogEVMDecompileEnvironmentalInformationAccessTest >> decompiler [
	^ decompiler
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testADDRESS [
	| sequence |
	"ADDRESS->
		sequence + 
	    runtime := Runtime.
	    runningContract := runtime runningContract.
		 address := runningContract address.
	   stack +
	    address
	"
	sequence := self decompile: self createBytecodeForADDRESS.
	self assertGlobalWithoutParameter: sequence
]

{ #category : #'one parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testBALANCE [
	| sequence |
	"BALANCE(GivenAddress)->
		sequence + 
		 address := GivenAddress
	    runtime := Runtime.
	    balance := runtime balanceFor: address.
	   stack +
	    balance
	"
	sequence := self decompile: (self createBytecodeForBALANCE: '0x0012341234').
	self assertGlobalWithOneParameter: sequence .
]

{ #category : #'one parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testBLOCKHASH [
	| sequence |
	"BLOCKHASH(BlockNumber)->
		sequence + 
		 number := BlockNumber.
	    runtime := Runtime.
	    blockHash := runtime blockHashFor:number.
	   stack +
	    blockHash
	"
	sequence := self decompile: (self createBytecodeForBLOCKHASH: '0x4323543').
	self assertGlobalWithOneParameter: sequence
]

{ #category : #'three parameters globals' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testCALLDATACOPY [
	| sequence |
	"
	CALLDATACOPY(MemAt,CallDataFrom, DataLength)
		sequence +
			writeAt := MemAt.
			readFrom := CallDataFrom.
			size := DataLength
			runtime := Runtime.
			calldata := runtime calldata.
			data := calldata readFromByte: readFrom amount: size.
			memory at: writeAt put: data.
		stack
	"
	sequence := self decompile: (self createBytecodeForCALLDATACOPY: '0x1' data: '0x3' length: '0x5').
	self assert: self decompiler programHasFinished.
	self assertIsSequence: sequence.
	self assert: sequence allInstructions size equals: 5.
	self assert: sequence statements size equals: 7.
	(sequence statements first: 6) do: [ :s | self assertIsAssignment: s ].
	self assertIsMemoryWrite: sequence statements last.
	(sequence statements first: 3) do: [ :s | self assertIsLiteral: s value ].
	self assertIsVariable: sequence statements fourth variable named: #Runtime.
	self assertIsRuntimeGlobal: sequence statements fourth value.
	self assertIsMessageSend:  sequence statements fifth value. 
	self assertIsMessageSend:  sequence statements sixth value. 
	self assert: sequence statements second variable equals: sequence statements sixth value arguments first .
	self assert: sequence statements first variable equals: sequence statements sixth value arguments second .
	self assert: sequence statements seventh address equals: sequence statements third variable . 
	
	self assert: self decompiler scope stack size equals: 0
]

{ #category : #'one parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testCALLDATALOAD [
	| bytecode sequence |
	"CALLDATALOAD(FromByte)->
		sequence + 
		 byte := FromByte.
	    runtime := Runtime.
	    calldata := runtime calldata.
		 load := calldata wordAt: byte.
	   stack +
	    load
	"
	bytecode := self createBytecodeForCALLDATALOAD: '0x0'.
	sequence := self decompile: bytecode.
	self assertGlobalWithOneParameterAndOneIndirection: sequence
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testCALLDATASIZE [
	| sequence |
   "CALLDATASIZE->
		sequence + 
	    runtime := Runtime.
	    calldata := runtime calldata.
		 size := calldata size.
	   stack +
	    size
	"
	sequence := self decompile:  self createBytecodeForCALLDATASIZE.
	self assertGlobalWithoutParameter: sequence
	
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testCALLER [
	| sequence |
	"CALLER->
		sequence + 
	    runtime := Runtime.
	    message := runtime message.
		 caller := message sender.
	   stack +
	    caller
	"

	sequence := self decompile:  self createBytecodeForCALLER.
	self assertGlobalWithoutParameter: sequence
	

]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testCALLSIZE [
	| sequence |
	"CALLDATASIZE->
		sequence + 
	    runtime := Runtime.
	    calldata := runtime calldata.
		 size := calldata size.
	   stack +
	    size
	"
	sequence := self decompile: self createBytecodeForCALLDATASIZE.
	self assertGlobalWithoutParameter: sequence
]

{ #category : #'three parameters globals' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testCODECOPY [
	| sequence |
		"
	CODECOPY(MemAt,CallDataFrom, DataLength)
		sequence +
			writeAt := MemAt.
			readFrom := CallDataFrom.
			size := DataLength
			runtime := Runtime.
			calldata := runtime calldata.
			data := calldata readFromByte: readFrom amount: size.
			memory at: writeAt put: data.
		stack
	"
	sequence := self decompile: (self createBytecodeForCODECOPY: '0x2' code: '0x0' length: '0x3').
	self assert: self decompiler programHasFinished.
	
	self assertIsSequence: sequence.
	self assert: sequence allInstructions size equals: 5.
	self assert: sequence statements size equals: 7.
	(sequence statements first: 6 ) do: [ :s | self assertIsAssignment: s ].
	self assertIsMemoryWrite: sequence statements last .
	(sequence statements first: 3) do: [ :s | self assertIsLiteral: s value ].
	self assertIsVariable: sequence statements fourth variable named: #Runtime.
	self assertIsRuntimeGlobal: sequence statements fourth value.
	self assertIsMessageSend:  sequence statements fifth value. 
	self assertIsMessageSend:  sequence statements sixth value. 
	self assert: sequence statements second variable equals: sequence statements sixth value arguments first .
	self assert: sequence statements first variable equals: sequence statements sixth value arguments second .
	self assert: sequence statements seventh address equals: sequence statements third variable . 
	
	self assert: self decompiler scope stack size equals: 0
	
	
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testCODESIZE [
	| bytecode sequence |
	"CODESIZE->
		sequence + 
	    runtime := Runtime.
	    contract := runtime runningContract.
		 size := contract codeSize.
	   stack +
	    size
	"
	bytecode := self createBytecodeForCODESIZE.
	sequence := self decompile: bytecode.
	self assertGlobalWithoutParameter: sequence
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testCOINBASE [
	| bytecode sequence |
	"COINBASE->
		sequence + 
	    runtime := Runtime.
	    coinbase := runtime coinbase.
		 coinBaseAddress := coinbase address.
	   stack +
	    coinBaseAddress
	"
	bytecode := self createBytecodeForCOINBASE.
	sequence := self decompile: bytecode.
	self assertGlobalWithoutParameter: sequence
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testDIFFICULTY [
	| bytecode sequence |
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
	self assertGlobalWithoutParameter: sequence
]

{ #category : #'three parameters globals' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testEXTCODECOPY [
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
	sequence := self decompile: (self
		createBytecodeForEXTCODE: '0x02342435'
		COPY: '0x1'
		code: '0x3'
		length: '0x5').
	self assert: self decompiler programHasFinished.
	self assertIsSequence: sequence.
	self assert: sequence allInstructions size equals: 6.
	self assert: sequence statements size equals: 8.
	(sequence statements first: 7) do: [ :s | self assertIsAssignment: s ].
	self assertIsMemoryWrite: sequence statements last.
	(sequence statements first: 4) do: [ :s | self assertIsLiteral: s value ].
	self assertIsVariable: sequence statements fifth variable named: #Runtime.
	self assertIsRuntimeGlobal: sequence statements fifth value.
	self assertIsMessageSend:  sequence statements sixth value. 
	self assertIsMessageSend:  sequence statements seventh value. 
	self assert: sequence statements fourth variable equals: sequence statements sixth value arguments first .
	self assert: sequence statements second variable equals: sequence statements seventh value arguments first .
	self assert: sequence statements first variable equals: sequence statements seventh value arguments second .
	self assert: sequence statements sixth variable equals: sequence statements seventh value receiver .
	self assert: sequence statements eighth address equals: sequence statements third variable . 
	self assert: sequence statements eighth value equals: sequence statements seventh variable . 
	self assert: self decompiler scope stack size equals: 0
	
]

{ #category : #'one parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testEXTCODEHASH [
	| bytecode sequence |
	"EXTCODEHASH(ContractAddress)->
		sequence + 
		 address := ContractAddress.
	    runtime := Runtime.
	    binaryHash := runtime contractCodeHashFor: address.
	   stack +
	    binaryHash
	"
	bytecode := self createBytecodeForEXTCODEHASH: '0x1234567123456'.
	sequence := self decompile: bytecode.
	self assertGlobalWithOneParameter: sequence
]

{ #category : #'one parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testEXTCODESIZE [
	| bytecode sequence |
	"EXTCODESIZE(ContractAddress)->
		sequence + 
		 address := ContractAddress.
	    runtime := Runtime.
	    binarySize := runtime contractCodeSizeFor: address.
	   stack +
	    binarySize
	"
	bytecode := self createBytecodeForEXTCODESIZE: '0x1234567123456'.
	sequence := self decompile: bytecode.
	self assertGlobalWithOneParameter: sequence
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testGAS [
	| bytecode sequence |
	"GAS->
		sequence + 
	    runtime := Runtime.
	    currentGas := runtime currentGas.
	   stack +
	    currentGas
	"
	bytecode := self createBytecodeForGAS.
	sequence := self decompile: bytecode.
	self assertRuntimeDirectGlobalWithoutParameter: sequence
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testGASLIMIT [
	| bytecode sequence |
	"GASLIMIT->
		sequence + 
	    runtime := Runtime.
	    block := runtime currentBlock.
		 gasLimit := block gasLimit.
	   stack +
	    gasLimit
	"
	bytecode := self createBytecodeForGASLIMIT.
	sequence := self decompile: bytecode.
	self assertGlobalWithoutParameter: sequence
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testGASPRICE [
	| bytecode sequence |
	"GASPRICE->
		sequence + 
	    runtime := Runtime.
	    calldata := runtime calldata.
		 gasPrice := calldata gasPrice.
	   stack +
	    gasPrice
	"
	bytecode := self createBytecodeForGASPRICE.
	sequence := self decompile: bytecode.
	self assertGlobalWithoutParameter: sequence
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testNUMBER [
	| bytecode sequence |
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
	self assertGlobalWithoutParameter: sequence
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testORIGIN [
	| bytecode sequence |
	"ORIGIN->
		sequence + 
	    runtime := Runtime.
	    origin := runtime origin.
	   stack +
	    origin
	"
	bytecode := self createBytecodeForORIGIN.
	sequence := self decompile: bytecode.
	self assertRuntimeDirectGlobalWithoutParameter: sequence
]

{ #category : #'no parameter global' }
FogEVMDecompileEnvironmentalInformationAccessTest >> testTIMESTAMP [
	| bytecode sequence |
	"TIMESTAMP->
		sequence + 
	    runtime := Runtime.
	    block := runtime currentBlock.
		 timestamp := block timestamp.
	   stack +
	    timestamp
	"
	bytecode := self createBytecodeForTIMESTAMP.
	sequence := self decompile: bytecode.
	self assertGlobalWithoutParameter: sequence
]
