"
Get the blocks number
"
Class {
	#name : #FogVMNumber,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMNumber class >> byteCode [
<doc>
		^'0x43'.
	
]

{ #category : #'as yet unclassified' }
FogVMNumber class >> description [ 
<doc>
	^ 'Get the blocks number'
]

{ #category : #generated }
FogVMNumber class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMNumber class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMNumber class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMNumber class >> goCode [
<doc>
	^ 'func opNumber(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.BlockNumber)))
	return'
]

{ #category : #generated }
FogVMNumber class >> mnemonic [
<doc>
		^'NUMBER'.
	
]
