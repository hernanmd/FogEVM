Class {
	#name : #FogEVMContractsByteCodeTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #creating }
FogEVMContractsByteCodeTest >> accountForTest [
	^ FogEVMAccount new address: interpreter call callerAddress 
]

{ #category : #testing }
FogEVMContractsByteCodeTest >> contractAddressForTest [
	^ (FogEVMRegistry forValue: 16r81bfba8301a073a010e9fb71fab514e53d1cc3f5 bytesLength: 20).
]

{ #category : #testing }
FogEVMContractsByteCodeTest >> contractForTest [
	^ FogEVMContract new
		bytecode: (self createBytecodeForADDAndPop: 1 plus: 2);
		address: self contractAddressForTest;
		yourself
]

{ #category : #testing }
FogEVMContractsByteCodeTest >> contractInputForCall [
	^ (FogEVMInterpreter exampleCall contractInput copyFrom: 1 to: 4) asInteger
]

{ #category : #testing }
FogEVMContractsByteCodeTest >> setUp [ 	
	super setUp. 
	interpreter installContract: (self contractForTest) at: self contractAddressForTest.
	interpreter installExternalAccount: (self accountForTest) at: interpreter call callerAddress.
]

{ #category : #test }
FogEVMContractsByteCodeTest >> testCALL [
	| bytecode retSize retOffset inSize inOffset address gas value |
	"func opCall(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Pop gas. The actual gas in interpreter.evm.callGasTemp.
	interpreter.intPool.put(stack.pop())
	gas := interpreter.evm.callGasTemp
	// Pop other call parameters.
	addr, value, inOffset, inSize, retOffset, retSize := stack.pop(), stack.pop(), stack.pop(), stack.pop(), stack.pop(), stack.pop()
	toAddr := common.BigToAddress(addr)
	value = math.U256(value)
	// Get the arguments from the memory.
	args := memory.Get(inOffset.Int64(), inSize.Int64())

	if value.Sign() != 0 {
		gas += params.CallStipend
	}
	ret, returnGas, err := interpreter.evm.Call(contract, toAddr, args, gas, value)
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
	return ret, nil
}"
	retSize := 0.
	retOffset := 0.
	inSize := 0.
	inOffset := 0.
	address := self contractAddressForTest unsignedValue.
	gas := 3000.
	
	value := self contractInputForCall.
	
	bytecode := self
		createBytecodeForCALLReturn: retSize
		at: retOffset
		parameters: inSize
		at: inOffset
		value: value
		contract: address
		usign: gas.
		
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter pop unsignedValue equals: 0.
	
]

{ #category : #test }
FogEVMContractsByteCodeTest >> testCALLCODE [
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
	self assert: interpreter pop unsignedValue equals: 0
]

{ #category : #test }
FogEVMContractsByteCodeTest >> testCREATE [
		|  bytecode  |
		
		"should test over 
		func opCreate(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		value        = stack.pop()
		offset, size = stack.pop(), stack.pop()
		input        = memory.Get(offset.Int64(), size.Int64())
		gas          = contract.Gas
	)
	if interpreter.evm.ChainConfig().IsEIP150(interpreter.evm.BlockNumber) {
		gas -= gas / 64
	}

	contract.UseGas(gas)
	res, addr, returnGas, suberr := interpreter.evm.Create(contract, input, gas, value)
	// Push item on the stack based on the returned error. If the ruleset is
	// homestead we must check for CodeStoreOutOfGasError (homestead only
	// rule) and treat as an error, if the ruleset is frontier we must
	// ignore this error and pretend the operation was successful.
	if interpreter.evm.ChainConfig().IsHomestead(interpreter.evm.BlockNumber) && suberr == ErrCodeStoreOutOfGas {
		stack.push(interpreter.intPool.getZero())
	} else if suberr != nil && suberr != ErrCodeStoreOutOfGas {
		stack.push(interpreter.intPool.getZero())
	} else {
		stack.push(addr.Big())
	}
	contract.Gas += returnGas
	interpreter.intPool.put(value, offset, size)

	if suberr == errExecutionReverted {
		return res, nil
	}
	return"
		bytecode := self createBytecodeForCREATE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMContractsByteCodeTest >> testCREATE2 [
		|  bytecode  |
		
		"should test over 
		func opCreate2(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		endowment    = stack.pop()
		offset, size = stack.pop(), stack.pop()
		salt         = stack.pop()
		input        = memory.Get(offset.Int64(), size.Int64())
		gas          = contract.Gas
	)

	// Apply EIP150
	gas -= gas / 64
	contract.UseGas(gas)
	res, addr, returnGas, suberr := interpreter.evm.Create2(contract, input, gas, endowment, salt)
	// Push item on the stack based on the returned error.
	if suberr != nil {
		stack.push(interpreter.intPool.getZero())
	} else {
		stack.push(addr.Big())
	}
	contract.Gas += returnGas
	interpreter.intPool.put(endowment, offset, size, salt)

	if suberr == errExecutionReverted {
		return res, nil
	}
	retur"
		bytecode := self createBytecodeForCREATE2.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMContractsByteCodeTest >> testDELEGATECALL [
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
	self assert: interpreter pop unsignedValue equals: 0
]

{ #category : #test }
FogEVMContractsByteCodeTest >> testRETURN [
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
FogEVMContractsByteCodeTest >> testRETURNDATACOPY [
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
FogEVMContractsByteCodeTest >> testRETURNDATASIZE [
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
FogEVMContractsByteCodeTest >> testREVERT [
		|  bytecode  |
		
		"should test over 
		
	func opRevert(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset, size := stack.pop(), stack.pop()
	ret := memory.GetPtr(offset.Int64(), size.Int64())

	interpreter.intPool.put(offset, size)
	return ret, nil
}
	"
		bytecode := self createBytecodeForREVERT.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter isReverted .
		

]

{ #category : #test }
FogEVMContractsByteCodeTest >> testSELFDESTRUCT [
	| bytecode |
	"should test over 
		func opSuicide(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	balance := interpreter.evm.StateDB.GetBalance(contract.Address())
	interpreter.evm.StateDB.AddBalance(common.BigToAddress(stack.pop()), balance)

	interpreter.evm.StateDB.Suicide(contract.Address())
	return nil, nil
}"
	self deny: (interpreter storageFor: interpreter call contractAddress) destroyed equals: FogEVMRegistry true.
	bytecode := self createBytecodeForSELFDESTRUCT: interpreter  call callerAddress unsignedValue.
	(interpreter storageFor: interpreter call contractAddress) addBalance: (FogEVMRegistry forValue: 9999 bytesLength: 32).
	self assert: (interpreter storageFor: interpreter call contractAddress) balance equals: (FogEVMRegistry forValue: 9999 bytesLength: 32).
	self assert: (interpreter storageFor: interpreter call callerAddress) balance equals: FogEVMRegistry zero.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: (interpreter storageFor: interpreter currentActivation contractAddress) destroyed equals: FogEVMRegistry true.
	self assert: (interpreter storageFor: interpreter currentActivation callerAddress) balance equals: (FogEVMRegistry forValue: 9999 bytesLength: 32).
	self assert: (interpreter storageFor: interpreter currentActivation contractAddress) balance equals: FogEVMRegistry zero
]

{ #category : #test }
FogEVMContractsByteCodeTest >> testSTATICCALL [
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
