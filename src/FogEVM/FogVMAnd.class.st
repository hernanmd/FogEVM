"
Bitwise AND operation
"
Class {
	#name : #FogVMAnd,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMAnd class >> byteCode [
		^'0x16'.
	
]

{ #category : #'as yet unclassified' }
FogVMAnd class >> description [ 
	^ 'Bitwise AND operation'
]

{ #category : #generated }
FogVMAnd class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMAnd class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMAnd class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMAnd class >> goCode [
	^ 'func opAnd(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.pop()
	stack.push(x.And(x, y))

	interpreter.intPool.put(y)
	return ni'
]

{ #category : #generated }
FogVMAnd class >> mnemonic [
		^'AND'.
	
]
