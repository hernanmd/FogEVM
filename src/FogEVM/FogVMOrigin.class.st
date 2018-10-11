"
Get execution origination address
"
Class {
	#name : #FogVMOrigin,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMOrigin class >> byteCode [
		^'0x32'.
	
]

{ #category : #'as yet unclassified' }
FogVMOrigin class >> description [ 
	^ 'Get execution origination address'
]

{ #category : #generated }
FogVMOrigin class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMOrigin class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMOrigin class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMOrigin class >> goCode [
	^ 'func opOrigin(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.evm.Origin.Big())
	return'
]

{ #category : #generated }
FogVMOrigin class >> mnemonic [
		^'ORIGIN'.
	
]
