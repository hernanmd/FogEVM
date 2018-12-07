"
Get deposited value by the instruction/transaction responsible for this execution
"
Class {
	#name : #FogVMCallvalue,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCallvalue class >> byteCode [
<doc>
		^'0x34'.
	
]

{ #category : #'as yet unclassified' }
FogVMCallvalue class >> description [ 
<doc>
	^ 'Get deposited value by the instruction/transaction responsible for this execution'
]

{ #category : #generated }
FogVMCallvalue class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMCallvalue class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCallvalue class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMCallvalue class >> goCode [
<doc>
	^ 'func opCallValue(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(contract.value))
	ret'
]

{ #category : #generated }
FogVMCallvalue class >> mnemonic [
<doc>
		^'CALLVALUE'.
	
]
