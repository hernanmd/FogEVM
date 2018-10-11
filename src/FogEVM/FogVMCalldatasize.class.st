"
Get size of input data in current environment
"
Class {
	#name : #FogVMCalldatasize,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCalldatasize class >> byteCode [
		^'0x36'.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldatasize class >> description [ 
	^ 'Get size of input data in current environment'
]

{ #category : #generated }
FogVMCalldatasize class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMCalldatasize class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldatasize class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMCalldatasize class >> goCode [
	^ 'func opCallDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetInt64(int64(len(contract.Input))))
	'
]

{ #category : #generated }
FogVMCalldatasize class >> mnemonic [
		^'CALLDATASIZE'.
	
]
