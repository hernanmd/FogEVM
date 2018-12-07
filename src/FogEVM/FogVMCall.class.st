"
Message-call into an account
"
Class {
	#name : #FogVMCall,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCall class >> byteCode [
<doc>
		^'0xf1'.
	
]

{ #category : #'as yet unclassified' }
FogVMCall class >> description [ 
<doc>
	^ 'Message-call into an account'
]

{ #category : #generated }
FogVMCall class >> expectedPops [
<doc>
		^7.
	
]

{ #category : #generated }
FogVMCall class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCall class >> gas [
<doc>
		^ self gasTable at: #gasCall.
]

{ #category : #generated }
FogVMCall class >> goCode [
<doc>
	^ '
func opCall(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
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
}'
]

{ #category : #'as yet unclassified' }
FogVMCall class >> memoryUsage [
<doc>
		^ self memoryTable at: #memoryCall.
]

{ #category : #generated }
FogVMCall class >> mnemonic [
<doc>
		^'CALL'.
	
]

{ #category : #'as yet unclassified' }
FogVMCall class >> returns [
<doc>
		^ true.
]
