Class {
	#name : #FogEVMDecompileContractsByteCodeTest,
	#superclass : #FogEVMUnitaryTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#classInstVars : [
		'users'
	],
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #creating }
FogEVMDecompileContractsByteCodeTest >> accountForTest [
	^ FogEVMAccount new address: interpreter call callerAddress 
]

{ #category : #testing }
FogEVMDecompileContractsByteCodeTest >> contractAddressForTest [
	^ (FogEVMRegistry forValue: 16r81bfba8301a073a010e9fb71fab514e53d1cc3f5 bytesLength: 20).
]

{ #category : #testing }
FogEVMDecompileContractsByteCodeTest >> contractForTest [
	^ FogEVMContract new
		bytecode: (self createBytecodeForADDAndPop: 1 plus: 2);
		address: self contractAddressForTest;
		yourself
]

{ #category : #testing }
FogEVMDecompileContractsByteCodeTest >> contractInputForCall [
	^ (FogEVMAbstractInterpreter exampleCall contractInput copyFrom: 1 to: 4) asInteger
]

{ #category : #testing }
FogEVMDecompileContractsByteCodeTest >> setUp [ 	
	super setUp. 
	interpreter installContract: (self contractForTest) at: self contractAddressForTest.
	interpreter installExternalAccount: (self accountForTest) at: interpreter call callerAddress.
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testCALL [
	| bytecode retSize retOffset inSize inOffset address gas value sequence |
	"
	CALL(Gas, ContractAddress,Value,InputAddress,InputSize,ReturnAddress,ReturnSize)->
	 sequence + 
	  gas := Gas.
	  address := ContractAddress.
 	  value := Value.
	  inputAddress := InputAddress.
	  inputSize := InputSize.
	  returnAddress := ReturnAddress.
	  returnSize := ReturnSize.
	  input := MemoryLoad(inputAddress,inputSize).
	  call := Call(address,input,gas).
	  callExitStatus := call exitStatus. 
	  callReturn := call return.
	  MemoryStore(returnAddress,returnSize, callReturn). 
	  
	 stack +
		callExitStatus
"
	retSize := 0.
	retOffset := 0.
	inSize := 0.
	inOffset := 0.
	address := self contractAddressForTest unsignedValue.
	gas := 3000.
	value := 16rc3c5a54.
	bytecode := self
		createBytecodeForCALLReturn: retSize write0xHexadecimal
		at: retOffset write0xHexadecimal
		parameters: inSize write0xHexadecimal
		at: inOffset write0xHexadecimal
		value: value write0xHexadecimal
		contract: address write0xHexadecimal
		using: gas write0xHexadecimal.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 12.
	self assert: sequence allInstructions size equals: 9.
	sequence statements allButLast
		do: [ :s | self assertIsAssignment: s ].
	self assertIsMessageSend: (sequence statements at: 10) value.
	self
		assert: (sequence statements at: 10) variable
		equals: decompiler stack top.
	self assertIsMemoryLoad: (sequence statements at: 8) value.
	self assertIsMemoryWrite: (sequence statements at: 12).
	self
		assert: ((sequence statements at: 9) value isKindOf: FogEVMAstCall)
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testCALLCODE [
	| bytecode retSize retOffset inSize inOffset address gas value |
	"should test over 
		func opCallCode(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Pop gas. The actual gas is in interpreter.evm.callGasTemp.
	interpreter.intPool.put(stack.pop())
	gas := interpreter.evm.callGasTemp
	// Pop other call parameters.
	addr, value, inOffset, inSize, retOffset, retSize := stack.pop(), stack.pop(), stack.pop(), stack.pop(), stack.pop(), stack.pop()
	toAddr := common.BigToAddress(addr)
	value = math.U256(value)
	// Get arguments from the memory.
	args := memory.Get(inOffset.Int64(), inSize.Int64())

	if value.Sign() != 0 {
		gas += params.CallStipend
	}
	ret, returnGas, err := interpreter.evm.CallCode(contract, toAddr, args, gas, value)
	if err != nil {
		stack.push(interpreter.intPool.getZero())
	} else {
		stack.push(interpreter.intPool.get().SetUint64(1))
	}
	if err == nil || err == errExecutionReverted {
		memory.Set(retOffset.Uint64(), retSize.Uint64(), ret)
	}
	contract.Gas += returnGas

	interpreter.intPool.put(addr, value, inOffset, inSize, retOffset, retSize)
	retu"
	retSize := 0.
	retOffset := 0.
	inSize := 0.
	inOffset := 0.
	address := self contractAddressForTest.
	gas := 3000.
	value := self contractInputForCall.
	bytecode := self
		createBytecodeForCALLCodeReturn: retSize
		at: retOffset
		parameters: inSize
		at: inOffset
		value: value
		contract: address unsignedValue
		usign: gas.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter pop unsignedValue equals: 1
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testCREATE [
	| bytecode sequence |
	"
	CREATE(Value,Offset,Size)
	 sequence +
	   value := Value.
	   offset := Offset.
	   size := Size.
	   input := MemoryRead(Offset, Size).
	   contract := Create(value, offset, size). 
	   address := contract address.
    stack + 
      address
	"
	
	bytecode := self
		createBytecodeForCREATE: '0x20'
		bytecodeAtMemory: '0x1'
		offset: '0x10'.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 6.
	self assert: sequence allInstructions size equals: 5.
	sequence statements do: [ : s | self assertIsAssignment: s ].
	self assertIsMessageSend:  sequence statements last value 
	
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testCREATE2 [
	| bytecode sequence |
	"
	CREATE(Value,Offset,Size)
	 sequence +
	   value := Value.
	   offset := Offset.
	   size := Size.
	   input := MemoryRead(Offset, Size).
	   contract := Create(value, offset, size). 
	   address := contract address.
    stack + 
      address
	"
	
	bytecode := self
		createBytecodeForCREATE2: '0x20'
		bytecodeAtMemory: '0x1'
		offset: '0x10'
		salt: '0x11'.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 7.
	self assert: sequence allInstructions size equals: 6.
	sequence statements do: [ : s | self assertIsAssignment: s ].
	self assertIsMessageSend:  sequence statements last value 
	
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testDELEGATECALL [
	| bytecode retSize retOffset inSize inOffset address gas value |
	"should test over 
		func opDelegateCall(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Pop gas. The actual gas is in interpreter.evm.callGasTemp.
	interpreter.intPool.put(stack.pop())
	gas := interpreter.evm.callGasTemp
	// Pop other call parameters.
	addr, inOffset, inSize, retOffset, retSize := stack.pop(), stack.pop(), stack.pop(), stack.pop(), stack.pop()
	toAddr := common.BigToAddress(addr)
	// Get arguments from the memory.
	args := memory.Get(inOffset.Int64(), inSize.Int64())

	ret, returnGas, err := interpreter.evm.DelegateCall(contract, toAddr, args, gas)
	if err != nil {
		stack.push(interpreter.intPool.getZero())
	} else {
		stack.push(interpreter.intPool.get().SetUint64(1))
	}
	if err == nil || err == errExecutionReverted {
		memory.Set(retOffset.Uint64(), retSize.Uint64(), ret)
	}
	contract.Gas += returnGas

	interpreter.intPool.put(addr, inOffset, inSize, retOffset, retSize)
	"
	retSize := 0.
	retOffset := 0.
	inSize := 0.
	inOffset := 0.
	address := self contractAddressForTest.
	gas := 3000.
	value := self contractInputForCall.
	bytecode := self
		createBytecodeForDELEGATECALLReturn: retSize
		at: retOffset
		parameters: inSize
		at: inOffset
		contract: address unsignedValue
		usign: gas.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter pop unsignedValue equals: 1
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testRETURN [
	| bytecode |
	"
func opReturn(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset, size := stack.pop(), stack.pop()
	ret := memory.GetPtr(offset.Int64(), size.Int64())

	interpreter.intPool.put(offset, size)
	return ret, nil
}"
	bytecode := self createBytecodeForRETURNFrom: 1 upTo: 11.
	interpreter bytecode: bytecode.
	interpreter memory store: 'Hello world' asByteArray at: 1 ensure: 11.
	interpreter run.
	self assert: interpreter currentActivation return asString equals: 'Hello world'
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testRETURNDATACOPY [
	| bytecode |
	"should test over 
		func opReturnDataCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
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
	memory.Set(memOffset.Uint64(), length.Uint64(), interpreter.returnData[dataOffset.Uint64():end.Uint64()])

	return nil, nil
"
	interpreter memory store: 'Hello world' asByteArray at: 1 ensure: 11.
	bytecode := self createBytecodeForRETURNFrom: 1 upTo: 11.
	interpreter bytecode: bytecode.
	interpreter run.
	
	bytecode := self createBytecodeForRETURNDATACOPYFrom: 1 to: 12 upTo: 11.
	interpreter bytecode: bytecode.
	interpreter hackedRun.
	self assert: (interpreter memory loadFrom: 12 bytes: 11) asString equals: 'Hello world'
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testRETURNDATASIZE [
	| bytecode |
	"should test over 
		func opReturnDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(uint64(len(interpreter.returnData))))"
	bytecode := self createBytecodeForRETURNFrom: 1 upTo: 11.
	interpreter bytecode: bytecode.
	interpreter memory store: 'Hello world' asByteArray at: 1 ensure: 11.
	interpreter run.
	bytecode := self createBytecodeForRETURNDATASIZE.
	interpreter bytecode: bytecode.
	interpreter hackedRun.
	self assert: interpreter pop unsignedValue equals: 11
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testREVERT [
	| bytecode sequence |
	"
	REVERT(MessageOffset, MessageSize)
	 sequence +  
	  size := MessageSize.
	  offset := MessageOffset.
	  message := Memory(offset, size).
	  revert(message).
	 stack +
	"
	bytecode := self createBytecodeForREVERTMessage: '0x10' size: '0x40'.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 4.
	self assert: sequence allInstructions size equals: 3.
	sequence statements allButLast
		do: [ :s | self assertIsAssignment: s ].
	self assert: (sequence statements last isKindOf: FogEVMAstRevert).
	self assert: sequence statements last message equals: sequence statements allButLast last variable.
	self assert: sequence statements allButLast last value amountOfBytes equals: sequence statements first variable.
	self assert: sequence statements allButLast last value fromAddress equals: sequence statements second variable.
	self assert: decompiler scope stack isEmpty


]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testSELFDESTRUCT [
	| bytecode sequence |
	"
	SelfDestruct(Address):
	  sequence +
	    address := Address.
	    Suicide(address).
	  stack + 
	
	
	should test over 
		func opSuicide(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	balance := interpreter.evm.StateDB.GetBalance(contract.Address())
	interpreter.evm.StateDB.AddBalance(common.BigToAddress(stack.pop()), balance)

	interpreter.evm.StateDB.Suicide(contract.Address())
	return nil, nil
}"
	bytecode := self
		createBytecodeForSELFDESTRUCT: '0x31243513411512ABC54'.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 2.
	self assert: sequence allInstructions size equals: 3.
	self assertIsAssignment: sequence statements first.
	self assert:sequence statements second account equals: sequence statements first variable .
]

{ #category : #test }
FogEVMDecompileContractsByteCodeTest >> testSTATICCALL [
	| bytecode retSize retOffset inSize inOffset address gas  |
	"should test over 
		func opStaticCall(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Pop gas. The actual gas is in interpreter.evm.callGasTemp.
	interpreter.intPool.put(stack.pop())
	gas := interpreter.evm.callGasTemp
	// Pop other call parameters.
	addr, inOffset, inSize, retOffset, retSize := stack.pop(), stack.pop(), stack.pop(), stack.pop(), stack.pop()
	toAddr := common.BigToAddress(addr)
	// Get arguments from the memory.
	args := memory.Get(inOffset.Int64(), inSize.Int64())

	ret, returnGas, err := interpreter.evm.StaticCall(contract, toAddr, args, gas)
	if err != nil {
		stack.push(interpreter.intPool.getZero())
	} else {
		stack.push(interpreter.intPool.get().SetUint64(1))
	}
	if err == nil || err == errExecutionReverted {
		memory.Set(retOffset.Uint64(), retSize.Uint64(), ret)
	}
	contract.Gas += returnGas

	interpreter.intPool.put(addr, inOffset, inSize, retOffset, retSize)
	re"
	retSize := 0.
	retOffset := 0.
	inSize := 0.
	inOffset := 0.
	address := self contractAddressForTest.
	gas := 3000.
	bytecode := self
		createBytecodeForSTATICCALLCodeReturn: retSize
		at: retOffset
		parameters: inSize
		at: inOffset
		contract: address unsignedValue
		usign: gas.
	interpreter bytecode: bytecode.
	interpreter run
]
