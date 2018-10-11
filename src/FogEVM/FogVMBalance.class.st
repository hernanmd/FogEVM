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
		^'0x31'.
	
]

{ #category : #'as yet unclassified' }
FogVMBalance class >> description [ 
	^ 'Get balance of the given account'
]

{ #category : #generated }
FogVMBalance class >> expectedPops [
		^1.
	
]

{ #category : #generated }
FogVMBalance class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMBalance class >> gas [
		^ self gasTable at: #gasBalance.

]

{ #category : #generated }
FogVMBalance class >> goCode [
	^ 'func opBalance(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.Set(interpreter.evm.StateDB.GetBalance(common.BigToAddress(slot)))
	retur'
]

{ #category : #generated }
FogVMBalance class >> mnemonic [
		^'BALANCE'.
	
]
