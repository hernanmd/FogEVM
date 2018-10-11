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
		^'0x44'.
	
]

{ #category : #'as yet unclassified' }
FogVMDifficulty class >> description [ 
	^ 'Get the blocks difficulty'
]

{ #category : #generated }
FogVMDifficulty class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMDifficulty class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMDifficulty class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMDifficulty class >> goCode [
	^ 'func opDifficulty(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.Difficulty)))
	re'
]

{ #category : #generated }
FogVMDifficulty class >> mnemonic [
		^'DIFFICULTY'.
	
]
