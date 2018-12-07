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
<doc>
		^'0x07'.
	
]

{ #category : #'as yet unclassified' }
FogVMSmod class >> description [ 
<doc>
	^ 'Signed modulo remainder operation'
]

{ #category : #generated }
FogVMSmod class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMSmod class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMSmod class >> gas [
<doc>
		^ self gasTable at: #GasFastStep.
]

{ #category : #generated }
FogVMSmod class >> goCode [
<doc>
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
<doc>
		^'SMOD'.
	
]
