"
Less-than comparison
"
Class {
	#name : #FogVMLt,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMLt class >> byteCode [
		^'0x10'.
	
]

{ #category : #'as yet unclassified' }
FogVMLt class >> description [ 
	^ 'Less-than comparison'
]

{ #category : #generated }
FogVMLt class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMLt class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMLt class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMLt class >> goCode [
	^ 'func opLt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) < 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil'
]

{ #category : #generated }
FogVMLt class >> mnemonic [
		^'LT'.
	
]
