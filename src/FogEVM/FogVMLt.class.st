"
Less-than comparison
"
Class {
	#name : #FogVMLt,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMLt class >> byteCode [
<doc>
		^'0x10'.
	
]

{ #category : #'as yet unclassified' }
FogVMLt class >> description [ 
<doc>
	^ 'Less-than comparison'
]

{ #category : #generated }
FogVMLt class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMLt class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMLt class >> gas [
<doc>
		^ self gasTable at: #GasFastestStep.
]

{ #category : #generated }
FogVMLt class >> goCode [
<doc>
	^ 'func opLt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) < 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil'
]

{ #category : #generated }
FogVMLt class >> mnemonic [
<doc>
		^'LT'.
	
]
