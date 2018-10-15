Class {
	#name : #FogEVMUnitaryTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'interpreter'
	],
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForADD: aValue plus: oValue [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutAdd.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForADDMOD: x and: y and: z [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream
		nextPutPush3: z;
		nextPutPush3: x;
		nextPutPush3: y;
		nextPutAddmod;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForADDRESS [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	"should test over 
		func opAddress(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Address().Big())
	retur"
	stream
		nextPutAddress;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForAND [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.

	stream
		nextPutPush1: 1;
		nextPutPush1: 1;
		nextPutAnd;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForAND: a and:b [ 
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream
		nextPutPush1: a;
		nextPutPush1: b;
		nextPutAnd;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForBALANCE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opBalance(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.Set(interpreter.evm.StateDB.GetBalance(common.BigToAddress(slot)))
	retur"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForBLOCKHASH [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opBlockhash(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	num := stack.pop()

	n := interpreter.intPool.get().Sub(interpreter.evm.BlockNumber, common.Big257)
	if num.Cmp(n) > 0 && num.Cmp(interpreter.evm.BlockNumber) < 0 {
		stack.push(interpreter.evm.GetHash(num.Uint64()).Big())
	} else {
		stack.push(interpreter.intPool.getZero())
	}
	interpreter.intPool.put(num, n)
	ret"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForBYTE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opByte(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	th, val := stack.pop(), stack.peek()
	if th.Cmp(common.Big32) < 0 {
		b := math.Byte(val, 32, int(th.Int64()))
		val.SetUint64(uint64(b))
	} else {
		val.SetUint64(0)
	}
	interpreter.intPool.put(th)
	return n"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForBYTE: aChunk at: aPosition [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream
		nextPutPush4: aPosition;
		nextPutPush3: aChunk;
		nextPutByte;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCALL [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opCaller(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Caller().Big())
	return n"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCALLCODE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
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
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCALLDATACOPY [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opCallDataCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		memOffset  = stack.pop()
		dataOffset = stack.pop()
		length     = stack.pop()
	)
	memory.Set(memOffset.Uint64(), length.Uint64(), getDataBig(contract.Input, dataOffset, length))

	interpreter.intPool.put(memOffset, dataOffset, length)
	"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCALLDATALOAD [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opCallDataLoad(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetBytes(getDataBig(contract.Input, stack.pop(), big32)))
	"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCALLDATASIZE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opCallDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetInt64(int64(len(contract.Input))))
	"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCALLER [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opCaller(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Caller().Big())
	return"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCALLVALUE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opCallValue(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(contract.value))
	ret"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCODECOPY [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opCodeCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		memOffset  = stack.pop()
		codeOffset = stack.pop()
		length     = stack.pop()
	)
	codeCopy := getDataBig(contract.Code, codeOffset, length)
	memory.Set(memOffset.Uint64(), length.Uint64(), codeCopy)

	interpreter.intPool.put(memOffset, codeOffset, length)
	retu"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCODESIZE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opCodeSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	l := interpreter.intPool.get().SetInt64(int64(len(contract.Code)))
	stack.push(l)

	retu"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCOINBASE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opCoinbase(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.evm.Coinbase.Big())
	retu"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCREATE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
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
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForCREATE2 [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
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
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDELEGATECALL [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
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
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDIFFICULTY [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opDifficulty(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.Difficulty)))
	re"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDIV [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opDiv(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if y.Sign() != 0 {
		math.U256(y.Div(x, y))
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return ni"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForDIV: aValue and: oValue [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutDiv.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP1 [
	^ self createBytecodeForDUP: 1 
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP10 [
	^ self createBytecodeForDUP: 10
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP11 [
	^ self createBytecodeForDUP: 11
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP12 [
	^ self createBytecodeForDUP: 12
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP13 [
	^ self createBytecodeForDUP: 13
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP14 [
	^ self createBytecodeForDUP: 14
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP15 [
	^ self createBytecodeForDUP: 15
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP16 [
	^ self createBytecodeForDUP: 16
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP2 [
	^ self createBytecodeForDUP: 2
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP3 [
	^ self createBytecodeForDUP: 3
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP4 [
	^ self createBytecodeForDUP: 4
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP5 [
	^ self createBytecodeForDUP: 5
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP6 [
	^ self createBytecodeForDUP: 6
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP7 [
	^ self createBytecodeForDUP: 7
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP8 [
	^ self createBytecodeForDUP: 8
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP9 [
	^ self createBytecodeForDUP: 9
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForDUP: anNumber [
	| bytecode stream selector |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	selector := ('nextPutDup' , anNumber asString) asSymbol.
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	"should test over 
		"
	anNumber + 1 to: 1 by: -1 do: [ :idx | stream nextPutPush1: idx ].
	stream perform: selector.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForEQ: anInteger and: anInteger2 [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	"should test over 
		func opEq(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) == 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil"
	stream
		nextPutPush3: anInteger2;
		nextPutPush3: anInteger;
		nextPutEq;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForEXP [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opExp(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	base, exponent := stack.pop(), stack.pop()
	stack.push(math.Exp(base, exponent))

	interpreter.intPool.put(base, exponent)

	return ni"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForEXP: aValue and: oValue [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream
		nextPutPush1: oValue;
		nextPutPush1: aValue;
		nextPutExp;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForEXTCODECOPY [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
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
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForEXTCODEHASH [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opExtCodeHash(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.SetBytes(interpreter.evm.StateDB.GetCodeHash(common.BigToAddress(slot)).Bytes())
	r"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForEXTCODESIZE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opExtCodeSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.SetUint64(uint64(interpreter.evm.StateDB.GetCodeSize(common.BigToAddress(slot))))

	r"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForGAS [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opGasprice(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(interpreter.evm.GasPrice))
	return ni"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForGASLIMIT [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opGasLimit(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().SetUint64(interpreter.evm.GasLimit)))
	retu"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForGASPRICE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opGasprice(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(interpreter.evm.GasPrice))
	retu"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForGT: anInteger and: anInteger2 [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	"should test over 
		func opEq(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) == 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil"
	stream
		nextPutPush3: anInteger2;
		nextPutPush3: anInteger;
		nextPutGt;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForINVALID [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForISZERO: anInteger [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	"should test over 
		func opIszero(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x := stack.peek()
	if x.Sign() > 0 {
		x.SetUint64(0)
	} else {
		x.SetUint64(1)
	}
	return"
	stream
		nextPutPush3: anInteger;
		nextPutIszero;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForJUMP [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opJump(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	pos := stack.pop()
	if !contract.validJumpdest(pos) {
		nop := contract.GetOp(pos.Uint64())
		return nil, fmt.Errorf(invalid jump destination (%v) %v, nop, pos)
	}
	*pc = pos.Uint64()

	interpreter.intPool.put(pos)
	return n"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForJUMPDEST [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opJumpdest(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	retu"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForJUMPI [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opJumpi(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	pos, cond := stack.pop(), stack.pop()
	if cond.Sign() != 0 {
		if !contract.validJumpdest(pos) {
			nop := contract.GetOp(pos.Uint64())
			return nil, fmt.Errorf(invalid jump destination (%v) %v, nop, pos)
		}
		*pc = pos.Uint64()
	} else {
		*pc++
	}

	interpreter.intPool.put(pos, cond)
	return "
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForLOG0 [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForLOG1 [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForLOG2 [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForLOG3 [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForLOG4 [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForLT: anInteger and: anInteger2 [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	"should test over 
		func opEq(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) == 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil"
	stream
		nextPutPush3: anInteger2;
		nextPutPush3: anInteger;
		nextPutLt;
		nextPutStop.
	^ bytecode
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForMLOAD [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opMload(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset := stack.pop()
	val := interpreter.intPool.get().SetBytes(memory.Get(offset.Int64(), 32))
	stack.push(val)

	interpreter.intPool.put(offset)
	return "
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForMOD: aValue and: oValue [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutMod.
	stream nextPutStop.
	^ bytecode
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForMSIZE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opMsize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetInt64(int64(memory.Len())))
	return "
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForMSTORE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opMstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// pop value of the stack
	mStart, val := stack.pop(), stack.pop()
	memory.Set32(mStart.Uint64(), val)

	interpreter.intPool.put(mStart, val)
	return"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForMSTORE8 [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opMstore8(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	off, val := stack.pop().Int64(), stack.pop().Int64()
	memory.store[off] = byte(val & 0xff)

	retur"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForMUL: aValue and: oValue [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutMul.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForMULMOD [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opMulmod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y, z := stack.pop(), stack.pop(), stack.pop()
	if z.Cmp(bigZero) > 0 {
		x.Mul(x, y)
		x.Mod(x, z)
		stack.push(math.U256(x))
	} else {
		stack.push(x.SetUint64(0))
	}
	interpreter.intPool.put(y, z)
	return nil, nil
}

// opSHL implements Shift Left
// The SHL instruction (shift left) pops 2 values from the stack, first arg1 and then arg2,
// and pushes on the stack arg2 shifted to the left by arg1 num"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForMULMOD: x and: y and: z [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream
		nextPutPush3: z;
		nextPutPush3: x;
		nextPutPush3: y;
		nextPutMulmod;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForNOT: a [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream
		nextPutPush1: a;
		nextPutNot;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForNUMBER [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opNumber(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.BlockNumber)))
	return"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForOR: a and:b [ 
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream
		nextPutPush1: a;
		nextPutPush1: b;
		nextPutOr;
		nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForORIGIN [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opOrigin(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.evm.Origin.Big())
	return"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForPC [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opPc(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(*pc))
	return nil"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForPOP: anInteger [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	"should test over 
		func opPop(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	interpreter.intPool.put(stack.pop())
	return ni"
	anInteger timesRepeat: [ stream nextPutPush3: anInteger ].
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForRETURN [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opReturnDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(uint64(len(interpreter.returnData))))
	return"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForRETURNDATACOPY [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
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
"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForRETURNDATASIZE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opReturnDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(uint64(len(interpreter.returnData))))"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForREVERT [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		
	func opRevert(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset, size := stack.pop(), stack.pop()
	ret := memory.GetPtr(offset.Int64(), size.Int64())

	interpreter.intPool.put(offset, size)
	return ret, nil
}
	"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSAR [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSAR(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Note, S256 returns (potentially) a new bigint, so were popping, not peeking this one
	shift, value := math.U256(stack.pop()), math.S256(stack.pop())
	defer interpreter.intPool.put(shift) // First operand back into the pool

	if shift.Cmp(common.Big256) >= 0 {
		if value.Sign() >= 0 {
			value.SetUint64(0)
		} else {
			value.SetInt64(-1)
		}
		stack.push(math.U256(value))
		return nil, nil
	}
	n := uint(shift.Uint64())
	value.Rsh(value, n)
	stack.push(math.U256(value))

	return ni"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForSAR: aValue and: oValue [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutSar.
	stream nextPutStop.
	^ bytecode
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForSDIV: aValue and: oValue [ 
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutSdiv.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSELFDESTRUCT [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSuicide(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	balance := interpreter.evm.StateDB.GetBalance(contract.Address())
	interpreter.evm.StateDB.AddBalance(common.BigToAddress(stack.pop()), balance)

	interpreter.evm.StateDB.Suicide(contract.Address())
	return nil, nil
}"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSGT [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSgt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()

	xSign := x.Cmp(tt255)
	ySign := y.Cmp(tt255)

	switch {
	case xSign >= 0 && ySign < 0:
		y.SetUint64(0)

	case xSign < 0 && ySign >= 0:
		y.SetUint64(1)

	default:
		if x.Cmp(y) > 0 {
			y.SetUint64(1)
		} else {
			y.SetUint64(0)
		}
	}
	interpreter.intPool.put(x)
	return ni"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForSGT: aValue and: oValue [ 
		| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutSgt.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSHA3 [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSha3(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset, size := stack.pop(), stack.pop()
	data := memory.Get(offset.Int64(), size.Int64())

	if interpreter.hasher == nil {
		interpreter.hasher = sha3.NewKeccak256().(keccakState)
	} else {
		interpreter.hasher.Reset()
	}
	interpreter.hasher.Write(data)
	interpreter.hasher.Read(interpreter.hasherBuf[:])

	evm := interpreter.evm
	if evm.vmConfig.EnablePreimageRecording {
		evm.StateDB.AddPreimage(interpreter.hasherBuf, data)
	}
	stack.push(interpreter.intPool.get().SetBytes(interpreter.hasherBuf[:]))

	interpreter.intPool.put(offset, size)
	return n"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSHL [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSHL(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Note, second operand is left in the stack; accumulate result into it, and no need to push it afterwards
	shift, value := math.U256(stack.pop()), math.U256(stack.peek())
	defer interpreter.intPool.put(shift) // First operand back into the pool

	if shift.Cmp(common.Big256) >= 0 {
		value.SetUint64(0)
		return nil, nil
	}
	n := uint(shift.Uint64())
	math.U256(value.Lsh(value, n))

	return nil, nil
}

// opSHR implements Logical Shift Right
// The SHR instruction (logical shift right) pops 2 values from the stack, first arg1 and then arg2,
// and pushes on the stack arg2 shifted to the right by arg1 number of bits with z"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForSHL: aValue and: oValue [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutShl.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSHR [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSHR(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Note, second operand is left in the stack; accumulate result into it, and no need to push it afterwards
	shift, value := math.U256(stack.pop()), math.U256(stack.peek())
	defer interpreter.intPool.put(shift) // First operand back into the pool

	if shift.Cmp(common.Big256) >= 0 {
		value.SetUint64(0)
		return nil, nil
	}
	n := uint(shift.Uint64())
	math.U256(value.Rsh(value, n))

	return nil, nil
}

// opSAR implements Arithmetic Shift Right
// The SAR instruction (arithmetic shift right) pops 2 values from the stack, first arg1 and then arg2,
// and pushes on the stack arg2 shifted to the right by arg1 number of bits with sign e"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForSHR: aValue and: oValue [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutShr.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSIGNEXTEND [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSignExtend(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	back := stack.pop()
	if back.Cmp(big.NewInt(31)) < 0 {
		bit := uint(back.Uint64()*8 + 7)
		num := stack.pop()
		mask := back.Lsh(common.Big1, bit)
		mask.Sub(mask, common.Big1)
		if num.Bit(int(bit)) > 0 {
			num.Or(num, mask.Not(mask))
		} else {
			num.And(num, mask)
		}

		stack.push(math.U256(num))
	}

	interpreter.intPool.put(back)
	re"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSLOAD [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSload(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	loc := stack.peek()
	val := interpreter.evm.StateDB.GetState(contract.Address(), common.BigToHash(loc))
	loc.SetBytes(val.Bytes())
	return "
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSLT [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSlt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()

	xSign := x.Cmp(tt255)
	ySign := y.Cmp(tt255)

	switch {
	case xSign >= 0 && ySign < 0:
		y.SetUint64(1)

	case xSign < 0 && ySign >= 0:
		y.SetUint64(0)

	default:
		if x.Cmp(y) < 0 {
			y.SetUint64(1)
		} else {
			y.SetUint64(0)
		}
	}
	interpreter.intPool.put(x)
	return ni"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForSLT: aValue and: oValue [ 
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutSlt.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSMOD [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSmod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := math.S256(stack.pop()), math.S256(stack.pop())
	res := interpreter.intPool.getZero()

	if y.Sign() == 0 {
		stack.push(res)
	} else {
		if x.Sign() < 0 {
			res.Mod(x.Abs(x), y.Abs(y))
			res.Neg(res)
		} else {
			res.Mod(x.Abs(x), y.Abs(y))
		}
		stack.push(math.U256(res))
	}
	interpreter.intPool.put(x, y)
	return n"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForSMOD: aValue and: oValue [ 
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutSmod.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSSTORE [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opSstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	loc := common.BigToHash(stack.pop())
	val := stack.pop()
	interpreter.evm.StateDB.SetState(contract.Address(), loc, common.BigToHash(val))

	interpreter.intPool.put(val)
	return"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSTATICCALL [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
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
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSTOP [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opStop(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	return n"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #creating }
FogEVMUnitaryTest >> createBytecodeForSUB: aValue and: oValue [
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream nextPutPush3: oValue.
	stream nextPutPush3: aValue.
	stream nextPutSub.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP1 [
	^ self createBytecodeForSWAP: 1
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP10 [
	^ self createBytecodeForSWAP: 10
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP11 [
	^ self createBytecodeForSWAP: 11
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP12 [
	^ self createBytecodeForSWAP: 12
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP13 [
	^ self createBytecodeForSWAP: 13
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP14 [
	^ self createBytecodeForSWAP: 14
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP15 [
	^ self createBytecodeForSWAP: 15
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP16 [
	^ self createBytecodeForSWAP: 16
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP2 [
	^ self createBytecodeForSWAP: 2
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP3 [
	^ self createBytecodeForSWAP: 3
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP4 [
	^ self createBytecodeForSWAP: 4
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP5 [
	^ self createBytecodeForSWAP: 5
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP6 [
	^ self createBytecodeForSWAP: 6
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP7 [
	^ self createBytecodeForSWAP: 7
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP8 [
	^ self createBytecodeForSWAP: 8
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP9 [
	^ self createBytecodeForSWAP: 9
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForSWAP: anAmount [
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"

	| bytecode stream selector |
	selector := ('nextPutSwap' , anAmount asString) asSymbol.
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	"should test over 
		"
	anAmount + 1 to: 1 by: -1 do: [ :idx | stream nextPutPush1: idx ].
	stream perform: selector.
	stream nextPutStop.
	^ bytecode
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForTIMESTAMP [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		func opTimestamp(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.Time)))
	ret"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForUNKNOWN [
		| bytecode stream |
		bytecode :=	FogEVMByteCode new .
		stream := bytecode writeStream. 
		"should test over 
		"
		self shouldBeImplemented.
		^ bytecode.
		
		
]

{ #category : #'bytecode generation' }
FogEVMUnitaryTest >> createBytecodeForXOR: a and:b [ 
	| bytecode stream |
	bytecode := FogEVMByteCode new.
	stream := bytecode writeStream.
	stream
		nextPutPush1: a;
		nextPutPush1: b;
		nextPutXor;
		nextPutStop.
	^ bytecode
]

{ #category : #running }
FogEVMUnitaryTest >> setUp [
	super setUp.
	interpreter := FogEVMTestInterpreter new.
	interpreter call: FogEVMInterpreter exampleCall
]
