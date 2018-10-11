"
Get the block's number
"
Class {
	#name : #FogVMNumber,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMNumber class >> byteCode [
		^'0x43'.
	
]

{ #category : #'as yet unclassified' }
FogVMNumber class >> description [ 
	^ 'Get the blocks number'
]

{ #category : #generated }
FogVMNumber class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMNumber class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMNumber class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMNumber class >> goCode [
	^ 'func opNumber(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.BlockNumber)))
	return'
]

{ #category : #generated }
FogVMNumber class >> mnemonic [
		^'NUMBER'.
	
]
