"
Get balance of the given account
"
Class {
	#name : #FogVMBalance,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMBalance class >> byteCode [
<doc>
		^'0x31'.
	
]

{ #category : #'as yet unclassified' }
FogVMBalance class >> description [ 
<doc>
	^ 'Get balance of the given account'
]

{ #category : #generated }
FogVMBalance class >> expectedPops [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMBalance class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMBalance class >> gas [
<doc>
		^ self gasTable at: #gasBalance.
]

{ #category : #generated }
FogVMBalance class >> goCode [
<doc>
	^ 'func opBalance(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.Set(interpreter.evm.StateDB.GetBalance(common.BigToAddress(slot)))
	retur'
]

{ #category : #generated }
FogVMBalance class >> mnemonic [
<doc>
		^'BALANCE'.
	
]
