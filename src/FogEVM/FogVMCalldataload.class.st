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
		^'0x35'.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldataload class >> description [ 
	^ 'Get input data of current environment'
]

{ #category : #generated }
FogVMCalldataload class >> expectedPops [
		^1.
	
]

{ #category : #generated }
FogVMCalldataload class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldataload class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMCalldataload class >> goCode [
	^ 'func opCallDataLoad(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetBytes(getDataBig(contract.Input, stack.pop(), big32)))
	'
]

{ #category : #generated }
FogVMCalldataload class >> mnemonic [
		^'CALLDATALOAD'.
	
]
