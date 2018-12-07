"
Bitwise OR operation
"
Class {
	#name : #FogVMOr,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMOr class >> byteCode [
<doc>
		^'0x17'.
	
]

{ #category : #'as yet unclassified' }
FogVMOr class >> description [ 
<doc>
	^ 'Bitwise OR operation'
]

{ #category : #generated }
FogVMOr class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMOr class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMOr class >> gas [
<doc>
		^ self gasTable at: #GasFastestStep.
]

{ #category : #generated }
FogVMOr class >> goCode [
<doc>
	^ 'func opOr(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	y.Or(x, y)

	interpreter.intPool.put(x)
	return nil'
]

{ #category : #generated }
FogVMOr class >> mnemonic [
<doc>
		^'OR'.
	
]
