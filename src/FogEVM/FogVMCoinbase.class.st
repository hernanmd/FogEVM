"
Get the blocks beneficiary address
"
Class {
	#name : #FogVMCoinbase,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCoinbase class >> byteCode [
<doc>
		^'0x41'.
	
]

{ #category : #'as yet unclassified' }
FogVMCoinbase class >> description [ 
<doc>
	^ 'Get the blocks beneficiary address'
]

{ #category : #generated }
FogVMCoinbase class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMCoinbase class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCoinbase class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMCoinbase class >> goCode [
<doc>
	^ 'func opCoinbase(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.evm.Coinbase.Big())
	retu'
]

{ #category : #generated }
FogVMCoinbase class >> mnemonic [
<doc>
		^'COINBASE'.
	
]
