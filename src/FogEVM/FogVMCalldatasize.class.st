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
<doc>
		^'0x36'.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldatasize class >> description [ 
<doc>
	^ 'Get size of input data in current environment'
]

{ #category : #generated }
FogVMCalldatasize class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMCalldatasize class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldatasize class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMCalldatasize class >> goCode [
<doc>
	^ 'func opCallDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetInt64(int64(len(contract.Input))))
	'
]

{ #category : #generated }
FogVMCalldatasize class >> mnemonic [
<doc>
		^'CALLDATASIZE'.
	
]
