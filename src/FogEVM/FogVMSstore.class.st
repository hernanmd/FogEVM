"
Save word to storage
"
Class {
	#name : #FogVMSstore,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSstore class >> byteCode [
		^'0x55'.
	
]

{ #category : #'as yet unclassified' }
FogVMSstore class >> description [ 
	^ 'Save word to storage'
]

{ #category : #generated }
FogVMSstore class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMSstore class >> expectedPushes [
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMSstore class >> gas [
		^ self gasTable at: #gasSStore.

]

{ #category : #generated }
FogVMSstore class >> goCode [
	^ 'func opSstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	loc := common.BigToHash(stack.pop())
	val := stack.pop()
	interpreter.evm.StateDB.SetState(contract.Address(), loc, common.BigToHash(val))

	interpreter.intPool.put(val)
	return'
]

{ #category : #generated }
FogVMSstore class >> mnemonic [
		^'SSTORE'.
	
]

{ #category : #'as yet unclassified' }
FogVMSstore class >> writes [
		^ true.

]
