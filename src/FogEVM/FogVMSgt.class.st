"
Signed greater-than comparison
"
Class {
	#name : #FogVMSgt,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSgt class >> byteCode [
<doc>
		^'0x13'.
	
]

{ #category : #'as yet unclassified' }
FogVMSgt class >> description [ 
<doc>
	^ 'Signed greater-than comparison'
]

{ #category : #generated }
FogVMSgt class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMSgt class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMSgt class >> gas [
<doc>
		^ self gasTable at: #GasFastestStep.
]

{ #category : #generated }
FogVMSgt class >> goCode [
<doc>
	^ 'func opSgt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()

	xSign := x.Cmp(tt255)
	ySign := y.Cmp(tt255)

	switch {
	case xSign >= 0 && ySign < 0:
		y.SetUint64(0)

	case xSign < 0 && ySign >= 0:
		y.SetUint64(1)

	default:
		if x.Cmp(y) > 0 {
			y.SetUint64(1)
		} else {
			y.SetUint64(0)
		}
	}
	interpreter.intPool.put(x)
	return ni'
]

{ #category : #generated }
FogVMSgt class >> mnemonic [
<doc>
		^'SGT'.
	
]
