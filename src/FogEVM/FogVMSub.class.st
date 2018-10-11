"
Subtraction operation
"
Class {
	#name : #FogVMSub,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSub class >> byteCode [
		^'0x03'.
	
]

{ #category : #'as yet unclassified' }
FogVMSub class >> description [ 
	^ 'Subtraction operation'
]

{ #category : #generated }
FogVMSub class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMSub class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMSub class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMSub class >> goCode [
	^ 'func opSub(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	math.U256(y.Sub(x, y))

	interpreter.intPool.put(x)
	return ni'
]

{ #category : #generated }
FogVMSub class >> mnemonic [
		^'SUB'.
	
]
