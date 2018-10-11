"
Bitwise NOT operation
"
Class {
	#name : #FogVMNot,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMNot class >> byteCode [
		^'0x19'.
	
]

{ #category : #'as yet unclassified' }
FogVMNot class >> description [ 
	^ 'Bitwise NOT operation'
]

{ #category : #generated }
FogVMNot class >> expectedPops [
		^1.
	
]

{ #category : #generated }
FogVMNot class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMNot class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMNot class >> goCode [
	^ 'func opNot(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x := stack.peek()
	math.U256(x.Not(x))
	return ni'
]

{ #category : #generated }
FogVMNot class >> mnemonic [
		^'NOT'.
	
]
