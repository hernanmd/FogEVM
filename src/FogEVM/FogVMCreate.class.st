"
Create a new account with associated code

"
Class {
	#name : #FogVMCreate,
	#superclass : #FogEVMInstruction,
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCreate class >> byteCode [
		^'0xf0'.
]

{ #category : #'as yet unclassified' }
FogVMCreate class >> description [ 
	^ 'Create a new account with associated code'
]

{ #category : #generated }
FogVMCreate class >> expectedPops [
	^ 3
]

{ #category : #generated }
FogVMCreate class >> expectedPushes [
	^ 1
]

{ #category : #'as yet unclassified' }
FogVMCreate class >> gas [
		^ self gasTable at: #gasCreate.

]

{ #category : #generated }
FogVMCreate class >> goCode [
	^ 'func opCreate(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
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
	return'
]

{ #category : #'as yet unclassified' }
FogVMCreate class >> memoryUsage [
		^ self memoryTable at: #memoryCreate.

]

{ #category : #generated }
FogVMCreate class >> mnemonic [
		^'CREATE'.
	
]

{ #category : #'as yet unclassified' }
FogVMCreate class >> returns [
		^ true.

]

{ #category : #'as yet unclassified' }
FogVMCreate class >> writes [
		^ true.

]
