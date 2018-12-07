"
Get caller address
"
Class {
	#name : #FogVMCaller,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCaller class >> byteCode [
<doc>
		^'0x33'.
	
]

{ #category : #'as yet unclassified' }
FogVMCaller class >> description [ 
<doc>
	^ 'Get caller address'
]

{ #category : #generated }
FogVMCaller class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMCaller class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCaller class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMCaller class >> goCode [
<doc>
	^ 'func opCaller(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Caller().Big())
	return'
]

{ #category : #generated }
FogVMCaller class >> mnemonic [
<doc>
		^'CALLER'.
	
]
