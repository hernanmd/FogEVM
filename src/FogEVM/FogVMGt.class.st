"
Greater-than comparison
"
Class {
	#name : #FogVMGt,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMGt class >> byteCode [
<doc>
		^'0x11'.
	
]

{ #category : #'as yet unclassified' }
FogVMGt class >> description [ 
<doc>
	^ 'Greater-than comparison'
]

{ #category : #generated }
FogVMGt class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMGt class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMGt class >> gas [
<doc>
		^ self gasTable at: #GasFastestStep.
]

{ #category : #generated }
FogVMGt class >> goCode [
<doc>
	^ 'func opGt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) > 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil'
]

{ #category : #generated }
FogVMGt class >> mnemonic [
<doc>
		^'GT'.
	
]
