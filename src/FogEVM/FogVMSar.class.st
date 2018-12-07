"
The SAR instruction (arithmetic shift right) pops 2 values from the stack, first arg1 and then arg2 
"
Class {
	#name : #FogVMSar,
	#superclass : #FogEVMInstruction,
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSar class >> byteCode [
<doc>
		^'0x1d'.
	
]

{ #category : #generated }
FogVMSar class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMSar class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMSar class >> gas [
<doc>
		^ self gasTable at: #GasFastestStep.
]

{ #category : #generated }
FogVMSar class >> goCode [
<doc>
	^ 'func opSAR(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Note, S256 returns (potentially) a new bigint, so were popping, not peeking this one
	shift, value := math.U256(stack.pop()), math.S256(stack.pop())
	defer interpreter.intPool.put(shift) // First operand back into the pool

	if shift.Cmp(common.Big256) >= 0 {
		if value.Sign() >= 0 {
			value.SetUint64(0)
		} else {
			value.SetInt64(-1)
		}
		stack.push(math.U256(value))
		return nil, nil
	}
	n := uint(shift.Uint64())
	value.Rsh(value, n)
	stack.push(math.U256(value))

	return ni'
]

{ #category : #generated }
FogVMSar class >> mnemonic [
<doc>
		^'SAR'.
	
]
