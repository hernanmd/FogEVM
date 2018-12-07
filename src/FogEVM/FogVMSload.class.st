"
Load word from storage
"
Class {
	#name : #FogVMSload,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSload class >> byteCode [
<doc>
		^'0x54'.
	
]

{ #category : #'as yet unclassified' }
FogVMSload class >> description [ 
<doc>
	^ 'Load word from storage'
]

{ #category : #generated }
FogVMSload class >> expectedPops [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMSload class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMSload class >> gas [
<doc>
		^ self gasTable at: #gasSLoad.
]

{ #category : #generated }
FogVMSload class >> goCode [
<doc>
	^ 'func opSload(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	loc := stack.peek()
	val := interpreter.evm.StateDB.GetState(contract.Address(), common.BigToHash(loc))
	loc.SetBytes(val.Bytes())
	return '
]

{ #category : #generated }
FogVMSload class >> mnemonic [
<doc>
		^'SLOAD'.
	
]
