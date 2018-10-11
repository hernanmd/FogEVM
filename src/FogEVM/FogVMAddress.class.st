"
Get address of currently executing account
"
Class {
	#name : #FogVMAddress,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMAddress class >> byteCode [
		^'0x30'.
	
]

{ #category : #'as yet unclassified' }
FogVMAddress class >> description [ 
	^ 'Get address of currently executing account'
]

{ #category : #generated }
FogVMAddress class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMAddress class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMAddress class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMAddress class >> goCode [
	^ 'func opAddress(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Address().Big())
	retur'
]

{ #category : #generated }
FogVMAddress class >> mnemonic [
		^'ADDRESS'.
	
]
