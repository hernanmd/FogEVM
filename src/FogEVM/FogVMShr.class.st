"
Shift val right by shift bits, filling with zero bits.
"
Class {
	#name : #FogVMShr,
	#superclass : #FogEVMInstruction,
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMShr class >> byteCode [
		^'0x1c'.
	
]

{ #category : #generated }
FogVMShr class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMShr class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMShr class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMShr class >> goCode [
	^ 'func opSHR(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Note, second operand is left in the stack; accumulate result into it, and no need to push it afterwards
	shift, value := math.U256(stack.pop()), math.U256(stack.peek())
	defer interpreter.intPool.put(shift) // First operand back into the pool

	if shift.Cmp(common.Big256) >= 0 {
		value.SetUint64(0)
		return nil, nil
	}
	n := uint(shift.Uint64())
	math.U256(value.Rsh(value, n))

	return nil, nil
}

// opSAR implements Arithmetic Shift Right
// The SAR instruction (arithmetic shift right) pops 2 values from the stack, first arg1 and then arg2,
// and pushes on the stack arg2 shifted to the right by arg1 number of bits with sign e'
]

{ #category : #generated }
FogVMShr class >> mnemonic [
		^'SHR'.
	
]
