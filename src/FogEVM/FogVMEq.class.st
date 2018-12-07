"
Equality comparison
"
Class {
	#name : #FogVMEq,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMEq class >> byteCode [
<doc>
		^'0x14'.
	
]

{ #category : #'as yet unclassified' }
FogVMEq class >> description [ 
<doc>
	^ 'Equality comparison'
]

{ #category : #generated }
FogVMEq class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMEq class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMEq class >> gas [
<doc>
		^ self gasTable at: #GasFastestStep.
]

{ #category : #generated }
FogVMEq class >> goCode [
<doc>
	^ 'func opEq(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) == 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil'
]

{ #category : #generated }
FogVMEq class >> mnemonic [
<doc>
		^'EQ'.
	
]
