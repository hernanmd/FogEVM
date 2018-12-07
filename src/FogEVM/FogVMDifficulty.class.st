"
Get the blocks difficulty
"
Class {
	#name : #FogVMDifficulty,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMDifficulty class >> byteCode [
<doc>
		^'0x44'.
	
]

{ #category : #'as yet unclassified' }
FogVMDifficulty class >> description [ 
<doc>
	^ 'Get the blocks difficulty'
]

{ #category : #generated }
FogVMDifficulty class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMDifficulty class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMDifficulty class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMDifficulty class >> goCode [
<doc>
	^ 'func opDifficulty(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.Difficulty)))
	re'
]

{ #category : #generated }
FogVMDifficulty class >> mnemonic [
<doc>
		^'DIFFICULTY'.
	
]
