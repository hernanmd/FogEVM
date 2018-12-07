"
Get execution origination address
"
Class {
	#name : #FogVMOrigin,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMOrigin class >> byteCode [
<doc>
		^'0x32'.
	
]

{ #category : #'as yet unclassified' }
FogVMOrigin class >> description [ 
<doc>
	^ 'Get execution origination address'
]

{ #category : #generated }
FogVMOrigin class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMOrigin class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMOrigin class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMOrigin class >> goCode [
<doc>
	^ 'func opOrigin(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.evm.Origin.Big())
	return'
]

{ #category : #generated }
FogVMOrigin class >> mnemonic [
<doc>
		^'ORIGIN'.
	
]
