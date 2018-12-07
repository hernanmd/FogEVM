"
Documentation shows nothuing about this
"
Class {
	#name : #FogVMStaticcall,
	#superclass : #FogEVMInstruction,
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMStaticcall class >> byteCode [
<doc>
	^ '0xf6'
]

{ #category : #generated }
FogVMStaticcall class >> expectedPops [
<doc>
		^6.
	
]

{ #category : #generated }
FogVMStaticcall class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMStaticcall class >> gas [
<doc>
		^ self gasTable at: #gasStaticCall.
]

{ #category : #generated }
FogVMStaticcall class >> goCode [
<doc>
	^ 'func opStaticCall(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
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
	re'
]

{ #category : #'as yet unclassified' }
FogVMStaticcall class >> memoryUsage [
<doc>
		^ self memoryTable at: #memoryStaticCall.
]

{ #category : #generated }
FogVMStaticcall class >> mnemonic [
<doc>
		^'STATICCALL'.
	
]

{ #category : #'as yet unclassified' }
FogVMStaticcall class >> returns [
<doc>
		^ true.
]
