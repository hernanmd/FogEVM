"
Exponential operation
"
Class {
	#name : #FogVMExp,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMExp class >> byteCode [
<doc>
		^'0x0a'.
	
]

{ #category : #'as yet unclassified' }
FogVMExp class >> description [ 
<doc>
	^ 'Exponential operation'
]

{ #category : #generated }
FogVMExp class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMExp class >> expectedPushes [
<doc>
	^ 1
]

{ #category : #'as yet unclassified' }
FogVMExp class >> gas [
<doc>
		^ self gasTable at: #gasExp.
]

{ #category : #generated }
FogVMExp class >> goCode [
<doc>
	^ 'func opExp(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	base, exponent := stack.pop(), stack.pop()
	stack.push(math.Exp(base, exponent))

	interpreter.intPool.put(base, exponent)

	return ni'
]

{ #category : #generated }
FogVMExp class >> mnemonic [
<doc>
		^'EXP'.
	
]
