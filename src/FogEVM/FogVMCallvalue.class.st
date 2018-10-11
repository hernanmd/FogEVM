"
Get deposited value by the instruction/transaction responsible for this execution
"
Class {
	#name : #FogVMCallvalue,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCallvalue class >> byteCode [
		^'0x34'.
	
]

{ #category : #'as yet unclassified' }
FogVMCallvalue class >> description [ 
	^ 'Get deposited value by the instruction/transaction responsible for this execution'
]

{ #category : #generated }
FogVMCallvalue class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMCallvalue class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCallvalue class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMCallvalue class >> goCode [
	^ 'func opCallValue(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(contract.value))
	ret'
]

{ #category : #generated }
FogVMCallvalue class >> mnemonic [
		^'CALLVALUE'.
	
]
