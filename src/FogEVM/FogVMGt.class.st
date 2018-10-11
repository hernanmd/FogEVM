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
		^'0x11'.
	
]

{ #category : #'as yet unclassified' }
FogVMGt class >> description [ 
	^ 'Greater-than comparison'
]

{ #category : #generated }
FogVMGt class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMGt class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMGt class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMGt class >> goCode [
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
		^'GT'.
	
]
