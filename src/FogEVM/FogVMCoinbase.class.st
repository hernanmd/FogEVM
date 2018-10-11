"
Get the block's beneficiary address
"
Class {
	#name : #FogVMCoinbase,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCoinbase class >> byteCode [
		^'0x41'.
	
]

{ #category : #'as yet unclassified' }
FogVMCoinbase class >> description [ 
	^ 'Get the block's beneficiary address'
]

{ #category : #generated }
FogVMCoinbase class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMCoinbase class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCoinbase class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMCoinbase class >> goCode [
	^ 'func opCoinbase(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.evm.Coinbase.Big())
	retu'
]

{ #category : #generated }
FogVMCoinbase class >> mnemonic [
		^'COINBASE'.
	
]
