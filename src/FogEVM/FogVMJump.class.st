"
Alter the program counter
"
Class {
	#name : #FogVMJump,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMJump class >> byteCode [
<doc>
		^'0x56'.
	
]

{ #category : #'as yet unclassified' }
FogVMJump class >> description [ 
<doc>
	^ 'Alter the program counter'
]

{ #category : #generated }
FogVMJump class >> expectedPops [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMJump class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMJump class >> gas [
<doc>
		^ self gasTable at: #GasMidStep.
]

{ #category : #generated }
FogVMJump class >> goCode [
<doc>
	^ 'func opJump(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	pos := stack.pop()
	if !contract.validJumpdest(pos) {
		nop := contract.GetOp(pos.Uint64())
		return nil, fmt.Errorf("invalid jump destination (%v) %v", nop, pos)
	}
	*pc = pos.Uint64()

	interpreter.intPool.put(pos)
	return n'
]

{ #category : #'as yet unclassified' }
FogVMJump class >> jumps [
<doc>
		^ true.
]

{ #category : #generated }
FogVMJump class >> mnemonic [
<doc>
		^'JUMP'.
	
]

{ #category : #testing }
FogVMJump >> isStrictJump [
	^ true 
]
