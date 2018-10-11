"
Bitwise OR operation
"
Class {
	#name : #FogVMOr,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMOr class >> byteCode [
		^'0x17'.
	
]

{ #category : #'as yet unclassified' }
FogVMOr class >> description [ 
	^ 'Bitwise OR operation'
]

{ #category : #generated }
FogVMOr class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMOr class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMOr class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMOr class >> goCode [
	^ 'func opOr(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	y.Or(x, y)

	interpreter.intPool.put(x)
	return nil'
]

{ #category : #generated }
FogVMOr class >> mnemonic [
		^'OR'.
	
]
