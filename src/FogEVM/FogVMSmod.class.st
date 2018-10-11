"
Signed modulo remainder operation
"
Class {
	#name : #FogVMSmod,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSmod class >> byteCode [
		^'0x07'.
	
]

{ #category : #'as yet unclassified' }
FogVMSmod class >> description [ 
	^ 'Signed modulo remainder operation'
]

{ #category : #generated }
FogVMSmod class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMSmod class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMSmod class >> gas [
		^ self gasTable at: #GasFastStep.

]

{ #category : #generated }
FogVMSmod class >> goCode [
	^ 'func opSmod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := math.S256(stack.pop()), math.S256(stack.pop())
	res := interpreter.intPool.getZero()

	if y.Sign() == 0 {
		stack.push(res)
	} else {
		if x.Sign() < 0 {
			res.Mod(x.Abs(x), y.Abs(y))
			res.Neg(res)
		} else {
			res.Mod(x.Abs(x), y.Abs(y))
		}
		stack.push(math.U256(res))
	}
	interpreter.intPool.put(x, y)
	return n'
]

{ #category : #generated }
FogVMSmod class >> mnemonic [
		^'SMOD'.
	
]
