"
Get input data of current environment
"
Class {
	#name : #FogVMCalldataload,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCalldataload class >> byteCode [
<doc>
		^'0x35'.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldataload class >> description [ 
<doc>
	^ 'Get input data of current environment'
]

{ #category : #generated }
FogVMCalldataload class >> expectedPops [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMCalldataload class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldataload class >> gas [
<doc>
		^ self gasTable at: #GasFastestStep.
]

{ #category : #generated }
FogVMCalldataload class >> goCode [
<doc>
	^ 'func opCallDataLoad(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetBytes(getDataBig(contract.Input, stack.pop(), big32)))
	'
]

{ #category : #generated }
FogVMCalldataload class >> mnemonic [
<doc>
		^'CALLDATALOAD'.
	
]
