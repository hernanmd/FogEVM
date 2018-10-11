"
Addition operation
"
Class {
	#name : #FogVMAdd,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMAdd class >> byteCode [
	^ '0x01'
]

{ #category : #'as yet unclassified' }
FogVMAdd class >> description [ 
	^ 'Addition operation'
]

{ #category : #generated }
FogVMAdd class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMAdd class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMAdd class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMAdd class >> goCode [
	^ 'func opAdd(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	math.U256(y.Add(x, y))

	interpreter.intPool.put(x)
	return ni'
]

{ #category : #generated }
FogVMAdd class >> mnemonic [
		^'ADD'.
	
]
