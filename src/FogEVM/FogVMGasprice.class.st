"
Get price of gas in current environment
"
Class {
	#name : #FogVMGasprice,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMGasprice class >> byteCode [
		^'0x3a'.
	
]

{ #category : #'as yet unclassified' }
FogVMGasprice class >> description [ 
	^ 'Get price of gas in current environment'
]

{ #category : #generated }
FogVMGasprice class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMGasprice class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMGasprice class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMGasprice class >> goCode [
	^ 'func opGasprice(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(interpreter.evm.GasPrice))
	retu'
]

{ #category : #generated }
FogVMGasprice class >> mnemonic [
		^'GASPRICE'.
	
]
