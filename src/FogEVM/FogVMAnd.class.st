"
Bitwise AND operation
"
Class {
	#name : #FogVMAnd,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMAnd class >> byteCode [
<doc>
<doc>
		^'0x16'.
	
]

{ #category : #'as yet unclassified' }
FogVMAnd class >> description [ 
<doc>
<doc>
	^ 'Bitwise AND operation'
]

{ #category : #generated }
FogVMAnd class >> expectedPops [
<doc>
<doc>
		^2.
	
]

{ #category : #generated }
FogVMAnd class >> expectedPushes [
<doc>
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMAnd class >> gas [
<doc>
<doc>
		^ self gasTable at: #GasFastestStep.
]

{ #category : #generated }
FogVMAnd class >> goCode [
<doc>
<doc>
	^ 'func opAnd(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.pop()
	stack.push(x.And(x, y))

	interpreter.intPool.put(y)
	return ni'
]

{ #category : #generated }
FogVMAnd class >> mnemonic [
<doc>
<doc>
		^'AND'.
	
]
