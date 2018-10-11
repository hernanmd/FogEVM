"
Modulo remainder operation
"
Class {
	#name : #FogVMMod,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMMod class >> byteCode [
		^'0x06'.
	
]

{ #category : #'as yet unclassified' }
FogVMMod class >> description [ 
	^ 'Modulo remainder operation'
]

{ #category : #generated }
FogVMMod class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMMod class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMMod class >> gas [
		^ self gasTable at: #GasFastStep.

]

{ #category : #generated }
FogVMMod class >> goCode [
	^ 'func opMod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.pop()
	if y.Sign() == 0 {
		stack.push(x.SetUint64(0))
	} else {
		stack.push(math.U256(x.Mod(x, y)))
	}
	interpreter.intPool.put(y)
	return ni'
]

{ #category : #generated }
FogVMMod class >> mnemonic [
		^'MOD'.
	
]
