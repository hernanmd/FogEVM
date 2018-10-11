"
Message-call into this account with an alternative accounts code, but persisting the current values for it sender and it value
"
Class {
	#name : #FogVMDelegatecall,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMDelegatecall class >> byteCode [
		^'0xf4'.
	
]

{ #category : #'as yet unclassified' }
FogVMDelegatecall class >> description [ 
	^ 'Message-call into this account with an alternative accounts code, but persisting the current values for it sender and it value'
]

{ #category : #generated }
FogVMDelegatecall class >> expectedPops [
		^6.
	
]

{ #category : #generated }
FogVMDelegatecall class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMDelegatecall class >> gas [
		^ self gasTable at: #gasDelegateCall.

]

{ #category : #generated }
FogVMDelegatecall class >> goCode [
	^ 'func opDelegateCall(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
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
	'
]

{ #category : #'as yet unclassified' }
FogVMDelegatecall class >> memoryUsage [
		^ self memoryTable at: #memoryDelegateCall.

]

{ #category : #generated }
FogVMDelegatecall class >> mnemonic [
		^'DELEGATECALL'.
	
]

{ #category : #'as yet unclassified' }
FogVMDelegatecall class >> returns [
		^ true.

]
