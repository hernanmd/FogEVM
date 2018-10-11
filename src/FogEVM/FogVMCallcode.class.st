"
Message-call into this account with an alternative account's code
"
Class {
	#name : #FogVMCallcode,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCallcode class >> byteCode [
		^'0xf2'.
	
]

{ #category : #'as yet unclassified' }
FogVMCallcode class >> description [ 
	^ 'Message-call into this account with an alternative account''s code'
]

{ #category : #generated }
FogVMCallcode class >> expectedPops [
		^7.
	
]

{ #category : #generated }
FogVMCallcode class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCallcode class >> gas [
		^ self gasTable at: #gasCallCode.

]

{ #category : #generated }
FogVMCallcode class >> goCode [
	^ 'func opCallCode(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
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
	retu'
]

{ #category : #'as yet unclassified' }
FogVMCallcode class >> memoryUsage [
		^ self memoryTable at: #memoryCall.

]

{ #category : #generated }
FogVMCallcode class >> mnemonic [
		^'CALLCODE'.
	
]

{ #category : #'as yet unclassified' }
FogVMCallcode class >> returns [
		^ true.

]
