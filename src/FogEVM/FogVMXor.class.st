"
Bitwise XOR operation
"
Class {
	#name : #FogVMXor,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMXor class >> byteCode [
		^'0x18'.
	
]

{ #category : #'as yet unclassified' }
FogVMXor class >> description [ 
	^ 'Bitwise XOR operation'
]

{ #category : #generated }
FogVMXor class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMXor class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMXor class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMXor class >> goCode [
	^ 'func opXor(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	y.Xor(x, y)

	interpreter.intPool.put(x)
	return ni'
]

{ #category : #generated }
FogVMXor class >> mnemonic [
		^'XOR'.
	
]
