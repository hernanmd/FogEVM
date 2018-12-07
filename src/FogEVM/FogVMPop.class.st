"
Remove item from stack
"
Class {
	#name : #FogVMPop,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMPop class >> byteCode [
<doc>
		^'0x50'.
	
]

{ #category : #'as yet unclassified' }
FogVMPop class >> description [ 
<doc>
	^ 'Remove item from stack'
]

{ #category : #generated }
FogVMPop class >> expectedPops [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMPop class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMPop class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMPop class >> goCode [
<doc>
	^ 'func opPop(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	interpreter.intPool.put(stack.pop())
	return ni'
]

{ #category : #generated }
FogVMPop class >> mnemonic [
<doc>
		^'POP'.
	
]
