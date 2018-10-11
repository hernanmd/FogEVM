"
Get caller address
"
Class {
	#name : #FogVMCaller,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCaller class >> byteCode [
		^'0x33'.
	
]

{ #category : #'as yet unclassified' }
FogVMCaller class >> description [ 
	^ 'Get caller address'
]

{ #category : #generated }
FogVMCaller class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMCaller class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCaller class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMCaller class >> goCode [
	^ 'func opCaller(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Caller().Big())
	return'
]

{ #category : #generated }
FogVMCaller class >> mnemonic [
		^'CALLER'.
	
]
