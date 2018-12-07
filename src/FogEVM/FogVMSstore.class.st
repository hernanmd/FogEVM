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
<doc>
		^'0x55'.
	
]

{ #category : #'as yet unclassified' }
FogVMSstore class >> description [ 
<doc>
	^ 'Save word to storage'
]

{ #category : #generated }
FogVMSstore class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMSstore class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMSstore class >> gas [
<doc>
		^ self gasTable at: #gasSStore.
]

{ #category : #generated }
FogVMSstore class >> goCode [
<doc>
	^ 'func opSstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	loc := common.BigToHash(stack.pop())
	val := stack.pop()
	interpreter.evm.StateDB.SetState(contract.Address(), loc, common.BigToHash(val))

	interpreter.intPool.put(val)
	return'
]

{ #category : #generated }
FogVMSstore class >> mnemonic [
<doc>
		^'SSTORE'.
	
]

{ #category : #'as yet unclassified' }
FogVMSstore class >> writes [
<doc>
		^ true.
]
