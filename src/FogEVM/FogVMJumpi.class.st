"
Conditionally alter the program counter
"
Class {
	#name : #FogVMJumpi,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMJumpi class >> byteCode [
<doc>
		^'0x57'.
	
]

{ #category : #'as yet unclassified' }
FogVMJumpi class >> description [ 
<doc>
	^ 'Conditionally alter the program counter'
]

{ #category : #generated }
FogVMJumpi class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMJumpi class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMJumpi class >> gas [
<doc>
		^ self gasTable at: #GasSlowStep.
]

{ #category : #generated }
FogVMJumpi class >> goCode [
<doc>
	^ 'func opJumpi(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	pos, cond := stack.pop(), stack.pop()
	if cond.Sign() != 0 {
		if !contract.validJumpdest(pos) {
			nop := contract.GetOp(pos.Uint64())
			return nil, fmt.Errorf("invalid jump destination (%v) %v", nop, pos)
		}
		*pc = pos.Uint64()
	} else {
		*pc++
	}

	interpreter.intPool.put(pos, cond)
	return '
]

{ #category : #'as yet unclassified' }
FogVMJumpi class >> jumps [
<doc>
		^ true.
]

{ #category : #generated }
FogVMJumpi class >> mnemonic [
<doc>
		^'JUMPI'.
	
]
