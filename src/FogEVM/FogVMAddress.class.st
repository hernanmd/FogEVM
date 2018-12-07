"
Get address of currently executing account
"
Class {
	#name : #FogVMAddress,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMAddress class >> byteCode [
<doc>
		^'0x30'.
	
]

{ #category : #'as yet unclassified' }
FogVMAddress class >> description [ 
<doc>
	^ 'Get address of currently executing account'
]

{ #category : #generated }
FogVMAddress class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMAddress class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMAddress class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMAddress class >> goCode [
<doc>
	^ 'func opAddress(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Address().Big())
	retur'
]

{ #category : #generated }
FogVMAddress class >> mnemonic [
<doc>
		^'ADDRESS'.
	
]
