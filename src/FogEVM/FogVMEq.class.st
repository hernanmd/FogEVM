"
Equality comparison
"
Class {
	#name : #FogVMEq,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMEq class >> byteCode [
		^'0x14'.
	
]

{ #category : #'as yet unclassified' }
FogVMEq class >> description [ 
	^ 'Equality comparison'
]

{ #category : #generated }
FogVMEq class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMEq class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMEq class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMEq class >> goCode [
	^ 'func opEq(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) == 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil'
]

{ #category : #generated }
FogVMEq class >> mnemonic [
		^'EQ'.
	
]
