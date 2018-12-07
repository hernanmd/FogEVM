"
Get the size of active memory in bytes
"
Class {
	#name : #FogVMMsize,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMMsize class >> byteCode [
<doc>
		^'0x59'.
	
]

{ #category : #'as yet unclassified' }
FogVMMsize class >> description [ 
<doc>
	^ 'Get the size of active memory in bytes'
]

{ #category : #generated }
FogVMMsize class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMMsize class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMMsize class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMMsize class >> goCode [
<doc>
	^ 'func opMsize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetInt64(int64(memory.Len())))
	return '
]

{ #category : #generated }
FogVMMsize class >> mnemonic [
<doc>
		^'MSIZE'.
	
]
