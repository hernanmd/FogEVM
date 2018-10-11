"
Get the value of the program counter prior to the increment 
"
Class {
	#name : #FogVMPc,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMPc class >> byteCode [
		^'0x58'.
	
]

{ #category : #'as yet unclassified' }
FogVMPc class >> description [ 
	^ 'Get the value of the program counter prior to the increment '
]

{ #category : #generated }
FogVMPc class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMPc class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMPc class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMPc class >> goCode [
	^ 'func opPc(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(*pc))
	return nil'
]

{ #category : #generated }
FogVMPc class >> mnemonic [
		^'PC'.
	
]
