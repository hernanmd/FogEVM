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
<doc>
		^'0x0b'.
	
]

{ #category : #'as yet unclassified' }
FogVMSignextend class >> description [ 
<doc>
	^ 'Extend length of twos complement signed integer'
]

{ #category : #generated }
FogVMSignextend class >> expectedPops [
<doc>
	^ 2
]

{ #category : #generated }
FogVMSignextend class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMSignextend class >> gas [
<doc>
		^ self gasTable at: #GasFastStep.
]

{ #category : #generated }
FogVMSignextend class >> goCode [
<doc>
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
<doc>
		^'SIGNEXTEND'.
	
]
