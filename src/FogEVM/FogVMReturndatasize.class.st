"
Documentation says nothing about
"
Class {
	#name : #FogVMReturndatasize,
	#superclass : #FogEVMInstruction,
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMReturndatasize class >> byteCode [
	^ '0x3d'
]

{ #category : #generated }
FogVMReturndatasize class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMReturndatasize class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMReturndatasize class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMReturndatasize class >> goCode [
	^ 'func opReturnDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(uint64(len(interpreter.returnData))))'
]

{ #category : #generated }
FogVMReturndatasize class >> mnemonic [
		^'RETURNDATASIZE'.
	
]
