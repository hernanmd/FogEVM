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
<doc>
	^ '0x3d'
]

{ #category : #generated }
FogVMReturndatasize class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMReturndatasize class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMReturndatasize class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMReturndatasize class >> goCode [
<doc>
	^ 'func opReturnDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(uint64(len(interpreter.returnData))))'
]

{ #category : #generated }
FogVMReturndatasize class >> mnemonic [
<doc>
		^'RETURNDATASIZE'.
	
]
