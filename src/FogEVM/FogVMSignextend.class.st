"
Extend length of twos complement signed integer
"
Class {
	#name : #FogVMSignextend,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSignextend class >> byteCode [
		^'0x0b'.
	
]

{ #category : #'as yet unclassified' }
FogVMSignextend class >> description [ 
	^ 'Extend length of twos complement signed integer'
]

{ #category : #generated }
FogVMSignextend class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMSignextend class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMSignextend class >> gas [
		^ self gasTable at: #GasFastStep.

]

{ #category : #generated }
FogVMSignextend class >> goCode [
	^ 'func opSignExtend(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	back := stack.pop()
	if back.Cmp(big.NewInt(31)) < 0 {
		bit := uint(back.Uint64()*8 + 7)
		num := stack.pop()
		mask := back.Lsh(common.Big1, bit)
		mask.Sub(mask, common.Big1)
		if num.Bit(int(bit)) > 0 {
			num.Or(num, mask.Not(mask))
		} else {
			num.And(num, mask)
		}

		stack.push(math.U256(num))
	}

	interpreter.intPool.put(back)
	re'
]

{ #category : #generated }
FogVMSignextend class >> mnemonic [
		^'SIGNEXTEND'.
	
]
