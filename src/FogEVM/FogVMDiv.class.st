"
Integer division operation
"
Class {
	#name : #FogVMDiv,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMDiv class >> byteCode [
		^'0x04'.
	
]

{ #category : #'as yet unclassified' }
FogVMDiv class >> description [ 
	^ 'Integer division operation'
]

{ #category : #generated }
FogVMDiv class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMDiv class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMDiv class >> gas [
		^ self gasTable at: #GasFastStep.

]

{ #category : #generated }
FogVMDiv class >> goCode [
	^ 'func opDiv(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if y.Sign() != 0 {
		math.U256(y.Div(x, y))
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return ni'
]

{ #category : #generated }
FogVMDiv class >> mnemonic [
		^'DIV'.
	
]
