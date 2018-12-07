"
Modulo multiplication operation
"
Class {
	#name : #FogVMMulmod,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMMulmod class >> byteCode [
<doc>
		^'0x09'.
	
]

{ #category : #'as yet unclassified' }
FogVMMulmod class >> description [ 
<doc>
	^ 'Modulo multiplication operation'
]

{ #category : #generated }
FogVMMulmod class >> expectedPops [
<doc>
		^3.
	
]

{ #category : #generated }
FogVMMulmod class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMMulmod class >> gas [
<doc>
		^ self gasTable at: #GasMidStep.
]

{ #category : #generated }
FogVMMulmod class >> goCode [
<doc>
	^ 'func opMulmod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y, z := stack.pop(), stack.pop(), stack.pop()
	if z.Cmp(bigZero) > 0 {
		x.Mul(x, y)
		x.Mod(x, z)
		stack.push(math.U256(x))
	} else {
		stack.push(x.SetUint64(0))
	}
	interpreter.intPool.put(y, z)
	return nil, nil
}

// opSHL implements Shift Left
// The SHL instruction (shift left) pops 2 values from the stack, first arg1 and then arg2,
// and pushes on the stack arg2 shifted to the left by arg1 num'
]

{ #category : #generated }
FogVMMulmod class >> mnemonic [
<doc>
		^'MULMOD'.
	
]
