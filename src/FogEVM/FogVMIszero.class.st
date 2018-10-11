"
Simple not operator
"
Class {
	#name : #FogVMIszero,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMIszero class >> byteCode [
		^'0x15'.
	
]

{ #category : #'as yet unclassified' }
FogVMIszero class >> description [ 
	^ 'Simple not operator'
]

{ #category : #generated }
FogVMIszero class >> expectedPops [
		^1.
	
]

{ #category : #generated }
FogVMIszero class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMIszero class >> gas [
		^ self gasTable at: #GasFastestStep.

]

{ #category : #generated }
FogVMIszero class >> goCode [
	^ 'func opIszero(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x := stack.peek()
	if x.Sign() > 0 {
		x.SetUint64(0)
	} else {
		x.SetUint64(1)
	}
	return'
]

{ #category : #generated }
FogVMIszero class >> mnemonic [
		^'ISZERO'.
	
]
